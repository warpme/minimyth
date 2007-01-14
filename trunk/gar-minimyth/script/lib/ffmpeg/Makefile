GARNAME = ffmpeg
GARVERSION = 6701
CATEGORIES = lib
MASTER_SITES = svn://svn.mplayerhq.hu/ffmpeg/trunk/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/SDL lib/zlib


CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile


CONFIGURE_ARGS = \
	--prefix=$(prefix) \
	--libdir=$(libdir) \
	--shlibdir=$(libdir) \
	--incdir=$(includedir)/ffmpeg \
	--mandir=$(mandir) \
	--enable-pp \
	--enable-static \
	--enable-shared \
	--enable-pthreads \
	--enable-gpl \
	--cross-compile \
	--cross-prefix=$(compiler_prefix) \
	--cc="gcc" \
	--extra-cflags="$(CFLAGS)" \
	--extra-ldflags="$(LD_FLAGS)" \
	--cpu=$(GARCH_FAMILY) \
	--tune=$(GARCH) \
	--disable-armv5te \
	--disable-iwmmxt \
	--disable-altivec \
	--disable-audio-oss \
	--disable-audio-beos \
	--disable-v4l \
	--disable-v4l2 \
	--disable-bktr \
	--disable-dv1394 \
	--disable-network \
	--disable-vhook \
	--disable-debug \
	--disable-mpegaudio-hp \
	--disable-protocols \
	--disable-ffserver \
	--disable-ffplay
INSTALL_ARGS   = \
	INSTALLSTRIP="" \
	LDCONFIG="true"

include ../../gar.mk

CFLAGS += -DHAVE_XVMC

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

post-configure:
	@echo "HAVE_XVMC_ACCEL=yes" >> $(WORKSRC)/config.mak
	@$(MAKECOOKIE)

post-install:
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libavcodec.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libavcodec.pc
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libavformat.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libavformat.pc
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libavutil.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libavutil.pc
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libpostproc.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libpostproc.pc
	@$(MAKECOOKIE)
