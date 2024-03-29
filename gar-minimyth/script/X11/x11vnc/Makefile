GARNAME = x11vnc
GARVERSION = 0.9.13
CATEGORIES = X11
MASTER_SITES = http://downloads.sourceforge.net/project/libvncserver/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = \
	$(DISTNAME)-automake_1.13.patch \
	$(DISTNAME)-ar.patch \
	$(DISTNAME)-xlinker.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c xorg/xorg lib/libjpeg lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--with-tightvnc-filetransfer \
	--with-24bpp \
	--without-ffmpeg \
	--with-x \
	--without-system-libvncserver \
	--with-x11vnc \
	--with-xkeyboard \
	--with-xinerama \
	--with-xrandr \
	--with-xfixes \
	--without-xdamage \
	--without-xtrap \
	--with-xrecord \
	--without-fbpm \
	--with-dpms \
	--without-v4l \
	--without-fbdev \
	--with-uinput \
	--without-macosx-native \
	--without-crypt \
	--without-crypto \
	--without-ssl \
	--without-avahi \
	--with-jpeg \
	--with-jpeg=$(DESTDIR)$(prefix) \
	--with-zlib \
	--with-zlib=$(DESTDIR)$(prefix) \
	--with-pthread \
	--without-gnutls \
	--without-client-tls \
	--without-ipv6

CONFIGURE_ENV = \
	ac_cv_func_fork_works=yes \
	ac_cv_func_lstat_dereferences_slashed_symlink=yes \
	ac_cv_func_memcmp_working=yes \
	ac_cv_func_stat_empty_string_bug=no

include ../../gar.mk

LDFLAGS := $(LDFLAGS) -fwhole-program

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
