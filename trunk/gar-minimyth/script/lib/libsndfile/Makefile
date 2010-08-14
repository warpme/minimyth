GARNAME = libsndfile
GARVERSION = 1.0.21
CATEGORIES = lib
MASTER_SITES = http://www.mega-nerd.com/libsndfile/files/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/cxx lib/alsa-lib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--disable-experimental \
	--disable-sqlite \
	--enable-alsa \
	--disable-external-libs \
	--disable-test-coverage \
	--enable-largefile \
	--disable-shave \
	--with-gnu-ld

include ../../gar.mk

# Fails to compile with GCC's link time optimization.
# See <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=45007>
CFLAGS   := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -flto -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

pre-configure:
	@cd $(WORKSRC) ; rm -f M4/libtool.m4
	@cd $(WORKSRC) ; rm -f M4/lt~obsolete.m4
	@cd $(WORKSRC) ; rm -f M4/ltoptions.m4
	@cd $(WORKSRC) ; rm -f M4/ltsugar.m4
	@cd $(WORKSRC) ; rm -f M4/ltversion.m4
	@cd $(WORKSRC) ; autoreconf --verbose --install --force -I M4
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libsndfile.la
	@$(MAKECOOKIE)
