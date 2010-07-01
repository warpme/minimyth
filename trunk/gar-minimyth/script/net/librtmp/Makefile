GARNAME = rtmpdump
GARVERSION = 2.3
CATEGORIES = net
MASTER_SITES = http://rtmpdump.mplayerhq.hu/download/
DISTFILES = $(DISTNAME).tgz
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
	bindir=$(bindir) \
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
	bindir=$(bindir) \
	libdir=$(libdir) \
	mandir=$(mandir) \
	CC="$(CC)" \
	LD="$(LD)" \
	AR="$(AR)" \
	CRYPTO="OPENSSL" \
	XCFLAGS="$(CFLAGS) $(LDFLAGS)"

include ../../gar.mk

# Ensure that the files are position independent so that x86_64 builds do not fail.
#CFLAGS  := $(CFLAGS) -fPIC -DPIC 
#LDFLAGS := $(LDFLAGS) -fPIC -DPIC 

# Skip LTO just to be safe.
#CFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
#LDFLAGS := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

post-install:
	@rm -f $(DESTDIR)$(libdir)/librtmp.a
	@$(MAKECOOKIE)
