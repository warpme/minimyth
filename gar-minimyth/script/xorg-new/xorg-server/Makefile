GARNAME = xorg-server
GARVERSION = 1.0.1
CATEGORIES = xorg-new
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/xserver/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  = $(DISTNAME)-geteuid.patch $(DISTNAME)-mitri.patch
PATCHFILES += $(DISTNAME)-drm.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	xorg-new/libdrm \
	xorg-new/Mesa \
	xorg-new/xf86driproto \
	xorg-new/randrproto \
	xorg-new/renderproto \
	xorg-new/fixesproto \
	xorg-new/damageproto \
	xorg-new/xcmiscproto \
	xorg-new/xextproto \
	xorg-new/libXfont \
	xorg-new/xproto \
	xorg-new/xtrans \
	xorg-new/libXau \
	xorg-new/xf86miscproto \
	xorg-new/xf86vidmodeproto \
	xorg-new/xf86bigfontproto \
	xorg-new/scrnsaverproto \
	xorg-new/bigreqsproto \
	xorg-new/resourceproto \
	xorg-new/libfontenc \
	xorg-new/fontsproto \
	xorg-new/videoproto \
	xorg-new/compositeproto \
	xorg-new/recordproto \
	xorg-new/xineramaproto \
	xorg-new/evieext \
	xorg-new/libxkbfile \
	xorg-new/glproto \
	xorg-new/xf86dgaproto \
	xorg-new/liblbxutil

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--disable-builddocs \
	--enable-composite \
	--enable-shm \
	--disable-xres \
	--disable-xtrap \
	--enable-record \
	--enable-xv \
	--enable-dga \
	--enable-screensaver \
	--disable-xdmcp \
	--disable-xdm-auth-1 \
	--enable-glx \
	--enable-dri \
	--enable-xinerama \
	--enable-xf86vidmode \
	--enable-xf86misc \
	--enable-xcsecurity \
	--enable-xevie \
	--enable-lbx \
	--enable-appgroup \
	--enable-cup \
	--enable-evi \
	--disable-multibuffer \
	--disable-fontcache \
	--enable-xorg \
	--disable-dmx \
	--enable-xvfb \
	--disable-xnest \
	--disable-xwin \
	--disable-xprint \
	--disable-install-setuid \
	--enable-unix-transport \
	--enable-tcp-transport \
	--disable-ipv6 \
	--disable-secure-rpc \
	--disable-xorgcfg \
	--disable-kbd_mode \
	--with-gnu-ld \
	--with-mesa-source="$(DESTDIR)$(sourcedir)/Mesa"

GAR_EXTRA_CONF += xorg-new/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@rm -f $(WORKSRC)/config.cache
	@echo "ac_cv_sys_linker_h=no"                                                                >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(prefix)/share/X11/sgml/defs.ent | sed -e 's%[^a-zA-Z0-9]%_%g'`=no" >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libdbe.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libdri.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libextmod.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libGLcore.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/libglx.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/extensions/librecord.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/fonts/libbitmap.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/fonts/libfreetype.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/fonts/libtype1.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libafb.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libcfb16.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libcfb24.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libcfb32.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libcfb.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libddc.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libexa.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libfb.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libi2c.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libint10.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/liblayer.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libmfb.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libpcidata.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/librac.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libramdac.la
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
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/libxf8_32wid.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/linux/libdrm.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/linux/libfbdevhw.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/bt829_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/fi1236_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/msp3430_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/tda8425_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/tda9850_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/tda9885_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/uda1380_drv.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'                  $(DESTDIR)$(libdir)/pkgconfig/xorg-server.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g'          $(DESTDIR)$(libdir)/pkgconfig/xorg-server.pc
	@sed -i 's%-I$${moduledir}%-I$(DESTDIR)$${moduledir}%g'            $(DESTDIR)$(libdir)/pkgconfig/xorg-server.pc
	@sed -i 's%^sdkdir=$(includedir)%sdkdir=$(DESTDIR)$(includedir)%g' $(DESTDIR)$(libdir)/pkgconfig/xorg-server.pc
	@$(MAKECOOKIE)
