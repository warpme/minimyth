GARNAME = qt-x11-free
GARVERSION = 3.3.8b
CATEGORIES = qt
MASTER_SITES = ftp://ftp.trolltech.com/qt/source/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2/GPL3

DESCRIPTION = 
define BLURB
endef

DEPENDS    = lang/c lang/c++ lib/libjpeg lib/libmng lib/libpng lib/zlib db/mysql lib/freetype lib/fontconfig xorg/xorg
BUILDDEPS  = devel/bison devel/flex
ifneq ($(DESTIMG),build)
BUILDDEPS += qt/qt3
endif

PWD := $(shell pwd)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	-prefix $(qtprefix) \
	-bindir $(qtbindir) \
	-libdir $(qtlibdir) \
	-headerdir $(qtincludedir) \
	$(if $(filter yes,$(mm_DEBUG)),-debug,-release) \
	-shared \
	-qt-gif \
	-system-zlib \
	-no-fast \
	-no-exceptions \
	-platform $(PLATFORM_GARBUILD_NAME) \
	-plugin-sql-mysql -I$(DESTDIR)$(includedir)/mysql -L$(DESTDIR)$(libdir)/mysql \
	-thread \
	-no-nis \
	-no-pch \
	-no-cups \
	-largefile \
	-stl \
	-no-ipv6 \
	-verbose \
	-qt-imgfmt-png \
	-qt-imgfmt-jpeg \
	-qt-imgfmt-mng \
	-system-libpng \
	-system-libjpeg \
	-system-libmng \
	-no-nas-sound \
	-no-sm \
	-no-xshape \
	-xinerama \
	-no-xcursor \
	-xrandr \
	-xrender \
	-xft \
	-no-tablet \
	-no-xkb \
	-no-dlopen-opengl
ifeq ($(DESTIMG),build)
BUILD_ENV = \
	LD_LIBRARY_PATH="$(PWD)/$(WORKSRC)/lib:$(LD_LIBRARY_PATH)"
else
CONFIGURE_ARGS += \
	-xplatform $(PLATFORM_GARHOST_NAME)
endif
INSTALL_ARGS = \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += devel/gcc/package-api.mk devel/glibc/package-api.mk
include ../../gar.mk

PLATFORM_INITIAL_NAME  = linux-g++
PLATFORM_GARBUILD_NAME = $(PLATFORM_INITIAL_NAME)-garbuild
PLATFORM_GARHOST_NAME  = $(PLATFORM_INITIAL_NAME)-garhost
PLATFORM_DEFAULT_NAME  = default
PLATFORM_INITIAL_PATH  = $(WORKSRC)/mkspecs/$(PLATFORM_INITIAL_NAME)
PLATFORM_GARBUILD_PATH = $(WORKSRC)/mkspecs/$(PLATFORM_GARBUILD_NAME)
PLATFORM_GARHOST_PATH  = $(WORKSRC)/mkspecs/$(PLATFORM_GARHOST_NAME)
PLATFORM_DEFAULT_PATH  = $(DESTDIR)$(qtprefix)/mkspecs/$(PLATFORM_DEFAULT_NAME)

QMAKE_INCLUDES     = \
	$(filter  -I%, $($(strip $(1))CPPFLAGS)) \
	-I$($(strip $(1))DESTDIR)$($(strip $(1))includedir)/mysql
QMAKE_NONINCLUDES  = \
	$(filter-out  -I%, $($(strip $(1))CPPFLAGS))
QMAKE_LIBS         = \
	$(filter  -L%, $($(strip $(1))LDFLAGS)) \
	-L$($(strip $(1))DESTDIR)$($(strip $(1))libdir)/mysql
QMAKE_NONLIBS      = \
	$(filter-out  -L%, $($(strip $(1))LDFLAGS))
QMAKE_RPATH        = \
	-Wl,-rpath-link,
QMAKE_RPATHS       = \
	$(subst  -L,  $(QMAKE_RPATH),  $(call QMAKE_LIBS, $(1)))
QMAKE_CFLAGS       = \
	$(call QMAKE_INCLUDES, $(1)) $(call QMAKE_LIBS, $(1))
QMAKE_LFLAGS       = \
	$(call QMAKE_NONLIBS, $(1)) $(call QMAKE_LIBS, $(1)) $(call QMAKE_RPATHS, $(1))

UPDATE_PLATFORM   = sed -i 's%^\($(strip $(2))[ \t]*=\).*%\1 $(strip $(3))%g' $(strip $(1))/qmake.conf 
# We should not need to provide QMAKE_INCDIR or QMAKE_LIBDIR since they are compiled into the compiler and linker.
# However, the QT configure program does not find the supported libraries without them.
# We add --preserve=timestamps to QMAKE_COPY so that files installed using qmake generated make files keep their
# original dates. This keeps the dates of the MythTV themes with their original dates so that themecahes are not
# needlessly regenerated when MiniMyth is updated.
CREATE_PLATFORM   = \
	rm -rf $(1) ; \
	cp -r $(PLATFORM_INITIAL_PATH) $(1) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_COPY          , cp -f --preserve=timestamps) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_YACC          , bison -y) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_CC            , $($(strip $(2))CC)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_CXX           , $($(strip $(2))CXX)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_LINK          , $($(strip $(2))CXX)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_LINK_SHLIB    , $($(strip $(2))CXX)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_AR            , $($(strip $(2))AR) cqs) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_RANLIB        , $($(strip $(2))RANLIB)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_STRIP         , $($(strip $(2))STRIP)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_CFLAGS        , $(call QMAKE_CFLAGS, $(2))) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_CFLAGS_RELEASE, $($(strip $(2))CFLAGS)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_LFLAGS        , $(call QMAKE_LFLAGS, $(2))) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_RPATH         , ) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_INCDIR        , $($(strip $(2))DESTDIR)$($(strip $(2))includedir)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_LIBDIR        , $($(strip $(2))DESTDIR)$($(strip $(2))libdir)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_INCDIR_X11    , $($(strip $(2))DESTDIR)$($(strip $(2))includedir)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_LIBDIR_X11    , $($(strip $(2))DESTDIR)$($(strip $(2))libdir)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_INCDIR_OPENGL , $($(strip $(2))DESTDIR)$($(strip $(2))includedir)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_LIBDIR_OPENGL , $($(strip $(2))DESTDIR)$($(strip $(2))libdir)) ;

ifeq ($(DESTIMG),build)
USE_BUILD_BIN =
else
USE_BUILD_BIN = \
	mkdir -p $(WORKSRC)/bin ; \
	ln -sf $(build_DESTDIR)$(build_qtprefix)/bin/$(strip $(1)) $(WORKSRC)/bin/$(strip $(1))
endif

pre-configure:
	@$(call CREATE_PLATFORM, $(PLATFORM_GARBUILD_PATH), build_)
	@$(call CREATE_PLATFORM, $(PLATFORM_GARHOST_PATH) ,       )
	@$(MAKECOOKIE)

configure-%/configure:
	@cd $* && $(CONFIGURE_ENV) echo "yes" | ./configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

post-configure:
	@# Work around bug in qmake.
	@desired=`echo /$(qtprefix)/ | sed -e 's%//*%/%g'` ; \
	 if [ -e "$${desired}" ] ; then \
		actual=`cd $${desired} ; pwd -P` ; \
		actual=`echo /$${actual}/ | sed -e 's%//%/%g'` ; \
		if [ "$${actual}" != "$${desired}" ] ; then \
			sed -i -e "s%\$$(INSTALL_ROOT)$${actual}%\$$(INSTALL_ROOT)$${desired}%g" `find $(WORKSRC) -name Makefile` ; \
		fi ; \
	 fi
	@# 
	@$(call USE_BUILD_BIN, uic)
	@$(MAKECOOKIE)

pre-install:
	@$(foreach dir, $(filter-out %/Makefile %/qt3,$(subst ../../,,$(wildcard ../../qt*))), $(MAKE) clean-all -C $(dir))
	@rm -rf $(DESTDIR)$(qtprefix)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(qtbindir)/qmake ; cp $(WORKSRC)/bin/qmake $(DESTDIR)$(qtbindir)
	@rm -f $(DESTDIR)$(qtlibdir)/libqt-mt.la
	@rm -f $(PLATFORM_DEFAULT_PATH)
	@ln -sf $(PLATFORM_GARHOST_NAME) $(PLATFORM_DEFAULT_PATH)
	@$(call UPDATE_PLATFORM, $(PLATFORM_DEFAULT_PATH), QMAKE_INCDIR_QT, $(DESTDIR)$(qtincludedir))
	@$(call UPDATE_PLATFORM, $(PLATFORM_DEFAULT_PATH), QMAKE_LIBDIR_QT, $(DESTDIR)$(qtlibdir))
	@$(call UPDATE_PLATFORM, $(PLATFORM_DEFAULT_PATH), QMAKE_MOC,       $(build_DESTDIR)$(build_qtbindir)/moc)
	@$(call UPDATE_PLATFORM, $(PLATFORM_DEFAULT_PATH), QMAKE_UIC,       $(build_DESTDIR)$(build_qtbindir)/uic)
	@$(call GLIBC_ADD_LIB_PATH, $(qtlibdir))
	@sed -e 's%-I$(DESTDIR)$(includedir)%-I$${includedir}%g' -i $(DESTDIR)$(qtlibdir)/pkgconfig/qt-mt.pc
	@sed -e 's%-L$(DESTDIR)$(libdir)%-L$${libdir}%g'         -i $(DESTDIR)$(qtlibdir)/pkgconfig/qt-mt.pc
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(qtprefix)
