GARNAME = glibc
GARVERSION = $(GLIBC_VERSION)
CATEGORIES = devel
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/
MASTER_SITES += ftp://sources.redhat.com/pub/$(GARNAME)/snapshots/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c kernel/linux-libc-headers devel/glibc-headers
ifeq ($(DESTIMG),build)
BUILDDEPS = devel/binutils-bootstrap devel/gcc-bootstrap
else
BUILDDEPS = devel/binutils           devel/gcc-minimal-shared
endif

# If this is the build image and the system is using linuxthreads, then we need to use linux threads.
# Otherwise, the build packages will not compile and run correctly.
use_linuxthreads = no
ifeq ($(DESTIMG),build)
ifeq ($(shell getconf GNU_LIBPTHREAD_VERSION | sed 's%[- ].*%%'),linuxthreads)
use_linuxthreads = yes
endif
endif

WORKBLD = $(WORKSRC)_build

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKBLD)/Makefile
INSTALL_SCRIPTS   = $(WORKBLD)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-profile \
	--enable-omitfp \
	--enable-bind-now \
	--with-binutils=$(build_DESTDIR)$(build_bindir) \
	--without-gd \
	--without-cvs \
	--with-elf \
	--with-headers=$(DESTDIR)$(includedir) \
	--cache-file=config.cache
ifeq ($(use_linuxthreads),yes)
CONFIGURE_ARGS += \
	--enable-add-ons=linuxthreads \
	--without-tls \
	--without-__thread
else
CONFIGURE_ARGS += \
	--enable-add-ons=nptl \
	--with-tls \
	--with-__thread
endif
INSTALL_ARGS    = \
	install_root=$(DESTDIR)

GAR_EXTRA_CONF += kernel/linux/package-api.mk

include ../../gar.mk

pre-configure:
	@mkdir -p $(WORKBLD)
	@rm -rf $(WORKBLD)/configparms
	@echo "slibdir=$(elibdir)" >> $(WORKBLD)/configparms
	@rm -rf $(WORKBLD)/config.cache
	@echo "libc_cv_forced_unwind=yes" >> $(WORKBLD)/config.cache
	@echo "libc_cv_c_cleanup=yes"     >> $(WORKBLD)/config.cache
	@$(MAKECOOKIE)

configure-custom:
	@mkdir -p $(WORKBLD)
	@cd $(WORKBLD) && $(CONFIGURE_ENV) ./$(call DIRSTODOTS,$(WORKBLD))/$(WORKSRC)/configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

post-install:
	@sed -i 's% $(elibdir)/% $(DESTDIR)$(elibdir)/%g' $(DESTDIR)$(libdir)/libpthread.so
	@sed -i 's% $(libdir)/% $(DESTDIR)$(libdir)/%g' $(DESTDIR)$(libdir)/libpthread.so
	@sed -i 's% $(elibdir)/% $(DESTDIR)$(elibdir)/%g' $(DESTDIR)$(libdir)/libc.so
	@sed -i 's% $(libdir)/% $(DESTDIR)$(libdir)/%g' $(DESTDIR)$(libdir)/libc.so
	@$(MAKECOOKIE)
