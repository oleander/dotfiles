#include <stdio.h>
#include <netdb.h>

main(){
#define HOST_NAME_LEN 255
    char host [HOST_NAME_LEN];
    struct hostent *hp;

    /* get network address of our host */
    gethostname (host, sizeof (host));
    printf("hostname=%s\n",host);

    if ((hp = gethostbyname (host)) == NULL)
        fprintf (stderr, "gethostbyname failed\n");
    if (hp->h_addrtype != AF_INET)
        fprintf (stderr, "host addr type not INET\n");
	    
    printf("h_addr=%d %d %d %d\n",
		    (unsigned char)(hp->h_addr[0]),
		    (unsigned char)(hp->h_addr[1]),
		    (unsigned char)(hp->h_addr[2]),
		    (unsigned char)(hp->h_addr[3]));


}
