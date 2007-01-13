GARNAME = ffmpeg
GARVERSION = 20060214
CATEGORIES = lib
MASTER_SITES = cvs://anonymous@mplayerhq.hu:/cvsroot/$(GARNAME)/

DISTFILES = $(DISTNAME).tar.bz2
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/faad2 lib/lame lib/libogg lib/libtheora lib/libvorbis lib/zlib


CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix=$(prefix) \
	--libdir=$(libdir) \
	--incdir=$(includedir)/ffmpeg \
	--mandir=$(mandir) \
	--enable-mp3lame \
	--enable-libogg \
	--enable-vorbis \
	--enable-theora \
	--enable-faad \
	--enable-a52 \
	--enable-a52bin \
	--enable-pp \
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
	--disable-ffplay \
	--enable-small

include ../../gar.mk

cvs//%$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) -d $(DISTNAME) $(GARNAME)
	@cd $(PARTIALDIR); tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)
