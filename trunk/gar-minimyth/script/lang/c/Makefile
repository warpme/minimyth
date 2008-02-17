GARNAME = c
GARVERSION = none
CATEGORIES = lang

DESCRIPTION =
define BLURB
endef

DEPENDS    = lib/libgcc
BUILDDEPS  = lang/c
# Development tools often used when building c language programs.
BUILDDEPS += \
	utils/coreutils \
	utils/ed \
	utils/sed \
	utils/gawk \
	utils/grep \
	utils/m4 \
	utils/diffutils \
	utils/findutils \
	devel/bison \
	devel/flex \
	devel/gettext \
	utils/bash \
	devel/autoconf \
	devel/automake-1.9 \
	devel/automake \
	devel/libtool \
	devel/pkg-config \
	devel/patch \
	utils/which \
	utils/file \
	utils/tar \
	utils/bzip2 \
	utils/gzip \
	utils/unzip \
	doc/texinfo \
	perl/perl

include ../../gar.mk

$(DESTIMG)_NODEPEND += lang/c
export $(DESTIMG)_NODEPEND

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
