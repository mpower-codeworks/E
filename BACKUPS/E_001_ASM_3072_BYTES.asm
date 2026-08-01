
;;;;;;;
;; E ;;
;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a small telnet server ;;
;;     m.power 2026      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; direct conversion from the
; original version in C        - 3072 bytes exe size

;;;;;;;;;;;;;;;;;;;
;; initial setup ;;
;;;;;;;;;;;;;;;;;;;
.386                   ; Enable 80386 instruction set
.model flat, stdcall   ; 32-bit flat memory model, stdcall calling convention
option casemap:none    ; Preserve symbol case exactly


WSAStartup   PROTO STDCALL :DWORD, :DWORD                 ; init winsock
WSACleanup   PROTO STDCALL                                ; clean up winsock

socket       PROTO STDCALL :DWORD, :DWORD, :DWORD         ; create socket
htons        PROTO STDCALL :DWORD                         ; host to network short

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
SD_BOTH         EQU 2          ; Disable both sends and receives for shutdown

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
connectedMsg BYTE "Connected to 5555", 13, 10, 0

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

send_text PROC s:DWORD, pText:DWORD
    invoke lstrlenA, pText
    invoke send, s, pText, eax, 0
    ret 8
send_text ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Program entry. Mirrors main() from the C version without using CRT startup. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_start:

    ; if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0) return 1;
    invoke WSAStartup, MAKEWORD_2_2, ADDR wsa
    test eax, eax
    jnz  exit_1

    ; listen_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    invoke socket, AF_INET, SOCK_STREAM, IPPROTO_TCP
    mov listen_socket, eax

    ; if (listen_socket == INVALID_SOCKET) { WSACleanup(); return 1; }
    cmp eax, INVALID_SOCKET
    jne socket_ok
    invoke WSACleanup
    jmp exit_1

socket_ok:

    ; ZeroMemory(&addr, sizeof(addr));
    xor eax, eax
    lea edi, addr_in
    mov ecx, SIZEOF sockaddr_in / 4
    rep stosd

    ; addr.sin_family = AF_INET;
    mov addr_in.sin_family, AF_INET

    ; addr.sin_port = htons(PORT);
    invoke htons, PORT
    mov addr_in.sin_port, ax

    ; addr.sin_addr.s_addr = INADDR_ANY;
    mov addr_in.sin_addr, INADDR_ANY

    ; if (bind(listen_socket, (struct sockaddr *)&addr, sizeof(addr)) != 0) ...
    invoke bind, listen_socket, ADDR addr_in, SIZEOF sockaddr_in
    cmp eax, SOCKET_ERROR
    jne bind_ok
    invoke closesocket, listen_socket
    invoke WSACleanup
    jmp exit_1

bind_ok:

    ; if (listen(listen_socket, 1) != 0) ...
    invoke listen, listen_socket, 1
    cmp eax, SOCKET_ERROR
    jne listen_ok
    invoke closesocket, listen_socket
    invoke WSACleanup
    jmp exit_1

listen_ok:

    ; client_socket = accept(listen_socket, NULL, NULL);
    invoke accept, listen_socket, 0, 0
    mov client_socket, eax

    ; if (client_socket != INVALID_SOCKET) { ... }
    cmp eax, INVALID_SOCKET
    je close_listener

    ; send_text(client_socket, "Connected to 5555\r\n");
    invoke send_text, client_socket, OFFSET connectedMsg

    ; Sleep(1500);
    invoke Sleep, 1500

    ; shutdown(client_socket, SD_BOTH);
    invoke shutdown, client_socket, SD_BOTH

    ; closesocket(client_socket);
    invoke closesocket, client_socket

close_listener:

    ; closesocket(listen_socket);
    invoke closesocket, listen_socket

    ; WSACleanup();
    invoke WSACleanup

    ; return 0;
    invoke ExitProcess, 0

exit_1:
    invoke ExitProcess, 1

END _start
