/* bob-walker in C */

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main(void)
{
    int x;
    char* mode = getenv ("BOB_MODE");
    char* sportmode = "SPORT";
    for ( x = 0; x < 1000000; x++) {
        printf("beer\n");
        printf("pie\n");
        printf("beard\n");
        if (mode!=NULL) {
            int sport = strcmp(mode, sportmode);
            if ( sport == 0) {
                printf("cricket\n");
                printf("rugby\n");
            }
        }
    }
}
