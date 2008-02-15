GARNAME = perl
GARVERSION = 5.8.8
CATEGORIES = perl
MASTER_SITES = http://www.cpan.org/src/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-destdir.patch
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix=/usr \
	-Dman1dir=/usr/share/man/man1 \
	-Dman3dir=/usr/share/man/man3 \
	-Dpager="/bin/less -isR" \
	-Dusethreads

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; ln -s configure.gnu configure
	@cd $(WORKSRC) ; sed -e "s%pldlflags=''%pldlflags=\"\$$cccdlflags\"%g" \
	                     -e "s%static_target='static'%static_target='static_pic'%g" \
	                     -i Makefile.SH
	@$(MAKECOOKIE)

post-configure:
	@cd $(WORKSRC) ; sed -e 's%^[^:]*: *<command-line>$$%%' -i makefile
	@$(MAKECOOKIE)
