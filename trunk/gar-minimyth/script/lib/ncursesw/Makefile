GARNAME = ncursesw
GARVERSION = $(NCURSES_VERSION)
CATEGORIES = lib
SOURCEPKG = lib/ncurses
LICENSE = MIT_Modified

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

WORKSRC = $(WORKDIR)/ncurses-$(GARVERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--without-cxx-binding \
	--without-ada \
	--without-ada-compiler \
	--with-build-cc="$(build_CC)" \
	--with-build-cppflags="$(build_CPPFLAGS) -include wchar.h" \
	--with-build-cflags="$(build_CFLAGS)" \
	--with-build-ldflags="$(build_LDFLAGS)" \
	--with-build-libs="" \
	--with-shared \
	--without-normal \
	--without-debug \
	--without-profile \
	--disable-rpath \
	--enable-widec

GAR_EXTRA_CONF += lib/ncurses/package-api.mk
include ../../gar.mk

# Suffers from bug 42453 <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=42453>.
CFLAGS  := $(filter-out -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -fuse-linker-plugin, $(LDFLAGS))

# causes procps's top to segmentation fault when compiled with gcc's link time optimization.
CFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

post-install:
	@rm -f $(DESTDIR)$(bindir)-config/ncursesw5-config
	@rm -f $(DESTDIR)$(bindir)-config/$(compiler_prefix)ncursesw5-config
	@mkdir -p $(DESTDIR)$(bindir)-config
	@mv $(DESTDIR)$(bindir)/ncursesw5-config $(DESTDIR)$(bindir)-config/ncursesw5-config
	@$(if $(compiler_prefix), ln -s ncursesw5-config $(DESTDIR)$(bindir)-config/$(compiler_prefix)ncursesw5-config)
	@$(MAKECOOKIE)
