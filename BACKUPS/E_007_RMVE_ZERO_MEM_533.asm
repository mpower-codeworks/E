
;;;;;;;
;; E ;;
;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a small telnet server ;;
;;     m.power 2026      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; direct conversion from the
; original version in C                 - 3072 bytes exe size
; replace invokes with push/call        - 3072 bytes
; remove dup error handles              - 3072 bytes
; first crinker build                   -  558 bytes
; remove htons import & hard-code port  -  551 bytes
; remove ZeroMemory (win does the init) -  533 bytes

;;;;;;;;;;;;;;;;;;;
;; initial setup ;;
;;;;;;;;;;;;;;;;;;;
.386                   ; Enable 80386 instruction set
.model flat, stdcall   ; 32-bit flat memory model, stdcall calling convention
option casemap:none    ; Preserve symbol case exactly


WSAStartup   PROTO STDCALL :DWORD, :DWORD                 ; init winsock
WSACleanup   PROTO STDCALL                                ; clean up winsock

socket       PROTO STDCALL :DWORD, :DWORD, :DWORD         ; create socket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; remove because we will hard code this ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;htons        PROTO STDCALL :DWORD                        ; host to network short

bind         PROTO STDCALL :DWORD, :DWORD, :DWORD         ; bind socket to address
listen       PROTO STDCALL :DWORD, :DWORD                 ; start listening
accept       PROTO STDCALL :DWORD, :DWORD, :DWORD         ; accept client

send         PROTO STDCALL :DWORD, :DWORD, :DWORD, :DWORD ; send bytes
shutdown     PROTO STDCALL :DWORD, :DWORD                 ; shut down socket I/O
closesocket  PROTO STDCALL :DWORD                         ; close socket

lstrlenA     PROTO STDCALL :DWORD                         ; get ansi string length
Sleep        PROTO STDCALL :DWORD                         ; pause thread
ExitProcess  PROTO STDCALL :DWORD                         ; exit process

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C from winsock2.h / windows.h ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PORT            EQU 5555       ; TCP port number to listen on
MAKEWORD_2_2    EQU 0202h      ; Winsock version 2.2 for WSAStartup

AF_INET         EQU 2          ; IPv4 address family
SOCK_STREAM     EQU 1          ; TCP stream socket type
IPPROTO_TCP     EQU 6          ; TCP protocol

INADDR_ANY      EQU 0          ; Bind to all local network interfaces

INVALID_SOCKET  EQU -1         ; socket()/accept() failure return value
SOCKET_ERROR    EQU -1         ; General Winsock error return value
SD_BOTH         EQU  2         ; Disable both sends and receives for shutdown

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; struct sockaddr_in, enough for bind() ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sockaddr_in STRUCT
    sin_family WORD  ?
    sin_port   WORD  ?
    sin_addr   DWORD ?
    sin_zero   BYTE  8 DUP(?)
sockaddr_in ENDS

.data
;connectedMsg BYTE "Connected to 5555", 13, 10, 0
connectedMsg    BYTE "Connected to 5555", 13, 10
connectedMsgLen EQU  $ - connectedMsg



.data?
wsa           BYTE 512 DUP(?)  ; larger than WSADATA; avoids packing concerns
listen_socket DWORD ?
client_socket DWORD ?
addr_in       sockaddr_in <>

.code
PUBLIC _start

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; send_text(SOCKET s, const char *text)    ;;
;;                                          ;;
;; C equivalent:                            ;;
;;   send(s, text, (int)lstrlenA(text), 0); ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;send_text PROC s:DWORD, pText:DWORD
;    push pText
;    call lstrlenA
;
;    push 0
;    push eax
;    push pText
;    push s
;    call send
;    ret 8
;send_text ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Program entry. Mirrors main() from the C version without using CRT startup. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_start:

    ; if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0) return 1;
    push OFFSET wsa
    push MAKEWORD_2_2
    call WSAStartup
    test eax, eax
    jnz  exit_1

    ; listen_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    push IPPROTO_TCP
    push SOCK_STREAM
    push AF_INET
    call socket
    mov listen_socket, eax

    ; if (listen_socket == INVALID_SOCKET) { WSACleanup(); return 1; }
    cmp eax, INVALID_SOCKET
    jne socket_ok
    jmp fail_wsa

socket_ok:

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; remove because windows auto ;;
    ;; inits addr_in anyway        ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; ZeroMemory(&addr, sizeof(addr));
    ;cld
    ;xor eax, eax
    ;lea edi, addr_in
    ;mov ecx, SIZEOF sockaddr_in / 4
    ;rep stosd

    ; addr.sin_family = AF_INET;
    mov addr_in.sin_family, AF_INET

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; remove because hard-coded ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; addr.sin_port = htons(PORT);
    ;push PORT
    ;call htons
    ;mov addr_in.sin_port, ax
    mov addr_in.sin_port, 0B315h

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; remove because windows auto ;;
    ;; inits addr_in anyway        ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; addr.sin_addr.s_addr = INADDR_ANY;
    ;mov addr_in.sin_addr, INADDR_ANY

    ; if (bind(listen_socket, (struct sockaddr *)&addr, sizeof(addr)) != 0) ...
    push SIZEOF sockaddr_in
    push OFFSET addr_in
    push listen_socket
    call bind
    cmp eax, SOCKET_ERROR
    jne bind_ok
    jmp fail_close_listener

bind_ok:

    ; if (listen(listen_socket, 1) != 0) ...
    push 1
    push listen_socket
    call listen
    cmp eax, SOCKET_ERROR
    jne listen_ok
    jmp fail_close_listener

listen_ok:

    ; client_socket = accept(listen_socket, NULL, NULL);
    push 0
    push 0
    push listen_socket
    call accept
    mov client_socket, eax

    ; if (client_socket != INVALID_SOCKET) { ... }
    cmp eax, INVALID_SOCKET
    je close_listener

    ; send_text(client_socket, "Connected to 5555\r\n");
    ;push OFFSET connectedMsg
    ;push client_socket
    ;call send_text
    push 0
    push connectedMsgLen
    push OFFSET connectedMsg
    push client_socket
    call send

    ; Sleep(1500);
    push 1500
    call Sleep

    ; shutdown(client_socket, SD_BOTH);
    push SD_BOTH
    push client_socket
    call shutdown

    ; closesocket(client_socket);
    push client_socket
    call closesocket

close_listener:

    ; closesocket(listen_socket);
    push listen_socket
    call closesocket

    ; WSACleanup();
    call WSACleanup

    ; return 0;
    push 0
    call ExitProcess

fail_close_listener:

    ; closesocket(listen_socket);
    push listen_socket
    call closesocket

fail_wsa:

    ; WSACleanup();
    call WSACleanup
    jmp exit_1

exit_1:
    push 1
    call ExitProcess

END _start
