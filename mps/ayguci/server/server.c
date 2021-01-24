/*
* Milis Linux Ayguci Server
* Milisarge - 2020
* References:
* http://beej.us/guide/bgipc/output/html/multipage/unixsock.html
*/

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/un.h>
#include <unistd.h>
#include <poll.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
#include "lfs.h"

lua_State* L;

#define SOCK_PATH "/tmp/ayguci.sock"

#define BUFFSIZE 4096

#define AYGUCI_PATH "/usr/milis/ayguci/"
#define SERVER_PATH "/usr/milis/ayguci/server/"
// lua related
void bail(lua_State *L, char *msg){
	fprintf(stderr, "\nFATAL ERROR:\n  %s: %s\n\n",
		msg, lua_tostring(L, -1));
	exit(1);
}

char * split(char str[], char delim[], int order) {
  char *rest=strdup(str), *ret = NULL, *state, *token; 
  int i = 0; 
  for(token = strtok_r(rest, delim, &state); token != NULL; token = strtok_r(NULL, delim, &state)) {
	   i++; 
	   if(order == i) ret = strdup(token); 
	   //printf("%s\n", token); 
  } 
  free(rest); 
  return ret; 
}

const char* lua_stringexpr( lua_State* L, const char* expr,
                            const char* def ) {
  const char* r = def ;
  char buf[1024] = "" ;
  /* Assign the Lua expression to a Lua global variable. */
  sprintf( buf, "evalExpr=%s", expr );
  if ( !luaL_dostring( L, buf ) ) {
    /* Get the value of the global varibable */
    lua_getglobal( L, "evalExpr" );
    if ( lua_isstring( L, -1 ) ) {
      r = lua_tostring( L, -1 );
    } else r=0;
    /* remove lua_getglobal value */
    lua_pop( L, 1 );
  }
  return r ;
}

int is_regular_file(const char *path)
{
    struct stat path_stat;
    stat(path, &path_stat);
    return S_ISREG(path_stat.st_mode);
}

int main(void)
{
	int s, s2, t, len;
	struct sockaddr_un local, remote;
	char reqstr[512] = {0};
	struct pollfd pfd;

	if ((s = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0)) == -1) {
		perror("socket");
		exit(1);
	}

	local.sun_family = AF_UNIX;
	strcpy(local.sun_path, SOCK_PATH);
	unlink(local.sun_path);
	len = strlen(local.sun_path) + sizeof(local.sun_family);
	if (bind(s, (struct sockaddr *)&local, len) == -1) {
		perror("bind");
		exit(1);
	}

	if (listen(s, 5) == -1) {
		perror("listen");
		exit(1);
	}

	for(;;) {
		int done, n;
		printf("Ayguci Daemon Listening...\n");
		fflush(stdout);
		t = sizeof(remote);
		if ((s2 = accept(s, (struct sockaddr *)&remote, &t)) == -1) {
			perror("accept");
			exit(1);
		}

		printf("Connected.\n");
		done = 0;
		const char *resp;
		
		do {
			int rc;
			//printf("Sleeping for 5 seconds, connect the client and exit from client\n");
			//sleep(5);
			pfd.fd = s2;
		    pfd.events = POLLIN;
			rc = poll(&pfd, 1, 15000);
			if (!rc) printf("poll timed out\n");
			if (rc < 0) printf("poll failed\n");
			//printf("events: 0x%x\n", pfd.revents);
			// get request from ayguci client
			n = recv(s2, reqstr, 512, 0);
			reqstr[n] = '\0';
			if (n <= 0) {
				if (n < 0) perror("recv");
				done = 1;
			}
			printf("data recv:%s:\n", reqstr);
			printf("modul:%s:\n",split(reqstr," ",1));
			printf("param:%s:\n",split(reqstr," ",2));
			printf("--------------\n");
			lua_State *L = luaL_newstate();
			luaL_openlibs(L);
			
			// load useful libraries for plugins
			luaL_requiref(L, "lfs", luaopen_lfs, 0);
			if ( luaL_dofile( L, SERVER_PATH "json.lua" ) == 1 ) {
				printf( "Error loading %s\n", "json.lua" );
				//return 1 ;
			}
			if ( luaL_dofile( L, SERVER_PATH "util.lua" ) == 1 ) {
				printf( "Error loading %s\n", "util.lua" );
				//return 1 ;
			}
			if ( luaL_dofile( L, SERVER_PATH "serpent.lua" ) == 1 ) {
				printf( "Error loading %s\n", "serpent.lua" );
				//return 1 ;
			}
			
			char *filename=malloc(512);
			snprintf(filename, 512, AYGUCI_PATH "modules/%s.lua", split(reqstr," ",1));
			// moduller için ayguci server kütüphane yolları tanımlanır.
			// modül yüklenmeden önce
			luaL_dostring(L, "package.path  = '" SERVER_PATH "'..'/?.lua'    .. ';'.. package.path");
			if ( luaL_dofile( L, filename ) == 1 ) {
				printf( "Error loading %s\n", filename );
				resp="{'error':'loading lua file failed!'}";
			}else {	
				// give input to lua set function
				// if there is an input
				if (split(reqstr," ",2)){
					lua_getglobal( L, "input" );
					lua_pushstring(L,split(reqstr," ",2));
					lua_setfield(L, -2, "data");
				}
				// appyly set data
				lua_getglobal(L, "set"); 
				if (lua_pcall(L, 0, 1, 0)){
				  printf("{'warn':'lua code has not set method or failed'}\n");
				}else{
				  printf("set function is run\n");
				}
				// apply get data
				lua_getglobal(L, "get"); 
			    if (lua_pcall(L, 0, 1, 0)){
				  printf("{'warn':'lua code has not get method or failed'}\n");
				}else{
				  printf("get function is run\n");
				}
				if (lua_stringexpr( L, "result", 0 )){
				  resp=lua_stringexpr( L, "result", 0 );
				} else{
				  resp="{'error':'no result return'}";
				}
		    }
			free(filename);
			printf("rsp:%s:\n",resp);

			if (send(s2, resp , strlen(resp), 0) < 0) {
				perror("send");
				done = 1;
			}
			lua_close(L);	
			
			break;
		} while (!done);

		close(s2);
	}
	return 0;
}
