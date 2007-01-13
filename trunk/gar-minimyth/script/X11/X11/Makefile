GARNAME = X11
GARVERSION = 6.8.1
CATEGORIES = X11
MASTER_SITES  = http://xorg.freedesktop.org/$(GARNAME)R$(GARVERSION)/src-single/
MASTER_SITES += ftp://ftp.x.org/pub/$(GARNAME)R$(GARVERSION)/src-single/
MASTER_SITES += cvs://anoncvs@cvs.freedesktop.org:/cvs/xorg/
MASTER_SITES += http://unc.dl.sourceforge.net/sourceforge/unichrome/
MASTER_SITES += cvs://anonymous@cvs.sourceforge.net:/cvsroot/unichrome/
DISTFILES = $(GARNAME)R$(GARVERSION)-src.tar.bz2
PATCHFILES  = $(GARNAME)R$(GARVERSION).patch $(GARNAME)R$(GARVERSION)-relpath.patch
PATCHFILES += $(UNICHROME_X_DISTNAME).tar.gz $(UNICHROME_XvMC_DISTNAME).tar.gz
LICENSE = xorg
xorg_LICENSE_TEXT = $(WORKSRC)/programs/Xserver/hw/xfree86/doc/LICENSE

UNICHROME_X_GARNAME    = unichrome-X
UNICHROME_X_GARVERSION = r30
UNICHROME_X_DISTNAME   = $(UNICHROME_X_GARNAME)-$(UNICHROME_X_GARVERSION)

UNICHROME_XvMC_GARNAME    = libxvmc
UNICHROME_XvMC_GARVERSION = release-0-13-3
UNICHROME_XvMC_DISTNAME   = $(UNICHROME_XvMC_GARNAME)-$(UNICHROME_XvMC_GARVERSION)

DESCRIPTION = 
define BLURB
endef

DEPENDS    = lang/c lang/c++ kernel/linux-libc-headers lib/expat lib/libpng lib/ncurses lib/zlib X11/freetype X11/fontconfig
BUILDDEPS  = devel/bison devel/flex
ifneq ($(DESTIMG),build)
BUILDDEPS += X11/X11
endif

WORKSRC = $(WORKDIR)/xc

CONFIGURE_SCRIPTS = os directory compiler installed_hardware installed_software X11_fonts X11_docs X11_misc
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

BUILD_ARGS = World
ifneq ($(DESTIMG),build)
BUILD_ARGS += CROSSCOMPILEDIR="$(build_DESTDIR)$(build_prefix)/$(GARHOST)/bin"
endif

GAR_EXTRA_CONF += devel/gcc/package-api.mk devel/glibc/package-api.mk kernel/linux/package-api.mk X11/fontconfig/package-api.mk
include ../../gar.mk

CDebugFlags  := $(filter-out $(CPPFLAGS) $(LDFLAGS), $(CFLAGS))
HostCcCmd    := $(build_CC)
CppCmd       := $(shell echo $(CPP)    | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
CcCmd        := $(shell echo $(CC)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
CplusplusCmd := $(shell echo $(CXX)    | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
LdCmd        := $(shell echo $(LD)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
RanlibCmd    := $(shell echo $(RANLIB) | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
AsCmd        := $(shell echo $(AS)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
ArCmd        := $(shell echo $(AR)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')

# Set compiler and clear compiler flags so that they do not cause
# problems when compiling with HostCcCmd.
CC       := $(build_CC)
CPPFLAGS :=
CFLAGS   :=
CXXFLAGS :=
LDFLAGS  :=

CONFIG_FILE = \
	$(WORKSRC)/config/cf/site.def

CONFIG_FILE_REMOVE = \
	rm -rf $(CONFIG_FILE)

CONFIG_FILE_HEADER = \
	echo "/*"               >> $(CONFIG_FILE); \
	echo " * $(strip $(1))" >> $(CONFIG_FILE); \
	echo " */"              >> $(CONFIG_FILE)

CONFIG_FILE_APPEND = \
	echo "\#undef  $(1)"      >> $(CONFIG_FILE); \
	echo "\#define $(1) $(2)" >> $(CONFIG_FILE)

cvs//%$(UNICHROME_X_DISTNAME).tar.gz:
	@cd $(PARTIALDIR); rm -rf $(UNICHROME_X_GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -r $(UNICHROME_X_GARVERSION) $(UNICHROME_X_GARNAME)
	@cd $(PARTIALDIR); rm -rf $(UNICHROME_X_DISTNAME)
	@cd $(PARTIALDIR); mv $(UNICHROME_X_GARNAME) $(UNICHROME_X_DISTNAME)
	@cd $(PARTIALDIR); tar -zc $(UNICHROME_X_DISTNAME) -f $(UNICHROME_X_DISTNAME).tar.gz
	@cd $(PARTIALDIR); rm -rf $(UNICHROME_X_DISTNAME)
	@$(MAKECOOKIE)

cvs//%$(UNICHROME_XvMC_DISTNAME).tar.gz:
	@cd $(PARTIALDIR); rm -rf $(UNICHROME_XvMC_GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -r $(UNICHROME_XvMC_GARVERSION) $(UNICHROME_XvMC_GARNAME)
	@cd $(PARTIALDIR); rm -rf $(UNICHROME_XvMC_DISTNAME)
	@cd $(PARTIALDIR); mv $(UNICHROME_XvMC_GARNAME) $(UNICHROME_XvMC_DISTNAME)
	@cd $(PARTIALDIR); tar -zc $(UNICHROME_XvMC_DISTNAME) -f $(UNICHROME_XvMC_DISTNAME).tar.gz
	@cd $(PARTIALDIR); rm -rf $(UNICHROME_XvMC_DISTNAME)
	@$(MAKECOOKIE)

checksum-$(UNICHROME_XvMC_DISTNAME).tar.gz:
	@$(MAKECOOKIE)

patch-$(UNICHROME_X_DISTNAME).tar.gz:
	@gzip -dc $(DOWNLOADDIR)/$(UNICHROME_X_DISTNAME).tar.gz | tar -xf - -C $(EXTRACTDIR)
	@rm -rf $(WORKSRC)/programs/Xserver/hw/xfree86/drivers/via
	@cp -r $(EXTRACTDIR)/$(UNICHROME_X_DISTNAME) $(WORKSRC)/programs/Xserver/hw/xfree86/drivers/via
	@$(MAKECOOKIE)

patch-$(UNICHROME_XvMC_DISTNAME).tar.gz:
	@gzip -dc $(DOWNLOADDIR)/$(UNICHROME_XvMC_DISTNAME).tar.gz | tar -xf - -C $(EXTRACTDIR)
	@rm -rf $(WORKSRC)/lib/XvMC/hw/via
	@cp -r $(EXTRACTDIR)/$(UNICHROME_XvMC_DISTNAME) $(WORKSRC)/lib/XvMC/hw/via
	@sed -i '/^SUBDIRS *=/ { s% hw/via%%g; s%.*%& hw/via% }' $(WORKSRC)/lib/XvMC/Imakefile
	@$(MAKECOOKIE)

configure-os:
	$(call GLIBC_ADD_LIB_PATH, $(libdir)/gcc/$(GARHOST)/$(GCC_VERSION))
	@$(call CONFIG_FILE_HEADER, Operating System.)
	@$(call CONFIG_FILE_APPEND, LinuxDistribution         , 0)
	@$(call CONFIG_FILE_APPEND, DefaultOSMajorVersion     , $(KERNEL_MAJOR_VERSION))
	@$(call CONFIG_FILE_APPEND, DefaultOSMinorVersion     , $(KERNEL_MINOR_VERSION))
	@$(call CONFIG_FILE_APPEND, DefaultOSTeenyVersion     , $(KERNEL_SUBMINOR_VERSION))
	@$(MAKECOOKIE)

configure-directory:
	@$(call CONFIG_FILE_HEADER, Directory structure.)
	@$(call CONFIG_FILE_APPEND, X11ProjectRoot            , $(build_DESTDIR)$(build_x11prefix))
	@$(call CONFIG_FILE_APPEND, ProjectRoot               , $(x11prefix))
	@$(call CONFIG_FILE_APPEND, IncRoot                   , $(x11includedir))
	@$(call CONFIG_FILE_APPEND, BinDir                    , $(x11bindir))
	@$(call CONFIG_FILE_APPEND, UsrLibDir                 , $(x11libdir))
	@$(call CONFIG_FILE_APPEND, LibexecDir                , $(x11libdir))
	@$(call CONFIG_FILE_APPEND, EtcX11Directory           , $(sysconfdir)/X11)
	@$(call CONFIG_FILE_APPEND, ProjectVar                , $(localstatedir))
	@$(call CONFIG_FILE_APPEND, SystemUsrIncDir           , $(DESTDIR)$(includedir))
	@$(call CONFIG_FILE_APPEND, SystemUsrLibDir           , $(DESTDIR)$(libdir))
	@$(call CONFIG_FILE_APPEND, SystemManDirectory        , $(DESTDIR)$(mandir))
	@$(call CONFIG_FILE_APPEND, PreIncDir                 , )
	@$(call CONFIG_FILE_APPEND, StdIncDir                 , $(DESTDIR)$(includedir))
	@$(call CONFIG_FILE_APPEND, DefaultGccIncludeDir      , $(CROSS_GCC_INCLUDEDIR))
	@$(call CONFIG_FILE_APPEND, LinkGLToUsrLib            , NO)
	@$(call CONFIG_FILE_APPEND, LinkGLToUsrInclude        , NO)
	@$(MAKECOOKIE)

# CDebugFlags should be set in CONFIG_FILE. However, when cross compiling,
# three utilities (makekeys, mkg3states and gen_matypes) that are compiled to
# run on the host pick up some of the cross compile compiler flags, including
# *CDebugFlags. Therefore, we include CDebugFlags as part of CcCmd and
# CplusplusCmd and clear that *CDebugFlags to work around the problem.
configure-compiler:
	@$(call CONFIG_FILE_HEADER, Compiler.)
	@$(call CONFIG_FILE_APPEND, UseInstalledOnCrossCompile, YES)
	@$(call CONFIG_FILE_APPEND, HasGcc3                   , YES)
	@$(call CONFIG_FILE_APPEND, HostCcCmd                 , $(HostCcCmd))
	@$(call CONFIG_FILE_APPEND, HasCplusplus              , YES)
	@$(call CONFIG_FILE_APPEND, DoRanlibCmd               , YES)
	@$(call CONFIG_FILE_APPEND, CppCmd                    , $(CppCmd))
	@$(call CONFIG_FILE_APPEND, CcCmd                     , $(CcCmd) $(CDebugFlags))
	@$(call CONFIG_FILE_APPEND, CplusplusCmd              , $(CplusplusCmd) $(CDebugFlags))
	@$(call CONFIG_FILE_APPEND, AsCmd                     , $(AsCmd))
	@$(call CONFIG_FILE_APPEND, LdCmd                     , $(LdCmd))
	@$(call CONFIG_FILE_APPEND, ArCmdBase                 , $(ArCmd))
	@$(call CONFIG_FILE_APPEND, RanlibCmd                 , $(RanlibCmd))
	@$(call CONFIG_FILE_APPEND, DefaultCDebugFlags        , )
	@$(call CONFIG_FILE_APPEND, OptimizedCDebugFlags      , )
	@$(call CONFIG_FILE_APPEND, AlternateIncRoot          , YES)
	@$(call CONFIG_FILE_APPEND, AlternateUsrLibDir        , YES)
	@$(MAKECOOKIE)

configure-installed_hardware:
	@$(call CONFIG_FILE_HEADER, Installed hardware.)
	@$(call CONFIG_FILE_APPEND, XF86CardDrivers           , via)
	@$(call CONFIG_FILE_APPEND, DriDrivers                , via)
	@$(call CONFIG_FILE_APPEND, XInputDrivers             , mouse keyboard)
	@$(MAKECOOKIE)

TermcapLibrary = StaticLibrary($(DESTDIR)$(libdir),ncurses)
configure-installed_software:
	@$(call CONFIG_FILE_HEADER, Installed software.)
	@$(call CONFIG_FILE_APPEND, HasExpat                  , YES)
	@$(call CONFIG_FILE_APPEND, ExpatDir                  , $(DESTDIR)$(prefix))
	@$(call CONFIG_FILE_APPEND, ExpatIncDir               , $(DESTDIR)$(includedir))
	@$(call CONFIG_FILE_APPEND, ExpatLibDir               , $(DESTDIR)$(libdir))
	@$(call CONFIG_FILE_APPEND, HasFontconfig             , YES)
	@$(call CONFIG_FILE_APPEND, FontconfigDir             , $(DESTDIR)$(prefix))
	@$(call CONFIG_FILE_APPEND, FontconfigBinDir          , $(DESTDIR)$(bindir))
	@$(call CONFIG_FILE_APPEND, FontconfigIncDir          , $(DESTDIR)$(includedir))
	@$(call CONFIG_FILE_APPEND, FontconfigLibDir          , $(DESTDIR)$(libdir))
	@$(call CONFIG_FILE_APPEND, HasFreetype2              , YES)
	@$(call CONFIG_FILE_APPEND, Freetype2Dir              , $(DESTDIR)$(prefix))
	@$(call CONFIG_FILE_APPEND, Freetype2IncDir           , $(DESTDIR)$(includedir))
	@$(call CONFIG_FILE_APPEND, Freetype2LibDir           , $(DESTDIR)$(libdir))
	@$(call CONFIG_FILE_APPEND, HasGhostPCL               , NO)
	@$(call CONFIG_FILE_APPEND, HasGhostScript            , NO)
	@$(call CONFIG_FILE_APPEND, HasLibpng                 , YES)
	@$(call CONFIG_FILE_APPEND, LibpngDir                 , $(DESTDIR)$(prefix))
	@$(call CONFIG_FILE_APPEND, LibpngIncDir              , $(DESTDIR)$(includedir))
	@$(call CONFIG_FILE_APPEND, LibpngLibDir              , $(DESTDIR)$(libdir))
	@$(call CONFIG_FILE_APPEND, HasNCurses                , YES)
	@$(call CONFIG_FILE_APPEND, TermcapLibrary            , $(TermcapLibrary))
	@$(call CONFIG_FILE_APPEND, HasPam                    , NO)
	@$(call CONFIG_FILE_APPEND, HasShadowPassword         , NO)
	@$(call CONFIG_FILE_APPEND, HasTcl                    , NO)
	@$(call CONFIG_FILE_APPEND, HasTk                     , NO)
	@$(call CONFIG_FILE_APPEND, HasZlib                   , YES)
	@$(MAKECOOKIE)

configure-X11_fonts:
	@$(call CONFIG_FILE_HEADER, X11 fonts.)
	@$(call CONFIG_FILE_APPEND, BuildFontServer           , NO)
	@$(call CONFIG_FILE_APPEND, BuildFonts                , YES)
	@$(call CONFIG_FILE_APPEND, MakeLocalFontDir          , YES)
	@$(call CONFIG_FILE_APPEND, BuildSpeedo               , NO)
	@$(call CONFIG_FILE_APPEND, BuildType1                , NO)
	@$(call CONFIG_FILE_APPEND, BuildCID                  , NO)
	@$(call CONFIG_FILE_APPEND, BuildFreeType             , YES)
	@$(call CONFIG_FILE_APPEND, BuildBuiltinFonts         , NO)
	@$(call CONFIG_FILE_APPEND, Build75DpiFonts           , NO)
	@$(call CONFIG_FILE_APPEND, Build100DpiFonts          , NO)
	@$(call CONFIG_FILE_APPEND, BuildSpeedoFonts          , NO)
	@$(call CONFIG_FILE_APPEND, BuildType1Fonts           , NO)
	@$(call CONFIG_FILE_APPEND, BuildCIDFonts             , NO)
	@$(call CONFIG_FILE_APPEND, BuildTrueTypeFonts        , YES)
	@$(call CONFIG_FILE_APPEND, BuildBethMarduthoFonts    , NO)
	@$(call CONFIG_FILE_APPEND, BuildEthiopicFonts        , NO)
	@$(call CONFIG_FILE_APPEND, BuildCyrillicFonts        , NO)
	@$(call CONFIG_FILE_APPEND, BuildUCSFonts             , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_1Fonts       , YES)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_2Fonts       , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_3Fonts       , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_4Fonts       , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_5Fonts       , NO)
	@$(call CONFIG_FILE_APPEND, BuildArabicFonts          , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_6Fonts       , NO)
	@$(call CONFIG_FILE_APPEND, BuildGreekFonts           , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_7Fonts       , NO)
	@$(call CONFIG_FILE_APPEND, BuildHebrewFonts          , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_8Fonts       , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_9Fonts       , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_10Fonts      , NO)
	@$(call CONFIG_FILE_APPEND, BuildThaiFonts            , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_11Fonts      , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_13Fonts      , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_14Fonts      , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_15Fonts      , NO)
	@$(call CONFIG_FILE_APPEND, BuildISO8859_16Fonts      , NO)
	@$(call CONFIG_FILE_APPEND, BuildKOI8_RFonts          , NO)
	@$(call CONFIG_FILE_APPEND, BuildJapaneseFonts        , NO)
	@$(call CONFIG_FILE_APPEND, BuildJISX0201Fonts        , NO)
	@$(call CONFIG_FILE_APPEND, BuildKoreanFonts          , NO)
	@$(call CONFIG_FILE_APPEND, BuildChineseFonts         , NO)
	@$(MAKECOOKIE)

configure-X11_docs:
	@$(call CONFIG_FILE_APPEND, BuildDocs                 , NO)
	@$(call CONFIG_FILE_APPEND, BuildMiscDocs             , NO)
	@$(call CONFIG_FILE_APPEND, BuildSpecsDocs            , NO)
	@$(call CONFIG_FILE_APPEND, BuildAllSpecsDocs         , NO)
	@$(call CONFIG_FILE_APPEND, BuildLinuxDocHTML         , NO)
	@$(call CONFIG_FILE_APPEND, BuildLinuxDocPS           , NO)
	@$(call CONFIG_FILE_APPEND, BuildLinuxDocText         , NO)
	@$(call CONFIG_FILE_APPEND, BuildHtmlManPages         , NO)
	@$(MAKECOOKIE)

configure-X11_misc:
	@$(call CONFIG_FILE_HEADER, X11 features.)
	@$(call CONFIG_FILE_APPEND, BuildServer               , YES)
	@$(call CONFIG_FILE_APPEND, BuildClients              , YES)
	@$(call CONFIG_FILE_APPEND, BuildXprint               , NO)
	@$(call CONFIG_FILE_APPEND, XnestServer               , NO)
	@$(call CONFIG_FILE_APPEND, BuildXAudio               , NO)
	@$(call CONFIG_FILE_APPEND, BuildXFree86ConfigTools   , NO)
	@$(call CONFIG_FILE_APPEND, BuildXcursorLibrary       , NO)
	@$(call CONFIG_FILE_APPEND, BuildXcursorgen           , NO)
	@$(call CONFIG_FILE_APPEND, BuildRandR                , NO)
	@$(call CONFIG_FILE_APPEND, BuildRandRLibrary         , NO)
	@$(call CONFIG_FILE_APPEND, BuildDmx                  , NO)
	@$(call CONFIG_FILE_APPEND, BuildXterm                , YES)
	@$(call CONFIG_FILE_APPEND, HasMMXSupport             , $(if $(filter $(GARCH), c3 c3-2),YES,NO))
	@$(call CONFIG_FILE_APPEND, Has3DNowSupport           , $(if $(filter $(GARCH), c3     ),YES,NO))
	@$(call CONFIG_FILE_APPEND, HasSSESupport             , $(if $(filter $(GARCH),    c3-2),YES,NO))
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(bindir)/X11
	@rm -f $(DESTDIR)$(includedir)/X11
	@rm -f $(DESTDIR)$(libdir)/X11
	@ln -sf ./$(call DIRSTODOTS,$(bindir))/$(x11bindir)             $(DESTDIR)$(bindir)/X11
	@ln -sf ./$(call DIRSTODOTS,$(includedir))/$(x11includedir)/X11 $(DESTDIR)$(includedir)/X11
	@ln -sf ./$(call DIRSTODOTS,$(libdir))/$(x11libdir)/X11         $(DESTDIR)$(libdir)/X11
	@cp $(WORKSRC)/lib/XvMC/hw/via/vldXvMC.h $(DESTDIR)$(x11includedir)/X11/extensions
	@$(call GLIBC_ADD_LIB_PATH, $(x11prefix)/lib)
	@for file in `cd $(DESTDIR)$(x11libdir)/pkgconfig ; ls -1` ; do \
		sed -i 's%-L$(x11libdir)%-L$(DESTDIR)$(x11libdir)%g'         $(DESTDIR)$(x11libdir)/pkgconfig/$${file} ; \
		sed -i 's%-I$(x11includedir)%-I$(DESTDIR)$(x11includedir)%g' $(DESTDIR)$(x11libdir)/pkgconfig/$${file} ; \
		sed -i 's%-L$(libdir)%-L$(DESTDIR)$(libdir)%g'               $(DESTDIR)$(x11libdir)/pkgconfig/$${file} ; \
		sed -i 's%-I$(includedir)%-I$(DESTDIR)$(includedir)%g'       $(DESTDIR)$(x11libdir)/pkgconfig/$${file} ; \
		sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'             $(DESTDIR)$(x11libdir)/pkgconfig/$${file} ; \
		sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g'     $(DESTDIR)$(x11libdir)/pkgconfig/$${file} ; \
	done
	@for file in `cd $(DESTDIR)$(x11bindir) ; ls -1 *-config` ; do \
		sed -i 's%-L$(x11libdir)%-L$(DESTDIR)$(x11libdir)%g'         $(DESTDIR)$(x11bindir)/$${file} ; \
		sed -i 's%-I$(x11includedir)%-I$(DESTDIR)$(x11includedir)%g' $(DESTDIR)$(x11bindir)/$${file} ; \
		sed -i 's%-L$(libdir)%-L$(DESTDIR)$(libdir)%g'               $(DESTDIR)$(x11bindir)/$${file} ; \
		sed -i 's%-I$(includedir)%-I$(DESTDIR)$(includedir)%g'       $(DESTDIR)$(x11bindir)/$${file} ; \
		sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'             $(DESTDIR)$(x11bindir)/$${file} ; \
		sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g'     $(DESTDIR)$(x11bindir)/$${file} ; \
	done
	@$(call FONTCONFIG_ADD_FONTDIR,$(x11libdir)/X11/fonts/TTF)
	@$(call FONTCONFIG_ADD_FONTDIR,$(x11libdir)/X11/fonts/misc)
	@$(MAKECOOKIE)
