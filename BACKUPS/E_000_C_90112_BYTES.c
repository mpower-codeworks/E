/*
    / / / / /
  / / E / /
/ / / / /

m.power 2026
a small telnet
server in C

cl build - 90,112 bytes

*/
#define WIN32_LEAN_AND_MEAN
#include <winsock2.h>
#include <windows.h>

#pragma comment(lib, "ws2_32.lib")

#define PORT 5555

static void send_text (
    SOCKET s,
    const char *text)
{
    send (
        s,
        text,
        (int)lstrlenA(text),
        0
    );
}

int main(void)
{
    WSADATA wsa;
    SOCKET  listen_socket;
    SOCKET  client_socket;
    struct  sockaddr_in addr;

    if (
        WSAStartup (
            MAKEWORD (
                2,
                2
            ),
            &wsa) != 0)
        return 1;

    listen_socket = socket (
        AF_INET,
        SOCK_STREAM,
        IPPROTO_TCP
    );
  
    if (listen_socket == INVALID_SOCKET) {
        WSACleanup();
        return 1;
    }

    ZeroMemory (
        &addr,
        sizeof(addr)
    );
    addr.sin_family      = AF_INET;
    addr.sin_port        = htons(PORT);
    addr.sin_addr.s_addr = INADDR_ANY;

    if (
        bind (
            listen_socket,
            (struct sockaddr *)&addr,
            sizeof(addr)) != 0) {
        closesocket(listen_socket);
        WSACleanup();
        return 1;
    }

    if (
        listen(listen_socket,
               1) != 0) {
        closesocket(listen_socket);
        WSACleanup();
        return 1;
    }

    client_socket = accept (
        listen_socket,
        NULL, 
        NULL
    );
  
    if (client_socket != INVALID_SOCKET) {
        send_text (
            client_socket,
            "Connected to 5555\r\n"
        );

        Sleep(1500);

        shutdown (
            client_socket,
            SD_BOTH
        );
        closesocket(client_socket);
    }

    closesocket(listen_socket);
    WSACleanup();

    return 0;
}