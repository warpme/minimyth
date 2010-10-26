GARNAME = mame
GARVERSION = 0.140
CATEGORIES = emulators
DISTFILES = $(GARNAME)$(subst .,,$(GARVERSION))s.zip
PATCHFILES  = $(DISTNAME).patch.gar $(DISTNAME)-no_gtk.patch
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-cross.patch
endif
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/docs/license.txt

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/expat lib/SDL lib/zlib xorg/xorg
ifneq ($(DESTIMG),build)
BUILDDEPS += emulators/mame
endif

BUILD_SCRIPTS    = $(WORKSRC)/makefile
INSTALL_SCRIPTS  = custom
ifeq ($(DESTIMG),build)
INSTALL_SCRIPTS += cross
endif

BUILD_ARGS = \
	NOWERROR="1" \
	OPTIMIZE="$(OPTIMIZE)" \
	OPT_FLAGS="$(CFLAGS)" \
	NO_DEBUGGER="1" \
	$(if $(filter x86_64,$(GARCH_FAMILY)),PTR64="1",PTR64="0")

include ../../gar.mk

# Fails to compile using the gold linker link time optimization plugin.
CFLAGS   := $(filter-out -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -fuse-linker-plugin, $(LDFLAGS))

# The linker must the c++ because some of the object files are compiled as c++ using the c compiler.
LD := $(CXX)

OPTIMIZE := $(subst -O,,$(filter -O%,$(CFLAGS)))

post-extract:
	@echo " ==> Extracting $(EXTRACTDIR)/mame.zip"
	@mkdir -p $(WORKSRC)
	@unzip $(EXTRACTDIR)/mame.zip -d $(WORKSRC)
	@rm -f $(EXTRACTDIR)/mame.zip
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(bindir)
	@$(if $(filter x86_64,$(GARCH_FAMILY)), \
		cp -f $(WORKSRC)/mame64 $(DESTDIR)$(bindir)/mame, \
		cp -f $(WORKSRC)/mame   $(DESTDIR)$(bindir)/mame)
	@$(MAKECOOKIE)

install-cross:
	@mkdir -p $(DESTDIR)$(bindir)
	@$(if $(filter x86_64,$(GARCH_FAMILY)), \
		cp -f $(WORKSRC)/obj/sdl/mame64/build/file2str $(DESTDIR)$(bindir)/mame-file2str ; \
		cp -f $(WORKSRC)/obj/sdl/mame64/build/png2bdc  $(DESTDIR)$(bindir)/mame-png2bdc  ; \
		cp -f $(WORKSRC)/obj/sdl/mame64/build/m68kmake $(DESTDIR)$(bindir)/mame-m68kmake ; \
		cp -f $(WORKSRC)/obj/sdl/mame64/build/tmsmake  $(DESTDIR)$(bindir)/mame-tmsmake,   \
		cp -f $(WORKSRC)/obj/sdl/mame/build/file2str   $(DESTDIR)$(bindir)/mame-file2str ; \
		cp -f $(WORKSRC)/obj/sdl/mame/build/png2bdc    $(DESTDIR)$(bindir)/mame-png2bdc  ; \
		cp -f $(WORKSRC)/obj/sdl/mame/build/m68kmake   $(DESTDIR)$(bindir)/mame-m68kmake ; \
		cp -f $(WORKSRC)/obj/sdl/mame/build/tmsmake    $(DESTDIR)$(bindir)/mame-tmsmake)
	@$(MAKECOOKIE)
