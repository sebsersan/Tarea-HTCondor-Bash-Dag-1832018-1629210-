#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** argv) {
        double x;
        char *filename;
        FILE *fd;

        if (argc != 2) {
                printf("This program requires one argument <filename>\n");
                exit(-1);
        }

        filename = argv[1];

        fd = fopen(filename,"r");
        if (fd == NULL) {
                printf("File can not be created\n");
                exit(-1);
        }
	printf("Leyendo de %s...",filename);
        fscanf(fd,"%lf",&x);
	printf(" %lf\n",x);

        fclose(fd);

	return 0;
}
