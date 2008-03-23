GARNAME = xorg-server
GARVERSION = 1.3.0.0
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(XORG_MASTER_SITES)
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-perl.patch.gar $(DISTNAME)-pkg_config.patch $(DISTNAME)-drm.patch $(DISTNAME)-displaysize.patch $(DISTNAME)-mesa_6.5.3.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	$(CATEGORY)/bigreqsproto \
	$(CATEGORY)/compositeproto \
	$(CATEGORY)/damageproto \
	$(CATEGORY)/evieext \
	$(CATEGORY)/fixesproto \
	$(CATEGORY)/fontsproto \
	$(CATEGORY)/glproto \
	$(CATEGORY)/inputproto \
	$(CATEGORY)/kbproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/libfontenc \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libXau \
	$(CATEGORY)/libXdmcp \
	$(CATEGORY)/libXext \
	$(CATEGORY)/libXfont \
	$(CATEGORY)/libxkbfile \
	$(CATEGORY)/Mesa \
	$(CATEGORY)/randrproto \
	$(CATEGORY)/recordproto \
	$(CATEGORY)/renderproto \
	$(CATEGORY)/resourceproto \
	$(CATEGORY)/scrnsaverproto \
	$(CATEGORY)/videoproto \
	$(CATEGORY)/xcmiscproto \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/xf86bigfontproto \
	$(CATEGORY)/xf86dgaproto \
	$(CATEGORY)/xf86driproto \
	$(CATEGORY)/xf86miscproto \
	$(CATEGORY)/xf86vidmodeproto \
	$(CATEGORY)/xineramaproto \
	$(CATEGORY)/xproto \
	$(CATEGORY)/xtrans
BUILDDEPS = \
	$(CATEGORY)/util-macros \
	$(CATEGORY)/xorg-sgml-doctools

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--disable-werror \
	--disable-debug \
	--disable-builddocs \
	--enable-install-libxf86config \
	--enable-composite \
	--enable-shm \
	--disable-xres \
	--disable-xtrap \
	--enable-record \
	--enable-xv \
	--enable-xvmc \
	--enable-dga \
	--enable-screensaver \
	--enable-xdmcp \
	--disable-xdm-auth-1 \
	--enable-glx \
	--disable-aiglx \
	--disable-glx-tls \
	--enable-dri \
	--enable-xinerama \
	--enable-xf86vidmode \
	--enable-xf86misc \
	--enable-xace \
	--enable-xcsecurity \
	--enable-appgroup \
	--disable-xcalibrate \
	--disable-tslib \
	--enable-xevie \
	--enable-cup \
	--enable-evi \
	--disable-multibuffer \
	--disable-fontcache \
	--enable-dbe \
	--enable-xf86bigfont \
	--enable-dpms \
	--enable-xinput \
	--enable-xfree86-utils \
	--enable-xorg \
	--disable-dmx \
	--enable-xvfb \
	--disable-xnest \
	--disable-xwin \
	--disable-xprint \
	--disable-xgl \
	--disable-xglx \
	--disable-xegl \
	--disable-kdrive \
	--disable-xephyr \
	--disable-xsdl \
	--disable-freetype \
	--disable-install-setuid \
	--disable-secure-rpc \
	--disable-xorgcfg \
	--disable-kbd_mode \
	--enable-unix-transport \
	--enable-tcp-transport \
	--disable-ipv6 \
	--with-gnu-ld \
	--with-mesa-source="$(DESTDIR)$(sourcedir)/Mesa" \
	--with-fontdir="$(libdir)/X11/fonts" \
	--with-default-font-path="$(libdir)/X11/fonts/TTF,$(libdir)/X11/fonts/misc" \
	--with-xkb-path="$(datadir)/X11/xkb" \
	--with-xkb-output="$(datadir)/X11/xkb/compiled" \
	--with-rgb-path="$(datadir)/X11/rgb" \
	--with-serverconfig-path="$(libdir)/xserver" \
	--with-dri-driver-path="$(libdir)/xorg/modules/dri"

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@rm -f $(WORKSRC)/config.cache
	@echo "ac_cv_sys_linker_h=no"                                                                 >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(prefix)/share/sgml/X11/defs.ent | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes" >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libdbe.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libdri.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libextmod.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libGLcore.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libglx.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/librecord.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/fonts/libfreetype.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/fonts/libtype1.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libafb.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libcfb32.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libcfb.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libexa.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libfb.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libint10.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libmfb.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libpcidata.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libscanpci.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libshadowfb.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libshadow.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libvbe.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libvgahw.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libxaa.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libxf1bpp.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libxf4bpp.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libxf8_16bpp.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libxf8_32bpp.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/linux/libfbdevhw.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/bt829_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/fi1236_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/msp3430_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/tda8425_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/tda9850_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/tda9885_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/uda1380_drv.la
	@$(MAKECOOKIE)
