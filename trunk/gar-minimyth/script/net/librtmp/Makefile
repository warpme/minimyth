GARNAME = rtmpdump
GARVERSION = 2.2e
CATEGORIES = net
MASTER_SITES = http://rtmpdump.mplayerhq.hu/download/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/openssl lib/zlib

BUILD_SCRIPTS   = $(WORKSRC)/librtmp/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/librtmp/Makefile

BUILD_ARGS   = \
	DESTDIR=$(DESTDIR) \
	prefix=$(prefix) \
	incdir=$(includedir)/librtmp \
	libdir=$(libdir) \
	mandir=$(mandir) \
	CC="$(CC)" \
	LD="$(LD)" \
	AR="$(AR)" \
	CRYPTO="OPENSSL" \
	XCFLAGS="$(CFLAGS) $(LDFLAGS)"
INSTALL_ARGS = \
	DESTDIR=$(DESTDIR) \
	prefix=$(prefix) \
	incdir=$(includedir)/librtmp \
	libdir=$(libdir) \
	mandir=$(mandir) \
	CC="$(CC)" \
	LD="$(LD)" \
	AR="$(AR)" \
	CRYPTO="OPENSSL" \
	XCFLAGS="$(CFLAGS) $(LDFLAGS)"

include ../../gar.mk

# Skip LTO just to be safe.
CFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))
