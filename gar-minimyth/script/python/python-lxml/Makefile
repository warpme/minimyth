GARNAME = python-lxml
GARVERSION = 3.0.2
CATEGORIES = python
MASTER_SITES = http://lxml.de/files/
DISTFILES = $(patsubst python-%,%,$(GARNAME))-$(GARVERSION).tgz
LICENSE = BSD_3_Clause

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c python/python
BUILDDEPS = python/python-distutilscross

WORKSRC = $(WORKDIR)/$(patsubst python-%,%,$(GARNAME))-$(GARVERSION)

BUILD_SCRIPTS   = $(WORKSRC)/setup.py
INSTALL_SCRIPTS = $(WORKSRC)/setup.py

CONFIGURE_ARGS =
BUILD_ARGS     =
INSTALL_ARGS   = \
	--prefix=$(DESTDIR)$(prefix)
CONFIGURE_ENV  =
BUILD_ENV      =
INSTALL_ENV    = \
	PYTHONPATH=$(DESTDIR)$(PYTHON_libdir)/site-packages

ifneq ($(DESTIMG),build)
BUILD_ARGS += --cross-compile
BUILD_ENV  += PYTHONXCPREFIX=$(DESTDIR)$(prefix)
endif

GAR_EXTRA_CONF += python/python/package-api.mk
include ../../gar.mk

CFLAGS  := $(CFLAGS)  -fPIC
LDFLAGS := $(LDFLAGS) -fPIC

build-%/setup.py:
	@echo " ==> Running setup.py build in $*"
	@cd $* && $(CONFIGURE_ENV) $(BUILD_ENV) python setup.py $(CONFIGURE_ARGS) build $(BUILD_ARGS)
	@$(MAKECOOKIE)

install-%/setup.py: 
	@echo " ==> Running setup.py install in $*"
	@cd $* && $(CONFIGURE_ENV) $(INSTALL_ENV) python setup.py $(CONFIGURE_ARGS) install --skip-build $(INSTALL_ARGS)
	@$(MAKECOOKIE)
