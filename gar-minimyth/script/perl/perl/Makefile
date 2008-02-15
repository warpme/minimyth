GARNAME = perl
GARVERSION = 5.8.8
CATEGORIES = perl
MASTER_SITES = http://www.cpan.org/src/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-destdir.patch $(DISTNAME)-cross.patch
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	-d \
	-e \
	-Dcastflags='0' \
	-Dprefix="$(prefix)" \
	-Dinstallprefix="$(DESTDIR)$(prefix)" \
	-Dman1dir='$(mandir)/man1' \
	-Dman3dir='$(mandir)/man3' \
	-Dpager='/bin/less -isR' \
	-Darchname="$(word 1,$(subst -, ,$(GARHOST)))-linux" \
	-Dusrinc="$(DESTDIR)$(includedir)" \
	-Dlibpth="$(DESTDIR)$(elibdir) $(DESTDIR)$(libdir)" \
	-Dcpp="$(CPP)" \
	-Dcc="$(CC)" \
	-Dld="$(CC)" \
	-Dar="$(AR)" \
	-Dnm="$(NM)" \
	-Dranlib="$(RANLIB)" \
	-Dccflags="$(CFLAGS)" \
	-Dldflags="$(LDFLAGS)" \
	-Dusethreads \
	-Dgccversion="$(GCC_VERSION)" \
	-Dgnulibc_version="$(GLIBC_VERSION)" \
	-Dlibc="$(DESTDIR)$(elibdir)/libc-$(GLIBC_VERSION).so" \
	-Dso="so" \
	$(CONFIGURE_ARGS_$(GARCH_FAMILY))

CONFIGURE_ARGS_$(GARCH_FAMILY) = \
	-Dalignbytes='4' \
	-Dbyteorder='1234' \
	-Dcharsize='1' \
	-Ddoublesize='8' \
	-Dfpossize='16' \
	-Dfpostype='fpos_t' \
	-Dintsize='4' \
	-Dlongdblsize='12' \
	-Dlonglongsize='8' \
	-Dlongsize='4' \
	-Dlseeksize='8' \
	-Dlseektype='off_t' \
	-Dnv_preserves_uv_bits='32' \
	-Dshortsize='2' \
	-DsPRIEUldbl='"LE"' \
	-DsPRIFUldbl='"LF"' \
	-DsPRIGUldbl='"LG"' \
	-DsPRIXU64='"LX"' \
	-DsPRId64='"Ld"' \
	-DsPRIeldbl='"Le"' \
	-DsPRIfldbl='"Lf"' \
	-DsPRIgldbl='"Lg"' \
	-DsPRIi64='"Li"' \
	-DsPRIo64='"Lo"' \
	-DsPRIu64='"Lu"' \
	-DsPRIx64='"Lx"' \
	-DsSCNfldbl='"Lf"'

GAR_EXTRA_CONF += devel/gcc/package-api.mk
GAR_EXTRA_CONF += devel/glibc/package-api.mk
include ../../gar.mk

pre-configure:
	@ln -sf Configure $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-configure:
	@cd $(WORKSRC) ; sed -e 's%^[^:]*: *<command-line>$$%%' -i makefile
	@$(MAKECOOKIE)
