GARNAME = drm
GARVERSION = 20041220
CATEGORIES = kernel
MASTER_SITES = cvs://anonymous@dri.freedesktop.org/cvs/dri/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c kernel/linux
BUILDDEPS = kernel/module-init-tools

WORKSRC = $(WORKDIR)/$(GARNAME)-$(GARVERSION)/linux-2.6

DRM_MODULES = via

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

DEFAULT_ARGS = \
	HOSTCC="$(build_CC)" \
	HOSTCXX="$(build_CXX)" \
	HOSTCFLAGS="$(build_CFLAGS)" \
	HOSTCXXFLAGS="$(build_CXXFLAGS)" \
	AS="$(AS)" \
	LD="$(LD)" \
	CC="$(CC)" \
	CPP="$(CPP)" \
	AR="$(AR)" \
	NM="$(NM)" \
	STRIP="$(STRIP)" \
	OBJCOPY="$(OBJCOPY)" \
	OBJDUMP="$(OBJDUMP)"
BUILD_ARGS   = $(DEFAULT_ARGS) LINUXDIR="$(DESTDIR)$(KERNEL_SOURCEDIR)" DRM_MODULES="$(DRM_MODULES)"

BUILD_ENV    = KBUILD_VERBOSE=1

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

cvs//%$(GARNAME)-$(GARVERSION).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(GARNAME)-$(GARVERSION)
	@cd $(PARTIALDIR); mv $(GARNAME) $(GARNAME)-$(GARVERSION)
	@cd $(PARTIALDIR); tar -jc $(GARNAME)-$(GARVERSION) -f $(GARNAME)-$(GARVERSION).tar.bz2
	@cd $(PARTIALDIR); rm -rf $(GARNAME)-$(GARVERSION)
	@$(MAKECOOKIE)

checksum-$(GARNAME)-$(GARVERSION).tar.bz2:
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p "$(DESTDIR)$(KERNEL_MODULESDIR)/misc/drm/"
	@cp $(WORKSRC)/*.ko "$(DESTDIR)$(KERNEL_MODULESDIR)/misc/drm/"
	@depmod -b "$(DESTDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"
	@$(MAKECOOKIE)
