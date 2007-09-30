CC      ?= gcc
CFLAGS  ?= -O2

INSTALL         ?= install
INSTALL_PROGRAM ?= $(INSTALL)

DESTDIR ?=
prefix  ?= /usr
bindir  ?= $(prefix)/bin

all: perl

perl: perl.c
	$(CC) $(CFLAGS) -DBINDIR="\"$(bindir)\"" -o $@ $<

install:
	$(INSTALL) -D perl $(DESTDIR)$(bindir)/perl
