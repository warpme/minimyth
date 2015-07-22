GARNAME = glew
GARVERSION = 1.12.0
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://downloads.sourceforge.net/project/$(GARNAME)/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tgz
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENSE.txt

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	$(CATEGORY)/glu \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libXi \
	$(CATEGORY)/libXmu \
	$(CATEGORY)/libXext \
	$(CATEGORY)/Mesa

PWD := $(shell pwd)
CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

WORKBLD = $(WORKSRC)_build

CONFIGURE_SCRIPTS  = $(WORKBLD)/cmake
BUILD_SCRIPTS      = $(WORKBLD)/Makefile
INSTALL_SCRIPTS    = $(WORKBLD)/Makefile

CONFIGURE_ARGS  = \
	-DCMAKE_FIND_ROOT_PATH="$(DESTDIR)$(prefix)" \
	-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM="NEVER" \
	-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY="ONLY" \
	-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE="ONLY" \
	-DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE="ONLY" \
	-DCMAKE_C_COMPILER="$(build_DESTDIR)$(build_bindir)/$(CC)" \
	-DCMAKE_CXX_COMPILER="$(build_DESTDIR)$(build_bindir)/$(CXX)" \
	-DCMAKE_AR="$(build_DESTDIR)$(build_bindir)/$(AR)" \
	-DCMAKE_LINKER="$(build_DESTDIR)$(build_bindir)/$(LD)" \
	-DCMAKE_NM="$(build_DESTDIR)$(build_bindir)/$(NM)" \
	-DCMAKE_OBJCOPY="$(build_DESTDIR)$(build_bindir)/$(OBJCOPY)" \
	-DCMAKE_OBJDUMP="$(build_DESTDIR)$(build_bindir)/$(OBJDUMP)" \
	-DCMAKE_RANLIB="$(build_DESTDIR)$(build_bindir)/$(RANLIB)" \
	-DCMAKE_STRIP="$(build_DESTDIR)$(build_bindir)/$(STRIP)" \
	-DCMAKE_INSTALL_PREFIX="$(prefix)" \
	-DCMAKE_STAGING_PREFIX="$(DESTDIR)$(prefix)" \
	-DCMAKE_VERBOSE_MAKEFILE="ON"
ifneq ($(DESTIMG),build)
CONFIGURE_ARGS += \
	-DCMAKE_SYSTEM_NAME="Linux"
endif

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

configure-%/cmake: 
	@echo " ==> Running configure in $*"
	@rm -rf $*
	@mkdir -p $*
	@cd $* && $(CONFIGURE_ENV) cmake $(CONFIGURE_ARGS) ../$(DISTNAME)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libGLEW.a
	@rm -f $(DESTDIR)$(libdir)/libGLEWmx.a
	@$(MAKECOOKIE)
