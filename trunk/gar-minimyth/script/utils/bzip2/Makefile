GARNAME = bzip2
GARVERSION = 1.0.4
CATEGORIES = utils
MASTER_SITES = http://www.bzip.org/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-perl.patch.gar $(DISTNAME).patch
LICENSE = bzip2
bzip2_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

BUILD_ARGS   = \
	CC="$(CC)" \
	AR="$(AR)" \
	RANLIB="$(RANLIB)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	DESTDIR="$(DESTDIR)" \
	prefix="$(prefix)" \
	bindir="$(bindir)" \
	libdir="$(libdir)" \
	includedir="$(includedir)" \
	mandir="$(mandir)" \
	libbz2.a bzip2 bzip2recover
INSTALL_ARGS = \
	CC="$(CC)" \
	AR="$(AR)" \
	RANLIB="$(RANLIB)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	DESTDIR="$(DESTDIR)" \
	prefix="$(prefix)" \
	bindir="$(bindir)" \
	libdir="$(libdir)" \
	includedir="$(includedir)" \
	mandir="$(mandir)"

include ../../gar.mk

CFLAGS += -fpic -fPIC -Wall -Winline -D_FILE_OFFSET_BITS=64
