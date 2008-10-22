GARNAME = kdelibs
GARVERSION = 3.5.10
CATEGORIES = kde
MASTER_SITES = ftp://ftp.kde.org/pub/kde/stable/$(GARVERSION)/src/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-inotify_h.patch $(DISTNAME).patch.gar
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-cross.patch.gar
endif
LICENSE = BSD_2_Clause/FDL1_2/GPL2/LGPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c xorg/xorg qt/qt3 lib/libart lib/libtiff lib/libxml2 lib/libxslt lib/openssl lib/pcre utils/bzip2
ifneq ($(DESTIMG),build)
BUILDDEPS = kde/kdelibs
endif

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile
ifeq ($(DESTIMG),build)
INSTALL_SCRIPTS   += cross
endif

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-debug \
	--enable-new-ldflags \
	--enable-final \
	--enable-libsuffic=none \
	--disable-rpath \
	--enable-sendfile \
	--enable-mitshm \
	--disable-dnssd \
	--disable-openpty \
	--enable-fast-malloc=no \
	--disable-cups \
	--disable-libfam \
	--disable-dnotify \
	--enable-inotify \
	--enable-pcre \
	--with-gnu-ld \
	--without-acl \
	--with-qt-dir=$(DESTDIR)$(qt3prefix) \
	--with-qt-includes=$(DESTDIR)$(qt3includedir) \
	--with-qt-libraries=$(DESTDIR)$(qt3libdir) \
	--without-arts \
	--with-rgbfile=$(datadir)/X11/rgb.txt \
	--without-utempter \
	--without-lua \
	--without-libidn \
	--with-libart \
	--without-sudo-kdesu-backend \
	--without-libthai \
	--with-tiff \
	--without-jasper \
	--without-openexr \
	--with-ssl-dir=$(DESTDIR)$(prefix) \
	--with-ssl \
	--without-gssapi \
	--without-aspell \
	--without-hspell \
	--with-alsa \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir)

CONFIGURE_ENV  = \
	ac_cv_path_path_su=$(bindir)/su \
	kde_cv_shortsetgroups=no \
	libltdl_cv_sys_search_path="$(subst :, ,$(LD_LIBRARY_PATH))" \
	lt_cv_dlopen_self=yes \
	lt_cv_dlopen_self_static=yes \
	PKG_CONFIG=$(build_DESTDIR)$(build_bindir)/pkg-config \
	KDEINIT_FREETYPE_CONFIG=$(DESTDIR)$(bindir)/freetype-config \
	LIBART_CONFIG=$(DESTDIR)$(bindir)/libart2-config \
	MOC=$(build_DESTDIR)$(build_qt3bindir)/moc \
	PCRE_CONFIG=$(DESTDIR)$(bindir)/pcre-config \
	UIC_PATH=$(build_DESTDIR)$(build_qt3bindir)/uic \
	XML_CONFIG=$(DESTDIR)$(bindir)/xml2-config \
	XSLT_CONFIG=$(DESTDIR)$(bindir)/xslt-config \
	LD_RUN_PATH="$(LD_LIBRARY_PATH)"
BUILD_ENV      = \
	$(CONFIGURE_ENV)

include ../../gar.mk

DIRPATHS := \
	--prefix=$(kdeprefix) \
	--bindir=$(kdebindir) \
	--datarootdir=$(kdedatadir) \
	--datadir=$(kdedatadir) \
	--libdir=$(kdelibdir) \
	--includedir=$(kdeincludedir)

pre-configure:
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC)/configure)
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC)/acinclude.m4)
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC)/admin/libtool.m4.in)
	@$(MAKECOOKIE)

install-cross:
	@if test -e $(WORKSRC)/kstyles/keramik/.libs/genembed ; then \
		cp -f $(WORKSRC)/kstyles/keramik/.libs/genembed $(DESTDIR)$(kdebindir)/kdelibs-genembed ; \
		chmod 755 $(DESTDIR)$(kdebindir)/kdelibs-genembed ; \
	 fi
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/dcopserver.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kabc_dir.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kabc_file.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kabcformat_binary.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kabc_ldapkio.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kabc_net.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kaddprinterwizard.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kbuildsycoca.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kbzip2filter.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kcm_kresources.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kcmshell.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kconf_update.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kcookiejar.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kded_kcookiejar.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kded_kdeprintd.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kded_kdetrayproxy.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kded_kpasswdserver.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kded_kssld.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kded_kwalletd.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kded.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kded_proxyscout.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kdeprint_ext.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kdeprint_lpdunix.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kdeprint_lpr.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kdeprint_rlpr.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kdeprint_tool_escputil.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kgzipfilter.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/khtmlimagepart.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_dds.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_eps.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_hdr.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_ico.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_pcx.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_psd.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_rgb.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_tga.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_tiff.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_xcf.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kimg_xview.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kio_file.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kio_ftp.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kio_ghelp.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kio_help.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kio_http_cache_cleaner.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kio_http.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kio_metainfo.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kio_uiserver.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kjavaappletviewer.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/klauncher.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/knotify.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kspell_ispell.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kstyle_highcontrast_config.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/kstyle_plastik_config.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/ktexteditor_docwordcompletion.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/ktexteditor_insertfile.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/ktexteditor_isearch.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/ktexteditor_kdatatool.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/libkatepart.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/libkcertpart.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/libkdeprint_management_module.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/libkhtmlpart.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/libkmultipart.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/libshellscript.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/plugins/designer/kdewidgets.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/plugins/styles/highcolor.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/plugins/styles/highcontrast.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/plugins/styles/keramik.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/plugins/styles/kthemestyle.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/plugins/styles/light.la
	@rm -f $(DESTDIR)$(kdelibdir)/kde3/plugins/styles/plastik.la
	@rm -f $(DESTDIR)$(kdelibdir)/libDCOP.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkabc_dir.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkabc_file.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkabc.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkabc_ldapkio.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkabc_net.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkatepartinterfaces.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdecore.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdefakes.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdefx.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_dcopserver.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_kaddprinterwizard.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_kbuildsycoca.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_kcmshell.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_kconf_update.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_kcookiejar.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_kded.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_kio_http_cache_cleaner.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_kio_uiserver.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeinit_klauncher.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeprint.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeprint_management.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdesasl.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdesu.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdeui.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkdnssd.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkhtml.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkimproxy.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkio.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkjava.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkjs.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkmdi2.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkmdi.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkmediaplayer.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkmid.la
	@rm -f $(DESTDIR)$(kdelibdir)/libknewstuff.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkntlm.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkparts.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkresources.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkscreensaver.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkscript.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkspell2.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkspell.la
	@rm -f $(DESTDIR)$(kdelibdir)/libktexteditor.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkunittest.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkutils.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkwalletbackend.la
	@rm -f $(DESTDIR)$(kdelibdir)/libkwalletclient.la
	@rm -f $(DESTDIR)$(kdelibdir)/libvcard.la
	@# KDE uses *.la files to point to the *.so files, so create basic *.la files.
	@$(foreach pathname, $(shell find $(DESTDIR)$(kdelibdir)/kde3 -name *.so), \
		echo "dlname='$(shell basename $(pathname))'" \
			>  $(patsubst %.so,%.la,$(pathname)) ; \
		echo "libdir='$(shell dirname `echo $(pathname) | sed -e 's%^$(DESTDIR)%%'`)'"  \
			>> $(patsubst %.so,%.la,$(pathname)) ;)
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(kdeprefix)
