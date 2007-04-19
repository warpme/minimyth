GARNAME = ffmpeg
GARVERSION = 8760.23025
CATEGORIES = lib
MASTER_SITES = svn://svn.mplayerhq.hu/
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
	--enable-static \
	--enable-shared \
	--enable-gpl \
	--enable-pp \
	--disable-swscaler \
	--disable-beosthreads \
	--disable-os2threads \
	--enable-pthreads \
	--disable-w32threads \
	--enable-x11grab \
	--disable-dc1394 \
	--disable-liba52 \
	--disable-liba52bin \
	--disable-avisynth \
	--disable-libdts \
	--disable-libfaac \
	--disable-libfaad \
	--disable-libfaadbin \
	--disable-libgsm \
	--disable-libmp3lame \
	--disable-libnut \
	--disable-libogg \
	--disable-libtheora \
	--disable-libvorbis \
	--disable-x264 \
	--disable-xvid \
	--disable-amr-nb \
	--disable-amr-nb-fixed \
	--disable-amr-wb \
	--cross-prefix=$(compiler_prefix) \
	--cross-compile \
	--cc="gcc" \
	--extra-cflags="$(CFLAGS)" \
	--extra-ldflags="$(LD_FLAGS)" \
	--arch=$(GARCH_FAMILY) \
	--cpu=$(GARCH) \
	--disable-powerpc-perf \
	--enable-mmx \
	--disable-armv5te \
	--disable-armv6 \
	--disable-iwmmxt \
	--disable-altivec \
	--disable-audio-oss \
	--disable-audio-beos \
	--disable-v4l \
	--disable-v4l2 \
	--disable-bktr \
	--disable-dv1394 \
	--enable-network \
	--disable-ipv6 \
	--enable-zlib \
	--disable-vhook \
	--disable-debug \
	--disable-mpegaudio-hp \
	--disable-protocols \
	--enable-ffmpeg \
	--disable-ffserver \
	--disable-ffplay \
	--enable-small \
	--disable-memalign-hack \
	--disable-gprof \
	--disable-extra-warnings
INSTALL_ARGS   = \
	LDCONFIG="true"

include ../../gar.mk

CFLAGS += -DHAVE_XVMC

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

# When using the SVN version, GARVERSION must have the form <ffmpeg-svn-version>.<mplayer-svn-version>.
# This is done to ensure that the correct version of libswscale is used.
svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*/ffmpeg/trunk            , $(word 1,$(subst ., ,$(GARVERSION))), $(DISTNAME))
	@$(call FETCH_SVN, svn://$*/mplayer/trunk/libswscale, $(word 2,$(subst ., ,$(GARVERSION))), libswscale )
	@cd $(PARTIALDIR) ; tar -jxf $(DISTNAME).tar.bz2 ; rm -r $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR) ; tar -jxf libswscale.tar.bz2  ; rm -r libswscale.tar.bz2  ; rm -rf $(DISTNAME)/libswscale ; mv libswscale $(DISTNAME)/
	@cd $(PARTIALDIR) ; tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR) ; rm -rf $(DISTNAME)
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
