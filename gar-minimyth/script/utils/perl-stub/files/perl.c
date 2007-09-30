#include <stdio.h>
#include <unistd.h>

#ifndef BINDIR
#define BINDIR "/usr/bin"
#endif

#ifndef PERL_PROGRAM
#define PERL_PROGRAM BINDIR"/mm_perl"
#endif

int main(int argc, char **argv) {
    execv(PERL_PROGRAM, argv);
    return(0);
}
