GARNAME = ffmpeg
GARVERSION = 20060218
CATEGORIES = lib
MASTER_SITES = cvs://anonymous@mplayerhq.hu:/cvsroot/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2

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
	--incdir=$(includedir)/ffmpeg \
	--mandir=$(mandir) \
	--enable-static \
	--enable-shared \
	--enable-pthreads \
	--enable-gpl \
	--cross-prefix=$(compiler_prefix) \
	--cc="gcc" \
	--extra-cflags="$(CFLAGS)" \
	--extra-ldflags="$(LD_FLAGS)" \
	--cpu=$(GARCH) \
	--tune=$(GARCH) \
	--disable-iwmmxt \
	--disable-altivec \
	--disable-audio-oss \
	--disable-audio-beos \
	--disable-v4l \
	--disable-v4l2 \
	--disable-bktr \
	--disable-dv1394 \
	--disable-network \
	--disable-lzo \
	--disable-vhook \
	--disable-debug \
	--disable-mpegaudio-hp \
	--disable-ffserver \
	--disable-ffplay

include ../../gar.mk

CFLAGS += -DHAVE_XVMC

cvs//%$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) -d $(DISTNAME) $(GARNAME)
	@cd $(PARTIALDIR); tar --exclude '*/CVS/*' --exclude '*/CVS' --exclude '*/.cvsignore' -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
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
	@$(MAKECOOKIE)
