GARNAME = util-linux
GARVERSION = 2.26.2
CATEGORIES = utils
MASTER_SITES = https://www.kernel.org/pub/linux/utils/util-linux/v2.26/
DISTFILES = $(DISTNAME).tar.xz
PATCHFILES = $(DISTNAME)-agetty_2.19.1.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/ncursesw lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--bindir=$(ebindir) \
	--sbindir=$(esbindir) \
	--libdir=$(elibdir) \
	--disable-silent-rules \
	--enable-shared \
	--disable-static \
	--disable-gtk-doc \
	--enable-nls \
	--disable-rpath \
	--enable-tls \
	--enable-libuuid \
	--enable-libblkid \
	--enable-libmount \
	--disable-libmount-force-mountinfo \
	--disable-libsmartcols \
	--disable-libfdisk \
	--enable-mount \
	--disable-losetup \
	--disable-zramctl \
	--disable-fsck \
	--disable-partx \
	--enable-uuidd \
	--disable-mountpoint \
	--disable-fallocate \
	--disable-unshare \
	--disable-nsenter \
	--disable-setpriv \
	--disable-eject \
	--enable-agetty \
	--enable-cramfs \
	--disable-bfs \
	--disable-minix \
	--disable-fdformat \
	--disable-hwclock \
	--disable-wdctl \
	--enable-switch_root \
	--disable-pivot_root \
	--disable-tunelp \
	--disable-kill \
	--disable-deprecated-last \
	--disable-last \
	--disable-utmpdump \
	--disable-line \
	--disable-mesg \
	--disable-raw \
	--enable-rename \
	--disable-reset \
	--disable-vipw \
	--disable-newgrp \
	--disable-chfn-chsh-password \
	--disable-chfn-chsh \
	--enable-chsh-only-listed \
	--disable-login \
	--disable-login-chown-vcs \
	--disable-login-stat-mail \
	--disable-nologin \
	--disable-sulogin \
	--disable-su \
	--disable-runuser \
	--disable-ul \
	--disable-more \
	--disable-pg \
	--disable-setterm \
	--disable-schedutils \
	--disable-wall \
	--disable-write \
	--disable-bash-completion \
	--disable-pylibmount \
	--enable-pg-bell \
	--disable-use-tty-group \
	--disable-sulogin-emergency-mount \
	--disable-makeinstall-chown \
	--disable-makeinstall-setuid \
	--disable-colors-default \
	--with-gnu-ld \
	--without-selinux \
	--without-audit \
	--without-udev \
	--without-slang \
	--without-utempter \
	--without-user \
	--without-systemd \
	--without-systemdsystemunitdir \
	--without-smack \
	--without-python

BUILD_ARGS     = \
	usrbin_execdir=$(bindir) \
	usrsbin_execdir=$(sbindir) \
	usrlib_execdir=$(elibdir) \
	pkgconfigdir=$(libdir)/pkgconfig
INSTALL_ARGS   = \
	usrbin_execdir=$(bindir) \
	usrsbin_execdir=$(sbindir) \
	usrlib_execdir=$(elibdir) \
	pkgconfigdir=$(libdir)/pkgconfig

include ../../gar.mk

# util-linux 2.26.2 fails to compile with gcc 5.2.0's link time optimization enabled.
CFLAGS  := $(filter-out -flto, $(CFLAGS))  -fno-lto
LDFLAGS := $(filter-out -flto, $(LDFLAGS)) -fno-lto

pre-configure:
	@$(call RUN_GETTEXTIZE)
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(elibdir)/libblkid.la
	@rm -f $(DESTDIR)$(elibdir)/libmount.la
	@rm -f $(DESTDIR)$(elibdir)/libuuid.la
	@$(MAKECOOKIE)
