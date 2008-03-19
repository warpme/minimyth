GARNAME = qt-x11-opensource-src
GARVERSION = 4.3.4
CATEGORIES = qt
MASTER_SITES = ftp://ftp.trolltech.com/qt/source/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2/GPL3

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lang/c++ db/mysql lib/freetype lib/fontconfig lib/libjpeg lib/libmng lib/libpng lib/libtiff lib/openssl lib/zlib xorg/xorg
BUILDDEPS = devel/bison devel/flex

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
	-plugin-sql-mysql -mysql_config $(DESTDIR)$(bindir)/mysql_config \
	-no-nis \
	-no-pch \
	-no-qdbus \
	-no-cups \
	-largefile \
	-stl \
	-verbose \
	-system-libtiff \
	-system-libpng \
	-system-libmng \
	-system-libjpeg \
	-openssl \
	-no-rpath \
	-no-nas-sound \
	-opengl \
	-no-sm \
	-no-xshape \
	-xinerama \
	-no-xcursor \
	-xfixes \
	-xrandr \
	-xrender \
	-fontconfig \
	-no-tablet \
	-no-xkb \
	-no-separate-debug-info \
	-no-glib \
	-little-endian
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

PLATFORM_GARBUILD_BASE_NAME = $(strip \
	$(if $(filter i386,$(build_GARCH_FAMILY)),linux-g++-32,) \
	$(if $(filter x86_64,$(build_GARCH_FAMILY)),linux-g++-64,))
PLATFORM_GARHOST_BASE_NAME = $(strip \
	$(if $(filter i386,$(GARCH_FAMILY)),linux-g++-32,) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),linux-g++-64,))
PLATFORM_GARBUILD_NAME      = $(PLATFORM_GARBUILD_BASE_NAME)-garbuild
PLATFORM_GARHOST_NAME       = $(PLATFORM_GARHOST_BASE_NAME)-garhost
PLATFORM_DEFAULT_NAME       = default
PLATFORM_GARBUILD_BASE_PATH = $(WORKSRC)/mkspecs/$(PLATFORM_GARBUILD_BASE_NAME)
PLATFORM_GARHOST_BASE_PATH  = $(WORKSRC)/mkspecs/$(PLATFORM_GARHOST_BASE_NAME)
PLATFORM_GARBUILD_PATH      = $(WORKSRC)/mkspecs/$(PLATFORM_GARBUILD_NAME)
PLATFORM_GARHOST_PATH       = $(WORKSRC)/mkspecs/$(PLATFORM_GARHOST_NAME)
PLATFORM_DEFAULT_PATH       = $(DESTDIR)$(qtprefix)/mkspecs/$(PLATFORM_DEFAULT_NAME)

QMAKE_INCLUDES    = $(filter  -I%, $($(strip $(1))CPPFLAGS))
QMAKE_NONINCLUDES = $(filter-out  -I%, $($(strip $(1))CPPFLAGS))
QMAKE_LIBS        = $(filter  -L%, $($(strip $(1))LDFLAGS))
QMAKE_NONLIBS     = $(filter-out  -L%, $($(strip $(1))LDFLAGS))
QMAKE_CFLAGS      = $(strip $(call QMAKE_INCLUDES, $(1)) $(call QMAKE_LIBS, $(1)) $(filter -m32 -m64,$($(strip $(1))CFLAGS)))
QMAKE_LFLAGS      = $(strip $(call QMAKE_NONLIBS,  $(1)) $(call QMAKE_LIBS, $(1)) $(filter -m32 -m64,$($(strip $(1))CFLAGS)))

UPDATE_PLATFORM   = sed -i 's%^\($(strip $(2))[ \t]*$(strip $(3))=[ \t]*\).*%\1$(strip $(4))%g' $(strip $(1))/qmake.conf 
# We should not need to provide QMAKE_INCDIR or QMAKE_LIBDIR since they are compiled into the compiler and linker.
# However, the QT configure program does not find the supported libraries without them.
# We add --preserve=timestamps to QMAKE_COPY so that files installed using qmake generated make files keep their
# original dates. This keeps the dates of the MythTV themes with their original dates so that themecahes are not
# needlessly regenerated when MiniMyth is updated.
CREATE_PLATFORM   = \
	rm -rf $(strip $(2)) ; \
	cp -r $(strip $(1)) $(strip $(2)) ; \
	rm -f $(strip $(2))/qmake.conf~ ; \
	echo "QMAKE_CFLAGS_RELEASE = $($(strip $(3))CFLAGS)"                          >> $(strip $(2))/qmake.conf~ ; \
	cat $(strip $(2))/qmake.conf           | grep -v '^include' | grep -v '^load' >> $(strip $(2))/qmake.conf~ ; \
	cat $(strip $(2))/../common/g++.conf   | grep -v '^include' | grep -v '^load' >> $(strip $(2))/qmake.conf~ ; \
	cat $(strip $(2))/../common/linux.conf | grep -v '^include' | grep -v '^load' >> $(strip $(2))/qmake.conf~ ; \
	cat $(strip $(2))/../common/unix.conf  | grep -v '^include' | grep -v '^load' >> $(strip $(2))/qmake.conf~ ; \
	echo 'load(qt_config)'                                                        >> $(strip $(2))/qmake.conf~ ; \
	rm -f $(strip $(2))/qmake.conf ; \
	mv -f $(strip $(2))/qmake.conf~ $(strip $(2))/qmake.conf ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_COPY          , , cp -f --preserve=timestamps) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_YACC          , , bison -y) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_CC            , , $($(strip $(3))CC)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_CXX           , , $($(strip $(3))CXX)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_LINK          , , $($(strip $(3))CXX)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_LINK_SHLIB    , , $($(strip $(3))CXX)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_AR            , , $($(strip $(3))AR) cqs) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_RANLIB        , , $($(strip $(3))RANLIB)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_STRIP         , , $($(strip $(3))STRIP)) ; \
	$(call UPDATE_PLATFORM, $(1), QMAKE_CFLAGS        , , $(call QMAKE_CFLAGS, $(3))) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_CFLAGS_RELEASE,+,) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_LFLAGS        , , $(call QMAKE_LFLAGS, $(3))) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_INCDIR        , , $($(strip $(3))DESTDIR)$($(strip $(3))includedir)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_LIBDIR        , , $($(strip $(3))DESTDIR)$($(strip $(3))libdir)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_INCDIR_X11    , , $($(strip $(3))DESTDIR)$($(strip $(3))includedir)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_LIBDIR_X11    , , $($(strip $(3))DESTDIR)$($(strip $(3))libdir)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_INCDIR_OPENGL , , $($(strip $(3))DESTDIR)$($(strip $(3))includedir)) ; \
	$(call UPDATE_PLATFORM, $(2), QMAKE_LIBDIR_OPENGL , , $($(strip $(3))DESTDIR)$($(strip $(3))libdir))

pre-configure:
	$(call CREATE_PLATFORM, $(PLATFORM_GARBUILD_BASE_PATH), $(PLATFORM_GARBUILD_PATH), build_)
	$(call CREATE_PLATFORM, $(PLATFORM_GARHOST_BASE_PATH) , $(PLATFORM_GARHOST_PATH) ,       )
	@$(MAKECOOKIE)

configure-%/configure:
	@cd $* && $(CONFIGURE_ENV) echo "yes" | ./configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

post-install:
	@#rm -f $(DESTDIR)$(qtbindir)/qmake ; cp $(WORKSRC)/bin/qmake $(DESTDIR)$(qtbindir)
	@rm -f $(DESTDIR)$(qtlibdir)/*.la
	@rm -f $(PLATFORM_DEFAULT_PATH)
	@ln -sf $(PLATFORM_GARHOST_NAME) $(PLATFORM_DEFAULT_PATH)
	@#$(call UPDATE_PLATFORM, $(PLATFORM_DEFAULT_PATH), QMAKE_INCDIR_QT, , $(DESTDIR)$(qtincludedir))
	@#$(call UPDATE_PLATFORM, $(PLATFORM_DEFAULT_PATH), QMAKE_LIBDIR_QT, , $(DESTDIR)$(qtlibdir))
	@#$(call UPDATE_PLATFORM, $(PLATFORM_DEFAULT_PATH), QMAKE_MOC      , , $(build_DESTDIR)$(build_qtbindir)/moc)
	@#$(call UPDATE_PLATFORM, $(PLATFORM_DEFAULT_PATH), QMAKE_UIC      , , $(build_DESTDIR)$(build_qtbindir)/uic)
	@#$(call GLIBC_ADD_LIB_PATH, $(qtlibdir))
	@files=`ls -1 $(DESTDIR)$(qtlibdir)/pkgconfig/*.pc` ; \
	 for file in $${files} ; do \
		sed -e 's%-I$(DESTDIR)$(includedir)%-I$(includedir)%g'   -i $${file} ; \
		sed -e 's%-L$(DESTDIR)$(libdir)%-L$(libdir)%g'           -i $${file} ; \
		sed -e 's%-I$(DESTDIR)$(qtincludedir)%-I$(includedir)%g' -i $${file} ; \
		sed -e 's%-L$(DESTDIR)$(qtlibdir)%-L$(qtlibdir)%g'       -i $${file} ; \
	 done
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(build_DESTDIR)$(build_libdir)/qt
	@rm -rf $(DESTDIR)$(libdir)/qt
