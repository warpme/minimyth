GARNAME = Python
GARVERSION =  $(PYTHON_VERSION)
CATEGORIES = python
MASTER_SITES = http://www.python.org/ftp/python/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  = $(DISTNAME)-configure.patch
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-cross.patch
endif
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS    = lang/c
BUILDDEPS  =
ifneq ($(DESTIMG),build)
BUILDDEPS += python/python
endif

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile
ifeq ($(DESTIMG),build)
INSTALL_SCRIPTS   += cross
endif

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-shared
ifneq ($(DESTIMG),build)
BUILD_ARGS     = \
	HOSTPYTHON=$(build_DESTDIR)$(build_bindir)/python \
	HOSTPGEN=$(build_DESTDIR)$(build_bindir)/python-pgen \
	BLDSHARED="$(CC) -shared" \
	CROSS_COMPILE=$(compiler_prefix) \
	CROSS_COMPILE_TARGET=yes
INSTALL_ARGS   = \
	HOSTPYTHON=$(build_DESTDIR)$(build_bindir)/python \
	HOSTPGEN=$(build_DESTDIR)$(build_bindir)/python-pgen \
	BLDSHARED="$(CC) -shared" \
	CROSS_COMPILE=$(compiler_prefix) \
	CROSS_COMPILE_TARGET=yes
endif
	
ifneq ($(DESTIMG),build)
CONFIGURE_ENV = \
	ac_cv_file_dev_ptc=no \
	ac_cv_file_dev_ptmx=yes \
	ac_cv_func_lchflags_works=no \
	ac_cv_func_chflags_works=no \
	ac_cv_func_printf_zd=yes
endif

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

install-cross:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp -f $(WORKSRC)/Parser/pgen $(DESTDIR)$(bindir)/python-pgen
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/python2.6/config/libpython2.6.a
	@rm -f $(DESTDIR)$(bindir)-config/python2.6-config
	@rm -f $(DESTDIR)$(bindir)-config/python-config
	@rm -f $(DESTDIR)$(bindir)-config/$(compiler_prefix)python2.6-config
	@rm -f $(DESTDIR)$(bindir)-config/$(compiler_prefix)python-config
	@mkdir -p $(DESTDIR)$(bindir)-config
	@mv $(DESTDIR)$(bindir)/python2.6-config $(DESTDIR)$(bindir)-config/python2.6-config
	@mv $(DESTDIR)$(bindir)/python-config $(DESTDIR)$(bindir)-config/python-config
	@$(if $(compiler_prefix), ln -s python2.6-config $(DESTDIR)$(bindir)-config/$(compiler_prefix)python2.6-config)
	@$(if $(compiler_prefix), ln -s python-config $(DESTDIR)$(bindir)-config/$(compiler_prefix)python-config)
	@$(MAKECOOKIE)
