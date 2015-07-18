GARNAME = llvm
# 3.6.x requires python 2.7 to build.
GARVERSION = 3.5.2
CATEGORIES = devel
MASTER_SITES = http://www.llvm.org/releases/$(GARVERSION)/
DISTFILES = $(DISTNAME).src.tar.xz
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENSE.TXT

DESCRIPTION = 
define BLURB
endef

DEPENDS    = lang/c lang/cxx
BUILDDEPS  = python/python

WORKSRC = $(WORKDIR)/$(DISTNAME).src
WORKBLD = $(WORKSRC)_build

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKBLD)/Makefile
INSTALL_SCRIPTS   = $(WORKBLD)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-polly \
	--enable-optimized \
	--disable-profiling \
	--disable-assertions \
	--disable-expensive-checks \
	--disable-debug-runtime \
	--disable-debug-symbols \
	--enable-jit \
	--disable-docs \
	--disable-doxygen \
	--enable-threads \
	--enable-pthreads \
	--enable-pic \
	--enable-shared \
	--disable-embed-stdcxx \
	--enable-timestamps \
	--enable-bindings="no" \
	--with-optimize-option="$(EXTRA_OPTIONS)" \
	--with-extra-options="$(EXTRA_OPTIONS)" \
	--with-extra-ld-options="$(EXTRA_LD_OPTIONS)"
# the configure script applies the host compiler flags when checking the build compiler.
ifneq ($(GARCHFAMLY),i386)
CONFIGURE_AGS += \
	--enable-targets="x86,r600"
endif
ifneq ($(GARCHFAMLY),x86_64)
CONFIGURE_AGS += \
	--enable-targets="x86_64,r600"
endif

include ../../gar.mk

EXTRA_OPTIONS    := $(CFLAGS)
EXTRA_LD_OPTIONS := $(LDFLAGS)

CFLAGS   :=
CXXFLAGS :=
LDFLAGS  :=

pre-configure:
	@cd $(WORKSRC)/autoconf ; aclocal  --force --verbose -I m4
	@cd $(WORKSRC)/autoconf ; autoconf --force --verbose -I m4 -o ../configure
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

configure-custom:
	@mkdir -p $(WORKBLD)
	@cd $(WORKBLD) && $(CONFIGURE_ENV) ./$(call DIRSTODOTS,$(WORKBLD))/$(WORKSRC)/configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(bindir)-config/llvm-config
	@rm -f $(DESTDIR)$(bindir)-config/$(compiler_prefix)llvm-config
	@mkdir -p $(DESTDIR)$(bindir)-config
	@$(if $(filter build, $(DESTIMG)), \
		cp $(WORKBLD)/Release/bin/llvm-config            $(DESTDIR)$(bindir)-config/llvm-config, \
		cp $(WORKBLD)/BuildTools/Release/bin/llvm-config $(DESTDIR)$(bindir)-config/llvm-config  )
	@$(if $(compiler_prefix), ln -s llvm-config $(DESTDIR)$(bindir)-config/$(compiler_prefix)llvm-config)
	@$(MAKECOOKIE)
