#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

extern int decode128_64(unsigned char* source_bitmap, int scan_line_no, char* text);

void catch_err(int err);

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Error: Please provide exactly 1 BMP filename!\n");
        return 101;
    }

    struct stat bmpinfo;
    if (stat(argv[1], &bmpinfo) != 0) {
        fprintf(stderr, "Error: Unable to stat file '%s'.\n", argv[1]);
        return 102;
    }

    char* buf = (char*)malloc(bmpinfo.st_size);
    if (buf == NULL) {
        fprintf(stderr, "Error: Memory allocation failed!\n");
        return 103;
    }

    int fd = open(argv[1], O_RDONLY);
    if (fd == -1) {
        fprintf(stderr, "Error: Cannot open '%s' for reading.\n", argv[1]);
        free(buf);
        return 104;
    }

    int read_bytes = read(fd, buf, bmpinfo.st_size);
    if (read_bytes < 0) {
        fprintf(stderr, "Error: File read error.\n");
        close(fd);
        free(buf);
        return 105;
    }
    close(fd);

    short signature = *(short*)(buf);
    if (signature != 0x4d42) {
        fprintf(stderr, "Error: Not a valid BMP file!\n");
        free(buf);
        return 106;
    }

    unsigned int data_offset = *(unsigned int*)(buf + 10);
    int width = *(int*)(buf + 18);
    int height = *(int*)(buf + 22);
    unsigned short depth = *(unsigned short*)(buf + 28);

    if (width == 600 && height == 50 && depth == 24) {

        unsigned int line = 24;
        char decoded[50] = { 0 };

        int result = decode128_64((unsigned char*)buf + data_offset, line, decoded);
        if (result == 0) {
            printf("Decoded text is: %s\n", decoded);
        }
        else {
            catch_err(result);
        }
    }
    else {
        fprintf(stderr, "Error: Unsupported dimensions/depth!\n");
        free(buf);
        return 107;
    }

    free(buf);
    return 0;
}

void catch_err(int err) {
    switch (err) {
    case 1:
        fprintf(stderr, "Error: Invalid start character!\n");
        break;
    case 2:
        fprintf(stderr, "Error: Checksum incorrect!\n");
        break;
    case 3:
        fprintf(stderr, "Error: Barcode detection failed!\n");
        break;
    case 4:
        fprintf(stderr, "Error: Bar width too big!\n");
        break;
    default:
        fprintf(stderr, "Error: Unknown error code %d.\n", err);
        break;
    }
    exit(err);
}
