GARNAME = openssh
GARVERSION = 5.5p1
CATEGORIES = net
MASTER_SITES  = ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/
MASTER_SITES += ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/old/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-abstract_socket.patch $(DISTNAME).patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENCE

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/openssl lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--disable-strip \
	--disable-lastlog \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--without-rpath \
	--with-ssl-engine \
	--without-pam

include ../../gar.mk

# Suffers from bug 42453 <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=42453>.
CFLAGS  := $(filter-out -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -fuse-linker-plugin, $(LDFLAGS))

# openssh 5.5p1 fails to compile with GCC 4.5.0's link time optimization.
CFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

LD         := $(CC)
LDFLAGS    := $(CFLAGS) $(LDFLAGS)

sysconfdir := $(sysconfdir)/ssh

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@rm -f $(WORKSRC)/config.cache
	@echo "ac_cv_have_space_for_dirent_d_name=yes" >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)
