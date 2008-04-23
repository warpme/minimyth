GARNAME = libX11
GARVERSION = 1.1.4
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(XORG_MASTER_SITES)
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-cross.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c \
	$(CATEGORY)/bigreqsproto \
	$(CATEGORY)/inputproto \
	$(CATEGORY)/kbproto \
	$(CATEGORY)/libXau \
	$(CATEGORY)/libxcb \
	$(CATEGORY)/xcmiscproto \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/xproto \
	$(CATEGORY)/xtrans
BUILDDEPS = $(CATEGORY)/util-macros

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-secure-rpc \
	--disable-loadable-i18n \
	--enable-loadable-xcursor \
	--enable-xthreads \
	--disable-xcms \
	--enable-xlocale \
	--disable-xlocaledir \
	--disable-xf86bigfont \
	--enable-xkb \
	--disable-man-pages \
	--disable-composecache \
	--disable-lint-library \
	--enable-malloc0returnsnull \
	--enable-unix-transport \
	--disable-tcp-transport \
	--disable-local-transport \
	--disable-ipv6 \
	--with-gnu-ld \
	--with-xcb \
	--without-launchd \
	--without-lint

CONFIGURE_ENV = \
	CC_FOR_BUILD="$(build_CC)" \
	CPPFLAGS_FOR_BUILD="$(build_CPPFLAGS)" \
	CFLAGS_FOR_BUILD="$(build_CFLAGS)" \
	LDFLAGS_FOR_BUILD="$(build_LDFLAGS)"

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME)-xcb.la
	@rm -f $(DESTDIR)$(libdir)/X11/locale/common/ximcp.la
	@rm -f $(DESTDIR)$(libdir)/X11/locale/common/xlcUTF8Load.la
	@rm -f $(DESTDIR)$(libdir)/X11/locale/common/xlcDef.la
	@rm -f $(DESTDIR)$(libdir)/X11/locale/common/xlibi18n.la
	@rm -f $(DESTDIR)$(libdir)/X11/locale/common/xlocale.la
	@rm -f $(DESTDIR)$(libdir)/X11/locale/common/xomGeneric.la
	@$(MAKECOOKIE)
