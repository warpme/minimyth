GARNAME = alsa-lib
GARVERSION = 1.0.16
CATEGORIES = lib
MASTER_SITES = ftp://ftp.alsa-project.org/pub/lib/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-static \
	--enable-shared \
	--disable-python \
	--with-gnu-ld \
	--with-tmpdir="$(rootdir)/tmp" \
	--with-alsa-devdir="$(rootdir)/dev/snd" \
	--with-aload-devdir="$(rootdir)/dev"

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libasound.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/smixer/smixer-sbase.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/smixer/smixer-ac97.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/smixer/smixer-hda.la
	@$(MAKECOOKIE)
