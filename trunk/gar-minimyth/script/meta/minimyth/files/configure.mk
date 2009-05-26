GARNAME    ?= minimyth
GARVERSION ?= $(mm_VERSION)

all: mm-all

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk perl/perl/package-api.mk
include ../../gar.mk

MM_INIT_START := \
    security \
    cpu \
    console \
    telnet \
    ssh_server \
    mythdb_buffer_create \
    cron \
    game \
    master \
    codecs \
    flash \
    extras \
    sensors \
    acpi \
    time \
    web \
    media \
    audio \
    video \
    wiimote \
    irtrans \
    lirc \
    g15daemon \
    lcdproc \
    aquosserver \
    mythtv \
    font \
    backend \
    gtk \
    mythdb_buffer_delete \
    x
MM_INIT_KILL := \
    x \
    sharpaquos \
    lcdproc \
    g15daemon \
    lirc \
    irtrans \
    wiimote \
    audio \
    media \
    web \
    time \
    acpi \
    game \
    cron \
    ssh_server \
    telnet \
    cpu \
    log \
    modules_manual \
    modules_automatic

build_vars := $(filter-out mm_HOME mm_TFTP_ROOT mm_NFS_ROOT,$(sort $(shell cat $(mm_HOME)/script/minimyth.conf.mk | grep -e '^mm_' | sed -e 's%[ =].*%%')))

bindirs_base := \
	$(extras_sbindir) \
	$(extras_bindir) \
	$(esbindir) \
	$(ebindir) \
	$(sbindir) \
	$(bindir) \
	$(libexecdir) \
	$(qt3bindir) \
	$(qt4bindir) \
	$(kdebindir)
bindirs := \
	$(bindirs_base) \
	$(libexecdir)
libdirs_base := \
	$(extras_libdir) \
	$(elibdir) \
	$(libdir) \
	$(libdir)/gnash \
	$(libdir)/mysql \
	$(qt3libdir) \
	$(qt4libdir) \
	$(kdelibdir)
libdirs := \
	$(libdirs_base) \
	$(libdir)/xorg/modules \
	$(if $(filter $(mm_GRAPHICS),nvidia),$(libdir)/nvidia)
etcdirs := \
	$(extras_sysconfdir) \
	$(sysconfdir)
sharedirs := \
	$(extras_datadir) \
	$(datadir) \
	$(kdedatadir)

MM_CONFIG_VARS = \
	bindir \
	bindirs \
	bindirs_base \
	build_bindir \
	build_DESTDIR \
	build_licensedir \
	build_rootdir \
	build_system_bins \
	build_vars \
	build_versiondir \
	datadir \
	DESTDIR \
	DESTIMG \
	ebindir \
	elibdir \
	esbindir \
	etcdirs \
	extras_licensedir \
	extras_rootdir \
	extras_versiondir \
	libdir \
	libdirs \
	libdirs_base \
	licensedir \
	LINUX_DIR \
	LINUX_FULL_VERSION \
	LINUX_MODULESDIR \
	mm_CONF_VERSION \
	mm_DEBUG \
	mm_DEBUG_BUILD \
	mm_DESTDIR \
	mm_DISTRIBUTION_LOCAL \
	mm_DISTRIBUTION_NFS \
	mm_DISTRIBUTION_RAM \
	mm_DISTRIBUTION_SHARE \
	mm_GRAPHICS \
	mm_HOME \
	MM_INIT_KILL \
	MM_INIT_START \
	mm_INSTALL_LATEST \
	mm_INSTALL_NFS_BOOT \
	mm_INSTALL_RAM_BOOT \
	mm_MYTH_VERSION \
	mm_NFS_ROOT \
	mm_SOFTWARE \
	mm_TFTP_ROOT \
	mm_USER_BIN_LIST \
	mm_USER_ETC_LIST \
	mm_USER_LIB_LIST \
	mm_USER_REMOVE_LIST \
	mm_USER_SHARE_LIST \
	mm_VERSION_MINIMYTH \
	mm_VERSION_MYTH \
	mm_VERSION \
	OBJDUMP \
	PERL_libdir \
	qt3prefix \
	qt4prefix \
	rootdir \
	sharedirs \
	sourcedir \
	STRIP \
	sysconfdir \
	versiondir

mm-all: $(WORKSRC)/build/config.mk

$(WORKSRC)/build/config.mk:
	@mkdir -p $(dir $@)
	@rm -rf $@~
	@$(foreach var,$(MM_CONFIG_VARS), echo $(var) = $($(var)) >> $@~ ; )
	@if [ -e $@ ] ; then \
		diff -q $@ $@~ 2>&1 > /dev/null ; \
		if [ $$? -ne 0 ] ; then \
			rm -rf $@ ; \
		fi ; \
	fi
	@if [ ! -e $@ ] ; then \
		cp -f $@~ $@ ; \
	fi
	@rm -f $@~

.PHONY: all mm-all
