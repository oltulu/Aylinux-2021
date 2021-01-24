/*
* Milis Linux Ayguci Client
* Milisarge - 2020
* References:
* http://beej.us/guide/bgipc/output/html/multipage/unixsock.html
* https://github.com/baskerville/bspwm/blob/master/src/bspc.c#L88
*/

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <poll.h>

#define SOCK_PATH "/tmp/ayguci.sock"
#define BUFFSIZE 4096

int main(int argc, char *argv [])
{
    int s, t, len;
    struct sockaddr_un remote;
    char reply[BUFFSIZE];
    char *reqstr = argv[1];
	reqstr=reqstr ? reqstr : "none";
    if ((s = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0)) == -1) {
        perror("socket");
        exit(1);
    }

    //printf("Trying to connect...\n");

    remote.sun_family = AF_UNIX;
    strcpy(remote.sun_path, SOCK_PATH);
    len = strlen(remote.sun_path) + sizeof(remote.sun_family);
    if (connect(s, (struct sockaddr *)&remote, len) == -1) {
        perror("connect");
        exit(1);
    }
    //printf("Connected.\n");
// interactive mode - set 1 to open
#if 0
    while(printf("> "), fgets(reply, BUFFSIZE, stdin), !feof(stdin)) {
        if (send(s, reply, strlen(reply), 0) == -1) {
            perror("send");
            exit(1);
        }

        if ((t=recv(s, reply, BUFFSIZE, 0)) > 0) {
            reply[t] = '\0';
            printf("echo> %s", reply);
        } else {
            if (t < 0) perror("recv");
            else printf("Server closed connection\n");
            exit(1);
        }
    }
#else
    if (send(s, reqstr, strlen(reqstr), 0) < 0)
	    printf("Send failed\n");
    //else
	    //printf("data sent\n");
	struct pollfd fds[] = {
		{s, POLLIN, 0},
		{STDOUT_FILENO, POLLHUP, 0},
	};

	while (poll(fds, 2, -1) > 0) {
		if (fds[0].revents & POLLIN) {
			if ((t = recv(s, reply, sizeof(reply)-1, 0)) > 0) {
				reply[t] = '\0';
				fprintf(stdout, "%s", reply);
				fflush(stdout);
			} else {
				break;
			}
		}
		if (fds[1].revents & (POLLERR | POLLHUP)) {
			break;
		}
	}
#endif
    close(s);
    return 0;
}
