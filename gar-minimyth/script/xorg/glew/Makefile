GARNAME = glew
GARVERSION = 1.12.0
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://downloads.sourceforge.net/project/$(GARNAME)/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tgz
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENSE.txt

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	$(CATEGORY)/glu \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libXi \
	$(CATEGORY)/libXmu \
	$(CATEGORY)/libXext \
	$(CATEGORY)/Mesa

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

BUILD_ARGS  = \
	GLEW_PREFIX="$(prefix)" \
	GLEW_DEST="$(prefix)" \
	BINDIR="$(bindir)" \
	LIBDIR="$(libdir)" \
	INCDIR="$(includedir)/GL" \
	CC="$(CC)" \
	LD="$(CC)" \
	AR="$(AR)" \
	STRIP="$(STRIP)" \
	CFLAGS.EXTRA="$(CFLAGS)" \
	LDFLAGS.EXTRA="$(LDFLAGS)"
INSTALL_ARGS = \
	GLEW_PREFIX="$(prefix)" \
	GLEW_DEST="$(prefix)" \
	BINDIR="$(bindir)" \
	LIBDIR="$(libdir)" \
	INCDIR="$(includedir)/GL" \
	CC="$(CC)" \
	LD="$(CC)" \
	AR="$(AR)" \
	STRIP="$(STRIP)" \
	CFLAGS.EXTRA="$(CFLAGS)" \
	LDFLAGS.EXTRA="$(LDFLAGS)"

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

CFLAGS  := $(CFLAGS)  -fPIC
LDFLAGS := $(LDFLAGS) -fPIC

post-install:
	@rm -f $(DESTDIR)$(libdir)/libGLEW.a
	@$(MAKECOOKIE)
