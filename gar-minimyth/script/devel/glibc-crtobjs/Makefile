GARNAME = glibc-crtobjs
GARVERSION = $(GLIBC_VERSION)
CATEGORIES = devel
SOURCEPKG = devel/glibc
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c kernel-headers/linux-headers
BUILDDEPS = devel/binutils devel/gcc-minimal-static

# If this is the build image and the system is using linuxthreads, then we need to use linux threads.
# Otherwise, the build packages will not compile and run correctly.
use_linuxthreads = no
ifeq ($(DESTIMG),build)
ifeq ($(shell getconf GNU_LIBPTHREAD_VERSION | sed 's%[- ].*%%'),linuxthreads)
use_linuxthreads = yes
endif
endif

WORKSRC = $(WORKDIR)/glibc-$(GARVERSION)
WORKBLD = $(WORKSRC)_build

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKBLD)/Makefile
INSTALL_SCRIPTS   = custom

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-bind-now \
	--enable-kernel=3.18.0 \
	--disable-build-nscd \
	--disable-nscd \
	--without-gd \
	--without-cvs \
	--with-elf \
	--with-headers=$(DESTDIR)$(includedir)
ifeq ($(use_linuxthreads),yes)
CONFIGURE_ARGS += \
	--enable-add-ons=linuxthreads \
	--without-tls \
	--without-__thread
else
CONFIGURE_ARGS += \
	--disable-add-ons \
	--with-tls \
	--with-__thread
endif
BUILD_ARGS      = \
	csu/subdir_lib
INSTALL_ARGS    = \
	install_root=$(DESTDIR)

CONFIGURE_ENV = \
	BUILD_CC="$(build_CC)" \
	BUILD_CPPFLAGS="$(build_CPPFLAGS)" \
	BUILD_CFLAGS="$(build_CFLAGS)" \
	BUILD_LDFLAGS="$(build_LDFLAGS)"
BUILD_ENV     = \
	BUILD_CC="$(build_CC)" \
	BUILD_CPPFLAGS="$(build_CPPFLAGS)" \
	BUILD_CFLAGS="$(build_CFLAGS)" \
	BUILD_LDFLAGS="$(build_LDFLAGS)"
INSTALL_ENV   = \
	BUILD_CC="$(build_CC)" \
	BUILD_CPPFLAGS="$(build_CPPFLAGS)" \
	BUILD_CFLAGS="$(build_CFLAGS)" \
	BUILD_LDFLAGS="$(build_LDFLAGS)"

GAR_EXTRA_CONF += devel/glibc/package-api.mk
include ../../gar.mk

CFLAGS  := $(filter-out -O%, $(CFLAGS))
LDFLAGS := $(filter-out -O%, $(LDFLAGS))
CFLAGS  := $(filter-out -f%, $(CFLAGS))
LDFLAGS := $(filter-out -f%, $(LDFLAGS))
# glibc 2.21 sets -mno-sse and -Werror x86-32 and x86-64 causing a build failure with -mfpmath=sse.
CFLAGS  := $(filter-out -mfpmath=%, $(CFLAGS))
LDFLAGS := $(filter-out -mfpmath=%, $(LDFLAGS))

CFLAGS  := $(CFLAGS)  -O2
LDFLAGS := $(LDFLAGS) -O2

pre-configure:
	@cd $(WORKSRC) ; aclocal  --force --verbose
	@cd $(WORKSRC) ; autoconf --force --verbose
	@mkdir -p $(WORKBLD)
	@rm -rf $(WORKBLD)/configparms
	@echo "slibdir=$(elibdir)" >> $(WORKBLD)/configparms
	@rm -rf $(WORKBLD)/config.cache
	@echo "libc_cv_forced_unwind=yes" >> $(WORKBLD)/config.cache
	@echo "libc_cv_c_cleanup=yes"     >> $(WORKBLD)/config.cache
	@echo "libc_cv_ctors_header=yes"  >> $(WORKBLD)/config.cache
	@$(MAKECOOKIE)

configure-custom:
	@mkdir -p $(WORKBLD)
	@cd $(WORKBLD) && $(CONFIGURE_ENV) ./$(call DIRSTODOTS,$(WORKBLD))/$(WORKSRC)/configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

install-custom:
	cp -fp $(WORKBLD)/csu/crt[i1n].o $(DESTDIR)$(libdir)
	$(MAKECOOKIE)
