#include <stdio.h>

#define cantBits 32


void printBits(size_t const size, void const * const ptr)
{
    unsigned char *b = (unsigned char*) ptr;
    unsigned char byte;
    int i, j;

    for (i=size-1;i>=0;i--)
    {
        for (j=7;j>=0;j--)
        {
            byte = (b[i] >> j) & 1;
            printf("%u", byte);
        }
    }
    puts("");
}


int main(void){
        int a = 255;
        float b = 0.0000075f;
        printBits(sizeof(a), &a);
        printBits(sizeof(b), &b);
        return 0;
}


