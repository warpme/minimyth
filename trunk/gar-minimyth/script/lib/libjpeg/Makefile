GARNAME = jpeg
GARVERSION = 8b
CATEGORIES = lib
MASTER_SITES = http://www.ijg.org/files/
DISTFILES = jpegsrc.v$(GARVERSION).tar.gz
LICENSE = jpeg
jpeg_LICENSE_TEXT = $(WORKSRC)/README
DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-static \
	--enable-shared \
	--with-gnu-ld

include ../../gar.mk

# jpeg 8a fails to compile with GCC 4.4.4's fgraphite-identity.
# However, it compiles with GCC 4.5.0.
CFLAGS := $(filter-out -fgraphite-identity, $(CFLAGS))

# Suffers from bug 42453 <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=42453>.
CFLAGS := $(filter-out -fuse-linker-plugin, $(CFLAGS))

post-install:
	@rm -f $(DESTDIR)$(libdir)/libjpeg.la
	@$(MAKECOOKIE)
