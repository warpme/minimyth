PWD := `pwd`

WORKSRC = $(WORKDIR)/minimyth-$(mm_VERSION)

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk devel/build-system-bins/package-api.mk perl/perl/package-api.mk
include ../../gar.mk

mm_NAME       := minimyth-$(mm_VERSION)
mm_SOURCENAME := gar-minimyth-$(mm_VERSION)
mm_KERNELNAME := kernel
mm_ROOTFSNAME := rootfs
mm_EXTRASNAME := extras
mm_EXTRASNAME := themes

# Directory where files are initaially assembled.
mm_STAGEDIR := $(WORKSRC)/stage
# Directory containing files that are for local (private) use (directories with extras).
mm_LOCALDIR := $(WORKSRC)/local
# Directory containing files that are for shared (public) use (tarballs without extras).
mm_SHAREDIR := $(WORKSRC)/share

mm_ROOTFSDIR := $(mm_STAGEDIR)/rootfs
mm_EXTRASDIR := $(mm_STAGEDIR)/extras
mm_THEMESDIR := $(mm_STAGEDIR)/themes

MM_BIN_FILES    := $(strip \
	$(if $(wildcard         lists/minimyth-bin-list   ),         lists/minimyth-bin-list   ) \
	$(if $(wildcard    ../../extras/extras-bin-list   ),    ../../extras/extras-bin-list   ) \
	$(filter $(patsubst %,lists/chipsets/minimyth-bin-list.%,$(mm_CHIPSETS)),$(wildcard lists/chipsets/minimyth-bin-list.*)) \
	$(filter $(patsubst %,lists/software/minimyth-bin-list.%,$(mm_SOFTWARE)),$(wildcard lists/software/minimyth-bin-list.*)))
MM_LIB_FILES    := $(strip \
	$(if $(wildcard         lists/minimyth-lib-list   ),         lists/minimyth-lib-list   ) \
	$(if $(wildcard    ../../extras/extras-lib-list   ),    ../../extras/extras-lib-list   ) \
	$(filter $(patsubst %,lists/chipsets/minimyth-lib-list.%,$(mm_CHIPSETS)),$(wildcard lists/chipsets/minimyth-lib-list.*)) \
	$(filter $(patsubst %,lists/software/minimyth-lib-list.%,$(mm_SOFTWARE)),$(wildcard lists/software/minimyth-lib-list.*)))
MM_ETC_FILES    := $(strip \
	$(if $(wildcard         lists/minimyth-etc-list   ),         lists/minimyth-etc-list   ) \
	$(if $(wildcard    ../../extras/extras-etc-list   ),    ../../extras/extras-etc-list   ) \
	$(filter $(patsubst %,lists/chipsets/minimyth-etc-list.%,$(mm_CHIPSETS)),$(wildcard lists/chipsets/minimyth-etc-list.*)) \
	$(filter $(patsubst %,lists/software/minimyth-etc-list.%,$(mm_SOFTWARE)),$(wildcard lists/software/minimyth-etc-list.*)))
MM_SHARE_FILES  := $(strip \
	$(if $(wildcard         lists/minimyth-share-list ),         lists/minimyth-share-list ) \
	$(if $(wildcard    ../../extras/extras-share-list ),    ../../extras/extras-share-list ) \
	$(filter $(patsubst %,lists/chipsets/minimyth-share-list.%,$(mm_CHIPSETS)),$(wildcard lists/chipsets/minimyth-share-list.*)) \
	$(filter $(patsubst %,lists/software/minimyth-share-list.%,$(mm_SOFTWARE)),$(wildcard lists/software/minimyth-share-list.*)))
MM_REMOVE_FILES := $(strip \
	$(if $(wildcard         lists/minimyth-remove-list),         lists/minimyth-remove-list) \
	$(filter $(patsubst %,lists/chipsets/minimyth-remove-list.%,$(mm_CHIPSETS)),$(wildcard lists/chipsets/minimyth-remove-list.*)) \
	$(filter $(patsubst %,lists/software/minimyth-remove-list.%,$(mm_SOFTWARE)),$(wildcard lists/software/minimyth-remove-list.*)))

MM_BIN_DEBUG    := $(strip $(if $(filter yes,$(mm_DEBUG)), \
	gdb \
	strace \
	xdpyinfo \
	))
MM_LIB_DEBUG    := $(strip $(if $(filter yes,$(mm_DEBUG)), \
	))
MM_ETC_DEBUG    := $(strip $(if $(filter yes,$(mm_DEBUG)), \
	))
MM_SHARE_DEBUG  := $(strip $(if $(filter yes,$(mm_DEBUG)), \
	))
MM_REMOVE_DEBUG := $(strip $(if $(filter yes,$(mm_DEBUG)), \
	))

MM_BINS    := $(sort $(if $(MM_BIN_FILES),    $(shell cat $(MM_BIN_FILES)    | sed 's%[ \t]*\#.*%%')) $(MM_BIN_DEBUG)    $(mm_USER_BIN_LIST))
MM_LIBS    := $(sort $(if $(MM_LIB_FILES),    $(shell cat $(MM_LIB_FILES)    | sed 's%[ \t]*\#.*%%')) $(MM_LIB_DEBUG)    $(mm_USER_LIB_LIST))
MM_ETCS    := $(sort $(if $(MM_ETC_FILES),    $(shell cat $(MM_ETC_FILES)    | sed 's%[ \t]*\#.*%%')) $(MM_ETC_DEBUG)    $(mm_USER_ETC_LIST))
MM_SHARES  := $(sort $(if $(MM_SHARE_FILES),  $(shell cat $(MM_SHARE_FILES)  | sed 's%[ \t]*\#.*%%')) $(MM_SHARE_DEBUG)  $(mm_USER_SHARE_LIST))
MM_REMOVES := $(sort $(if $(MM_REMOVE_FILES), $(shell cat $(MM_REMOVE_FILES) | sed 's%[ \t]*\#.*%%')) $(MM_REMOVE_DEBUG) $(mm_USER_REMOVE_LIST))

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
    lcdproc \
    mythtv \
    font \
    mythbackend \
    mythdb_buffer_delete \
    x
MM_INIT_KILL := \
    x \
    lcdproc \
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

build_vars := $(filter-out mm_HOME mm_TFTP_ROOT mm_NFS_ROOT,$(sort $(shell cat $(GARDIR)/minimyth.conf.mk | grep -e '^mm_' | sed -e 's%[ =].*%%')))

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
	$(libdir)/mysql \
	$(qt3libdir) \
	$(qt4libdir) \
	$(kdelibdir)
libdirs := \
	$(libdirs_base) \
	$(libdir)/xorg/modules \
	$(if $(filter $(mm_CHIPSETS),nvidia),$(libdir)/nvidia)
etcdirs := \
	$(extras_sysconfdir) \
	$(sysconfdir)
sharedirs := \
	$(extras_datadir) \
	$(datadir) \
	$(kdedatadir)

MAKE_PATH = \
	$(patsubst @%@,%,$(subst @ @,:, $(strip $(patsubst %,@%@,$(1)))))

GET_UID = \
	$(shell cat ./dirs/etc/passwd | grep -e '^$1' | cut -d':' -f 3)
GET_GID = \
	$(shell cat ./dirs/etc/group  | grep -e '^$1' | cut -d':' -f 3)


# $1 = file type label plural.
# $2 = file type label singular.
# $3 = file directories.
# $4 = files.
COPY_FILES = \
	echo "copying $(strip $(1))" ; \
	for dir in $(strip $(3)) ; do \
		mkdir -p $(mm_ROOTFSDIR)$${dir} ; \
	done ; \
	for file_item in $(strip $(4)) ; do \
		found="" ; \
		for dir in $(strip $(3)) ; do \
			file_list="" ; \
			if test -e $(DESTDIR)/$${dir} ; then \
				if echo $${file_item} | grep -q -e '/$$' > /dev/null 2>&1 ; then \
					file_list=`cd $(DESTDIR)/$${dir} ; find -L $${file_item} -maxdepth 0 -type d 2> /dev/null` ; \
				else \
					file_list=`cd $(DESTDIR)/$${dir} ; find -L $${file_item} -maxdepth 0 -type f 2> /dev/null` ; \
				fi; \
			fi ; \
			for file in $${file_list} ; do \
				if test -e $(DESTDIR)/$${dir}/$${file} ; then \
					found="true" ; \
					source_file="$(DESTDIR)/$${dir}/$${file}" ; \
					target_file="$(mm_ROOTFSDIR)/$${dir}/$${file}" ; \
					if test ! -e $${target_file} ; then \
						cp_flags=""                ; \
						cp_flags="$${cp_flags} -p" ; \
						file -L $${source_file} | grep -i -q 'ELF ..-bit LSB shared object' ; \
						if test $$? -ne 0 ; then \
							cp_flags="$${cp_flags} -d" ; \
						fi ; \
						if test -d $${source_file} ; then \
							cp_flags="$${cp_flags} -R" ; \
						fi ; \
                                       		target_dir=`dirname $${target_file}` ; \
                                       		mkdir -p $${target_dir} ; \
						cp $${cp_flags} $${source_file} $${target_file} ; \
						while file $${target_file} | grep -i -q 'symbolic link to' ; do \
							link="`file $${source_file} | \
								sed -e 's%^.* %%' -e 's%^.%%' -e 's%.$$%%'`" ; \
							source_file="`dirname $${source_file}`/$${link}" ; \
							target_file="`dirname $${target_file}`/$${link}" ; \
							if test ! -e $${source_file} ; then \
								echo "error: $${source_file} not found." ; \
								exit 1 ; \
							fi ; \
							if test ! -e $${target_file} ; then \
                                       				target_dir=`dirname $${target_file}` ; \
                                       				mkdir -p $${target_dir} ; \
								cp $${cp_flags} $${source_file} $${target_file} ; \
							fi ; \
						done ; \
					fi ; \
				fi ; \
			done ; \
		done ; \
		if test -z $${found} ; then \
			echo "warning: $(strip $(2)) \"$${file_item}\" not found." ; \
		fi ; \
	done

mm-all:

mm-build: mm-check mm-clean mm-make-busybox mm-copy mm-make-conf mm-remove-pre mm-copy-libs mm-copy-kernel-modules mm-remove-post mm-strip mm-gen-files mm-make-udev mm-make-other mm-make-extras mm-make-themes mm-make-rootfs mm-remove-svn mm-make-distro

mm-check:
	@echo "checking ..."
	@# Check build environment.
	@echo "  build system binaries ..."
	@$(foreach pkg,$(build_system_bins), \
		$(foreach bin,$(sort $(build_system_bins_$(subst -,_,$(pkg)))), \
			echo "    '$(bin)' (from package '$(pkg)')" ; \
			which $(bin) > /dev/null 2>&1 ; \
			if [ ! "$$?" = "0" ] ; then \
				echo "error: your system does not contain the program '$(bin)' (from package '$(pkg)')." ; \
				exit 1 ; \
			fi ; \
		) \
	)
	@echo "  build user uid and gid"
	@if [ `id -u` -eq 0 ] || [ `id -g` -eq 0 ] ; then \
		echo "error: gar-minimyth cannot be run by the user 'root'." ; \
		exit 1 ; \
	fi
	@echo "  / and /usr directory access"
	@for dir in /          /lib                              /bin           /sbin \
	            /usr       /usr/lib       /usr/libexec       /usr/bin       /usr/sbin \
	            /usr/local /usr/local/lib /usr/local/libexec /usr/local/bin /usr/local/sbin\
	            /opt ; do \
		if [ -e "$${dir}" ] && [ -w "$${dir}" ] ; then \
			echo "error: gar-minimyth cannot be run by a user with write access to '$${dir}'." ; \
			exit 1 ; \
		fi ; \
	done
	@echo "  build system binaries ... done"
	@# Check for obsolete parameters and parameter values.
	@echo "  obsolete parameters and parameter values ..."
	@echo "    mm_INSTALL_TFTP_BOOT"
	@if [ -n "$(mm_INSTALL_TFTP_BOOT)" ] ; then \
		echo "error: mm_INSTALL_TFTP_BOOT should be replaced with mm_INSTALL_RAM_BOOT." ; \
		exit 1 ; \
	fi
	@echo "    mm_INSTALL_CRAMFS"
	@if [ -n "$(mm_INSTALL_CRAMFS)" ] ; then \
		echo "error: mm_INSTALL_CRAMFS should be replaced with mm_INSTALL_RAM_BOOT." ; \
		exit 1 ; \
	fi
	@echo "    mm_INSTALL_NFS"
	@if [ -n "$(mm_INSTALL_NFS)" ] ; then \
		echo "error: mm_INSTALL_NFS should be replaced with mm_INSTALL_NFS_BOOT." ; \
		exit 1 ; \
	fi
	@if [ -n "$(mm_MYTH_SVN_VERSION)" ] ; then \
		echo "error: mm_MYTH_SVN_VERSION should be replaced with mm_MYTH_TRUNK_VERSION." ; \
		exit 1 ; \
	fi
	@echo "    mm_XORG_VERSION='old'"
	@if [ "$(mm_XORG_VERSION)" = "old" ] ; then \
		echo "error: mm_XORG_VERSION=\"old\" should be replaced with mm_XORG_VERSION=\"6.8\"." ; \
		exit 1 ; \
	fi
	@echo "    mm_XORG_VERSION='new'"
	@if [ "$(mm_XORG_VERSION)" = "new" ] ; then \
		echo "error: mm_XORG_VERSION=\"new\" should be replaced with mm_XORG_VERSION=\"7.0\"." ; \
		exit 1 ; \
	fi
	@echo "  obsolete parameters and parameter values ... done"
	@# Check build parameters.
	@echo "  build parameters ..."
	@echo "    HOME"
	@if [ ! -e $(HOME)/.minimyth/minimyth.conf.mk ] ; then \
		echo "error: configuration file '$(HOME)/.minimyth/minimyth.conf.mk' is missing." ; \
		exit 1 ; \
	fi
	@echo "    mm_GARCH"
	@if [ ! "$(mm_GARCH)" = "athlon64"    ] && \
	    [ ! "$(mm_GARCH)" = "c3"          ] && \
	    [ ! "$(mm_GARCH)" = "c3-2"        ] && \
	    [ ! "$(mm_GARCH)" = "pentium-mmx" ] ; then \
		echo "error: mm_GARCH=\"$(mm_GARCH)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_HOME"
	@if [ ! "$(mm_HOME)" = "`cd $(GARDIR)/.. ; pwd`" ] ; then \
		echo "error: mm_HOME must be set to \"`cd $(GARDIR)/.. ; pwd`\" but has been set to \"$(mm_HOME)\"."; \
		exit 1 ; \
	fi
	@if [ "$(firstword $(strip $(subst /, ,$(mm_HOME))))" = "$(firstword $(strip $(subst /, ,$(qt3prefix))))" ] ; then \
		echo "error: MiniMyth cannot be built in a subdirectory of \"/$(firstword $(strip $(subst /, ,$(qt3prefix))))\"."; \
		exit 1 ; \
	fi
	@if [ "$(firstword $(strip $(subst /, ,$(mm_HOME))))" = "$(firstword $(strip $(subst /, ,$(qt4prefix))))" ] ; then \
		echo "error: MiniMyth cannot be built in a subdirectory of \"/$(firstword $(strip $(subst /, ,$(qt4prefix))))\"."; \
		exit 1 ; \
	fi
	@echo "    mm_DEBUG"
	@if [ ! "$(mm_DEBUG)" = "yes" ] && [ ! "$(mm_DEBUG)" = "no" ] ; then \
		echo "error: mm_DEBUG=\"$(mm_DEBUG)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_DEBUG_BUILD"
	@if [ ! "$(mm_DEBUG_BUILD)" = "yes" ] && [ ! "$(mm_DEBUG_BUILD)" = "no" ] ; then \
		echo "error: mm_DEBUG_BUILD=\"$(mm_DEBUG_BUILD)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_CHIPSETS"
	@for chipset in $(mm_CHIPSETS) ; do \
		if [ ! "$${chipset}" = "ati"    ] && \
		   [ ! "$${chipset}" = "intel"  ] && \
		   [ ! "$${chipset}" = "nvidia" ] && \
		   [ ! "$${chipset}" = "sis"    ] && \
		   [ ! "$${chipset}" = "via"    ] && \
		   [ ! "$${chipset}" = "vmware" ] && \
		   [ ! "$${chipset}" = "other"  ] ; then \
			echo "error: mm_CHIPSETS=\"$${chipset}\" is an invalid value." ; \
			exit 1 ; \
		fi ; \
	done
	@echo "    mm_SOFTWARE"
	@for software in $(mm_SOFTWARE) ; do \
		if [ ! "$${software}" = "mythaudio"      ] && \
		   [ ! "$${software}" = "mythbrowser"    ] && \
		   [ ! "$${software}" = "mythgallery"    ] && \
		   [ ! "$${software}" = "mythgame"       ] && \
		   [ ! "$${software}" = "mythmusic"      ] && \
		   [ ! "$${software}" = "mythnews"       ] && \
		   [ ! "$${software}" = "mythphone"      ] && \
		   [ ! "$${software}" = "mythstream"     ] && \
		   [ ! "$${software}" = "mythvideo"      ] && \
		   [ ! "$${software}" = "mythweather"    ] && \
		   [ ! "$${software}" = "mythzoneminder" ] && \
		   [ ! "$${software}" = "mplayer"        ] && \
		   [ ! "$${software}" = "mplayer-svn"    ] && \
		   [ ! "$${software}" = "vlc"            ] && \
		   [ ! "$${software}" = "xine"           ] && \
		   [ ! "$${software}" = "perl"           ] && \
		   [ ! "$${software}" = "transcode"      ] && \
		   [ ! "$${software}" = "mame"           ] && \
		   [ ! "$${software}" = "wiimote"        ] && \
		   [ ! "$${software}" = "backend"        ] && \
		   [ ! "$${software}" = "debug"          ] ; then \
			echo "error: mm_SOFTWARE=\"$${software}\" is an invalid value." ; \
			exit 1 ; \
		fi ; \
		if [ ! "$(mm_MYTH_VERSION)" = "0.21"         ] ; then \
			if [ "$${software}" = "mythbrowswer" ] ; then \
				echo "warning: mm_SOFTWARE=\"$${software}\" is an invalid value for mm_MYTH_VERSION=\"$(mm_MYTH_VERSION)\"." ; \
			fi ; \
		fi ; \
	done
	@echo "    mm_KERNEL_HEADERS_VERSION"
	@if [ ! "$(mm_KERNEL_HEADERS_VERSION)" = "2.6.23" ] && \
	    [ ! "$(mm_KERNEL_HEADERS_VERSION)" = "2.6.24" ] && \
	    [ ! "$(mm_KERNEL_HEADERS_VERSION)" = "2.6.25" ] ; then \
		echo "error: mm_KERNEL_HEADERS_VERSION=\"$(mm_KERNEL_HEADERS_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_KERNEL_VERSION"
	@if [ ! "$(mm_KERNEL_VERSION)" = "2.6.23" ] && \
	    [ ! "$(mm_KERNEL_VERSION)" = "2.6.24" ] && \
	    [ ! "$(mm_KERNEL_VERSION)" = "2.6.25" ] ; then \
		echo "error: mm_KERNEL_VERSION=\"$(mm_KERNEL_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_KERNEL_VERSION >= mm_KERNEL_HEADERS_VERSION"
	@if [ `echo ${mm_KERNEL_HEADERS_VERSION} | sed 's%2\.6\.\(.*\)%\1%'` -gt \
	      `echo ${mm_KERNEL_VERSION}         | sed 's%2\.6\.\(.*\)%\1%'`     ] ; then \
		echo "error: mm_KERNEL_HEADERS_VERSION is greater than mm_KERNEL_VERSION." ; \
		exit 1 ; \
	fi
	@echo "    mm_MYTH_VERSION"
	@if [ ! "$(mm_MYTH_VERSION)" = "0.21"         ] && \
	    [ ! "$(mm_MYTH_VERSION)" = "trunk"        ] ; then \
		echo "error: mm_MYTH_VERSION=\"$(mm_MYTH_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_NVIDIA_VERSION"
	@if [ ! "$(mm_NVIDIA_VERSION)" = "71.86.04"  ] && \
	    [ ! "$(mm_NVIDIA_VERSION)" = "96.43.05"  ] && \
	    [ ! "$(mm_NVIDIA_VERSION)" = "169.12"    ] && \
	    [ ! "$(mm_NVIDIA_VERSION)" = "173.14.09" ] ; then \
		echo "error: mm_NVIDIA_VERSION=\"$(mm_NVIDIA_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_XORG_VERSION"
	@if [ ! "$(mm_XORG_VERSION)" = "7.3" ] ; then \
		echo "error: mm_XORG_VERSION=\"$(mm_XORG_VERSION)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "  build parameters ... done"
	@# Check build system parameters.
	@echo "  build system parameters ..."
	@if [ ! "$(build_GARCH_FAMILY)" = "i386"   ] && \
            [ ! "$(build_GARCH_FAMILY)" = "x86_64" ] ; then \
		echo "error: build_GARCH_FAMILY=\"$(build_GARCH_FAMILY)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@# Check distribution parameters.
	@echo "  distribution parameters ..."
	@echo "    mm_DISTRIBUTION_RAM"
	@if [ ! "$(mm_DISTRIBUTION_RAM)" = "yes" ] && [ ! "$(mm_DISTRIBUTION_RAM)" = "no" ] ; then \
		echo "error: mm_DISTRIBUTION_RAM=\"$(mm_DISTRIBUTION_RAM)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_NFS"
	@if [ ! "$(mm_DISTRIBUTION_NFS)" = "yes" ] && [ ! "$(mm_DISTRIBUTION_NFS)" = "no" ] ; then \
		echo "error: mm_DISTRIBUTION_NFS=\"$(mm_DISTRIBUTION_NFS)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_LOCAL"
	@if [ ! "$(mm_DISTRIBUTION_LOCAL)" = "yes" ] && [ ! "$(mm_DISTRIBUTION_LOCAL)" = "no" ] ; then \
		echo "error: mm_DISTRIBUTION_LOCAL=\"$(mm_DISTRIBUTION_LOCAL)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_SHARE"
	@if [ ! "$(mm_DISTRIBUTION_SHARE)" = "yes" ] && [ ! "$(mm_DISTRIBUTION_SHARE)" = "no" ] ; then \
		echo "error: mm_DISTRIBUTION_SHARE=\"$(mm_DISTRIBUTION_SHARE)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@echo "    mm_INSTALL_RAM_BOOT"
	@# Check install parameters.
	@if [ ! "$(mm_INSTALL_RAM_BOOT)" = "yes" ] && [ ! "$(mm_INSTALL_RAM_BOOT)" = "no" ] ; then \
		echo "error: mm_INSTALL_RAM_BOOT=\"$(mm_INSTALL_RAM_BOOT)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_RAM_BOOT)" = "yes" ] && [ ! -d "$(mm_TFTP_ROOT)" ] ; then \
		echo "error: the directory specified by mm_TFTP_ROOT=\"$(mm_TFTP_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@echo "    mm_INSTALL_NFS_BOOT"
	@if [ ! "$(mm_INSTALL_NFS_BOOT)" = "yes" ] && [ ! "$(mm_INSTALL_NFS_BOOT)" = "no" ] ; then \
		echo "error: mm_INSTALL_NFS_BOOT=\"$(mm_INSTALL_NFS_BOOT)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_NFS_BOOT)" = "yes" ] && [ ! -d "$(mm_TFTP_ROOT)" ] ; then \
		echo "error: the directory specified by mm_TFTP_ROOT=\"$(mm_TFTP_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_NFS_BOOT)" = "yes" ] && [ ! -d "$(mm_NFS_ROOT)"  ] ; then \
		echo "error: the directory specified by mm_NFS_ROOT=\"$(mm_NFS_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@echo "    mm_INSTALL_LATEST"
	@if [ ! "$(mm_INSTALL_LATEST)"   = "yes" ] && [ ! "$(mm_INSTALL_LATEST)"   = "no" ] ; then \
		echo "error: mm_INSTALL_LATEST=\"$(mm_INSTALL_LATEST)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_LATEST)"   = "yes" ] && [ ! -d "$(mm_TFTP_ROOT)" ] ; then \
		echo "error: the directory specified by mm_TFTP_ROOT=\"$(mm_TFTP_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_RAM"
	@if [ "$(mm_INSTALL_RAM_BOOT)" = "yes" ] && [ "$(mm_DISTRIBUTION_RAM)" = "no" ] ; then \
		echo "error: mm_INSTALL_RAM_ROOT=\"yes\" but mm_DISTRIBUTION_RAM=\"no\"." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_NFS"
	@if [ "$(mm_INSTALL_NFS_BOOT)" = "yes" ] && [ "$(mm_DISTRIBUTION_NFS)" = "no" ] ; then \
		echo "error: mm_INSTALL_NFS_ROOT=\"yes\" but mm_DISTRIBUTION_NFS=\"no\"." ; \
		exit 1 ; \
	fi
	@echo "    mm_DISTRIBUTION_LOCAL"
	@if [ "$(mm_INSTALL_RAM_BOOT)" = "yes" ] && [ "$(mm_DISTRIBUTION_LOCAL)" = "no" ] ; then \
		echo "error: mm_INSTALL_RAM_ROOT=\"yes\" but mm_DISTRIBUTION_LOCAL=\"no\"." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_NFS_BOOT)" = "yes" ] && [ "$(mm_DISTRIBUTION_LOCAL)" = "no" ] ; then \
		echo "error: mm_INSTALL_NFS_ROOT=\"yes\" but mm_DISTRIBUTION_LOCAL=\"no\"." ; \
		exit 1 ; \
	fi
	@echo "  distribution parameters ... done"
	@echo "checking ... done"

mm-clean:
	@rm -rf $(mm_DESTDIR)

mm-make-busybox:
	@main_DESTDIR=$(PWD)/$(mm_ROOTFSDIR) $(MAKE) -C $(GARDIR)/utils/busybox DESTIMG=$(DESTIMG) install
	@rm -rf $(mm_ROOTFSDIR)/var

mm-copy:
	@# Copy versions.
	@mkdir -p $(mm_ROOTFSDIR)$(versiondir)-build
	@cp -pdR $(build_DESTDIR)$(build_versiondir)/* $(mm_ROOTFSDIR)$(versiondir)-build
	@mkdir -p $(mm_ROOTFSDIR)$(versiondir)
	@cp -pdR $(DESTDIR)$(versiondir)/* $(mm_ROOTFSDIR)$(versiondir)
	@rm -rf $(mm_ROOTFSDIR)$(versiondir)/minimyth
	@mkdir -p $(mm_ROOTFSDIR)$(extras_versiondir)
	@cp -pdR $(DESTDIR)$(extras_versiondir)/* $(mm_ROOTFSDIR)$(extras_versiondir)
	@# Copy licenses.
	@mkdir -p $(mm_ROOTFSDIR)$(licensedir)-build
	@cp -pdR $(build_DESTDIR)$(build_licensedir)/* $(mm_ROOTFSDIR)$(licensedir)-build
	@mkdir -p $(mm_ROOTFSDIR)$(licensedir)
	@cp -pdR $(DESTDIR)$(licensedir)/* $(mm_ROOTFSDIR)$(licensedir)
	@rm -rf $(mm_ROOTFSDIR)$(licensedir)/minimyth
	@mkdir -p $(mm_ROOTFSDIR)$(extras_licensedir)
	@cp -pdR $(DESTDIR)$(extras_licensedir)/* $(mm_ROOTFSDIR)$(extras_licensedir)
	@# Copy the QT mysql plugin needed by MythTV.
	@$(if $(filter 0.21,$(mm_MYTH_VERSION)), \
		mkdir -p $(mm_ROOTFSDIR)$(qt3prefix)/plugins ; \
		cp -pdR $(DESTDIR)$(qt3prefix)/plugins/sqldrivers $(mm_ROOTFSDIR)$(qt3prefix)/plugins ; \
	)
	@$(if $(filter trunk,$(mm_MYTH_VERSION)), \
		mkdir -p $(mm_ROOTFSDIR)$(qt4prefix)/plugins ; \
		cp -pdR $(DESTDIR)$(qt4prefix)/plugins/sqldrivers $(mm_ROOTFSDIR)$(qt4prefix)/plugins ; \
	)
	@mkdir -p $(mm_ROOTFSDIR)$(bindir)
	@cp -pdR ./dirs/usr/bin/*                         $(mm_ROOTFSDIR)$(bindir)
	@mkdir -p $(mm_ROOTFSDIR)$(elibdir)
	@cp -pdR ./dirs//lib/*                            $(mm_ROOTFSDIR)$(elibdir)
	@# Copy binaries, etcs, shares, and libraries.
	@$(call COPY_FILES, "binaries" , "binary" , $(bindirs)  , $(MM_BINS)  )
	@$(call COPY_FILES, "etcs"     , "etc"    , $(etcdirs)  , $(MM_ETCS)  )
	@$(call COPY_FILES, "shares"   , "share"  , $(sharedirs), $(MM_SHARES))
	@$(call COPY_FILES, "libraries", "library", $(libdirs)  , $(MM_LIBS)  )

mm-make-conf:
	@mkdir -p $(mm_ROOTFSDIR)$(sysconfdir)
	@mkdir -p $(mm_ROOTFSDIR)$(sysconfdir)/fonts
	@echo -n                                         >  $(mm_ROOTFSDIR)$(sysconfdir)/fonts/local.conf
	@echo '<?xml version="1.0"?>'                    >> $(mm_ROOTFSDIR)$(sysconfdir)/fonts/local.conf
	@echo '<!DOCTYPE fontconfig SYSTEM "fonts.dtd">' >> $(mm_ROOTFSDIR)$(sysconfdir)/fonts/local.conf
	@echo '<fontconfig>'                             >> $(mm_ROOTFSDIR)$(sysconfdir)/fonts/local.conf
	@echo '<dir>$(libdir)/X11/fonts/misc</dir>'      >> $(mm_ROOTFSDIR)$(sysconfdir)/fonts/local.conf
	@echo '<dir>$(libdir)/X11/fonts/TTF</dir>'       >> $(mm_ROOTFSDIR)$(sysconfdir)/fonts/local.conf
	@echo '</fontconfig>'                            >> $(mm_ROOTFSDIR)$(sysconfdir)/fonts/local.conf
	@cp -pdR ./dirs/etc/* $(mm_ROOTFSDIR)$(sysconfdir)
	@sed -i 's%@MM_VERSION@%$(mm_VERSION)%'                   $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@sed -i 's%@MM_VERSION_MYTH@%$(mm_VERSION_MYTH)%'         $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@sed -i 's%@MM_VERSION_MINIMYTH@%$(mm_VERSION_MINIMYTH)%' $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@sed -i 's%@MM_CONF_VERSION@%$(mm_CONF_VERSION)%'         $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@sed -i 's%@PATH@%$(call MAKE_PATH,$(bindirs_base))%'     $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@rm -rf   $(mm_ROOTFSDIR)$(versiondir)/minimyth.conf.mk
	@mkdir -p $(mm_ROOTFSDIR)$(versiondir)
	@$(foreach build_var,$(build_vars),echo "$(build_var)='$(strip $($(build_var)))'" >> $(mm_ROOTFSDIR)$(versiondir)/minimyth.conf.mk ; )
	@sed -i 's%@EXTRAS_ROOTDIR@%$(extras_rootdir)%' $(mm_ROOTFSDIR)$(sysconfdir)/rc.d/init.d/extras
	@rm -f $(mm_ROOTFSDIR)$(sysconfdir)/ld.so.conf
	@$(foreach dir, $(libdirs_base), echo $(dir) >> $(mm_ROOTFSDIR)$(sysconfdir)/ld.so.conf ; )
	@mkdir -p $(mm_ROOTFSDIR)$(sharedstatedir)/mythtv
	@cp -pdR  ./dirs/usr/share/mythtv/*              $(mm_ROOTFSDIR)$(sharedstatedir)/mythtv/
	@rm -f $(mm_ROOTFSDIR)$(sysconfdir)/ld.so.cache{,~}
	@rm -rf $(mm_ROOTFSDIR)/root ; mkdir -p $(mm_ROOTFSDIR)/root
	@rm -rf $(mm_ROOTFSDIR)/srv  ; cp -r ./dirs/srv   $(mm_ROOTFSDIR)
	@rm -rf $(mm_ROOTFSDIR)/home ; cp -r ./dirs/home  $(mm_ROOTFSDIR)
	@cp -pdRf $(mm_HOME)/html/minimyth/*              $(mm_ROOTFSDIR)/srv/www/
	@find $(mm_ROOTFSDIR)/srv/www -name .htaccess -exec rm -rf '{}' +
	@rm -rf $(mm_ROOTFSDIR)/srv/www/download
	@cp -pdRf ./dirs/srv/www/*                        $(mm_ROOTFSDIR)/srv/www/
	@mkdir -p $(mm_ROOTFSDIR)/srv/www/software
	@mkdir -p $(mm_ROOTFSDIR)/srv/www/software/base
	@mkdir -p $(mm_ROOTFSDIR)/srv/www/software/extras
	@mkdir -p $(mm_ROOTFSDIR)/srv/www/software/build
	@ln -s $(versiondir)                              $(mm_ROOTFSDIR)/srv/www/software/base/versions
	@ln -s $(licensedir)                              $(mm_ROOTFSDIR)/srv/www/software/base/licenses
	@ln -s $(extras_versiondir)                       $(mm_ROOTFSDIR)/srv/www/software/extras/versions
	@ln -s $(extras_licensedir)                       $(mm_ROOTFSDIR)/srv/www/software/extras/licenses
	@ln -s $(versiondir)-build                        $(mm_ROOTFSDIR)/srv/www/software/build/versions
	@ln -s $(licensedir)-build                        $(mm_ROOTFSDIR)/srv/www/software/build/licenses
	@mkdir -p $(mm_ROOTFSDIR)/home/minimyth
	@ln -sf $(sysconfdir)/lircrc                      $(mm_ROOTFSDIR)/home/minimyth/.lircrc
	@mkdir -p $(mm_ROOTFSDIR)/home/minimyth/.mythtv
	@ln -sf $(sysconfdir)/lircrc                      $(mm_ROOTFSDIR)/home/minimyth/.mythtv/lircrc
	@mkdir -p $(mm_ROOTFSDIR)$(sysconfdir)/rc.d/rc.d
	index=10 ; $(foreach file, $(MM_INIT_START), index=$$(($${index}+2)) ; ln -sf ../init.d/$(file) $(mm_ROOTFSDIR)$(sysconfdir)/rc.d/rc.d/S$${index}$(file) ; )
	index=10 ; $(foreach file, $(MM_INIT_KILL), index=$$(($${index}+2)) ; ln -sf ../init.d/$(file) $(mm_ROOTFSDIR)$(sysconfdir)/rc.d/rc.d/K$${index}$(file) ; )

mm-remove-pre:
	@# Remove unwanted binaries, etc, shares and libraries.
	@echo 'removing unwanted files'
	@for file_item in $(addprefix $(mm_ROOTFSDIR),$(MM_REMOVES)) ; do \
		if echo $${file_item} | grep -q -e '/$$' > /dev/null 2>&1 ; then \
			file_list=`ls -d1 $${file_item} 2> /dev/null` ; \
			for file in $${file_list} ; do \
				if test -d $${file} ; then \
					rm -rf $${file} ; \
				fi ; \
			done ; \
		else \
			file_list=`ls -d1 $${file_item} 2> /dev/null` ; \
			for file in $${file_list} ; do \
				if test -f $${file} ; then \
					rm -rf $${file} ; \
				fi ; \
			done ; \
		fi ; \
	done
	@dirs='$(PERL_libdir)' ; \
	for dir in $${dirs} ; do \
		if test -e $(mm_ROOTFSDIR)$${dir} ; then \
			cd $(mm_ROOTFSDIR)$${dir} ; \
			rm -f `find . -type f -name '.*'`    ; \
			rm -f `find . -type f -name '*.bs'`  ; \
			rm -f `find . -type f -name '*.e2x'` ; \
			rm -f `find . -type f -name '*.eg'`  ; \
			rm -f `find . -type f -name '*.h'`   ; \
			rm -f `find . -type f -name '*.pod'` ; \
			while test `find . -type d -empty | wc -l` -gt 0 ; do \
				rm -rf `find . -type d -empty` ; \
			done ; \
		fi ; \
	done

mm-remove-post:
	@# Remove unwanted binaries, etc, shares and libraries.
	@echo 'removing unwanted files'
	@for file_item in $(addprefix $(mm_ROOTFSDIR),$(MM_REMOVES)) ; do \
		if echo $${file_item} | grep -q -e '/$$' > /dev/null 2>&1 ; then \
			file_list=`ls -d1 $${file_item} 2> /dev/null` ; \
			for file in $${file_list} ; do \
				if test -d $${file} ; then \
					rm -rf $${file} ; \
				fi ; \
			done ; \
		else \
			file_list=`ls -d1 $${file_item} 2> /dev/null` ; \
			for file in $${file_list} ; do \
				if test -f $${file} ; then \
					rm -rf $${file} ; \
				fi ; \
			done ; \
		fi ; \
	done

mm-copy-libs:
	@# Copy dependent libraries.
	@echo 'copying dependent libraries'
	new_filter_path="\(`echo $(strip $(libdirs)) | sed -e 's%//*%/%g' | sed -e 's% /% %g' | sed -e 's%^/%%' | sed -e 's%  *%\\\\|%g'`\)" ; \
	pass=0 ; \
	lib_count=1 ; \
	bin_list="`find $(mm_ROOTFSDIR) -exec file '{}' \; \
		| grep -i 'ELF ..-bit LSB executable' \
		| sed -e 's%:.*%%'`" ; \
	bin_list=`echo $${bin_list}` ; \
	while test $${lib_count} -gt 0 ; do \
		pass=$$(($${pass}+1)) ; \
		lib_list="`find $(mm_ROOTFSDIR) -exec file '{}' \; \
			| grep -i 'ELF ..-bit LSB shared object' \
			| sed -e 's%:.*%%'`" ; \
		lib_list=`echo $${lib_list}` ; \
		new_list="`$(OBJDUMP) -x $${bin_list} $${lib_list} 2> /dev/null \
			| grep -e '^ *NEEDED  *' \
			| sed -e 's%^ *%%' -e 's% *$$%%' -e 's%  *% %' \
			| cut -d' ' -f 2 \
			| sort \
			| uniq`" ; \
		new_list=`echo $${new_list}` ; \
		old_list="`echo $${lib_list} \
			| sed -e 's%[^ ]*/%%g' \
			| sort \
			| uniq`" ; \
		old_list=`echo $${old_list}` ; \
		old_filter="\(`echo $${old_list} | sed -e 's%\([.+]\)%\\1%g' | sed -e 's%  *%\\\\|%g'`\)" ; \
		new_list=`echo " $${new_list} " \
			| sed -e 's%  *%  %g' \
			| sed -e "s% $${old_filter} % %g"` ; \
		new_list=`echo $${new_list} | sed -e 's%  *% %g' | sed -e 's%^  *%%' | sed -e 's%  *$$%%'` ; \
		lib_count=`echo "$${new_list}" | wc -w` ; \
		echo "  pass $${pass} found $${lib_count} libraries to copy" ; \
		if test "$(mm_DEBUG_BUILD)" = "yes" ; then \
			echo "    bin_list : $${bin_list}" ; \
			echo "    lib_list : $${lib_list}" ; \
			echo "    old_list : $${old_list}" ; \
			echo "    new_list : $${new_list}" ; \
		fi ; \
		if test $${lib_count} -gt 0 ; then \
		        new_filter_file="\(`echo $${new_list} | sed -e 's%\([.+]\)%\\\\\\1%g' | sed -e 's%  *%\\\\|%g'`\)" ; \
		        new_filter="$${new_filter_path}/$${new_filter_file}" ; \
			new_list=`cd $(DESTDIR) ; find * -regex "$${new_filter}"` ; \
			for lib in $${new_list} ; do \
				dir=`echo $${lib} | sed -e 's%[^/]*$$%%'` ; \
				mkdir -p $(mm_ROOTFSDIR)/$${dir} ; \
				cp -p $(DESTDIR)/$${lib} $(mm_ROOTFSDIR)/$${dir} ; \
			done ; \
		fi ; \
		bin_list= ; \
		lib_list= ; \
	done

mm-copy-kernel-modules:
	@# Copy dependent kernel modules.
	@echo 'copying dependent kernel modules'
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@find $(mm_ROOTFSDIR)$(LINUX_MODULESDIR) -name '*.ko' | sed -e 's%^$(mm_ROOTFSDIR)%/%' -e 's%//*%/%g' | \
	while read module ; do \
		module_deps=`cat $(DESTDIR)$(LINUX_MODULESDIR)/modules.dep | grep -e "^$${module}:" | sed -e 's%[^:]*: *%%'` ; \
		for module_dep in $${module_deps} ; do \
			if [ ! -e $(mm_ROOTFSDIR)$${module_dep} ] ; then \
				mkdir -p `dirname $(mm_ROOTFSDIR)$${module_dep}` ; \
				cp -pd $(DESTDIR)$${module_dep} $(mm_ROOTFSDIR)$${module_dep} ; \
			fi ; \
		done ; \
	done

mm-strip:
	@if test ! $(mm_DEBUG) = yes ; then \
		chmod -R u+w $(mm_ROOTFSDIR) ; \
		echo 'stripping binaries' ; \
		$(STRIP) --strip-all -R .note -R .comment \
			`find $(mm_ROOTFSDIR) -exec file '{}' \; | grep -i 'ELF ..-bit LSB executable'    | sed -e 's%:.*%%'` ; \
		echo 'stripping shared libraries' ; \
		$(STRIP) --strip-all -R .note -R .comment \
			`find $(mm_ROOTFSDIR) -exec file '{}' \; | grep -i 'ELF ..-bit LSB shared object' | sed -e 's%:.*%%'` ; \
	fi
	@if test ! $(mm_DEBUG) = yes ; then \
		echo 'stripping perl' ; \
		dirs='$(PERL_libdir) $(datadir)/mythtv' ; \
		cd $(mm_ROOTFSDIR) ; \
		for dir in $${dirs} ; do \
			echo "  stripping [...]$${dir}" ; \
			perl $(build_DESTDIR)$(build_bindir)/PerlSharp.cgi -r ./$${dir} > /dev/null 2>&1 ; \
			rm -f PerlSharpLog.txt ; \
			revert_list=`find ./$${dir} -name *.ERR | sed -e 's%^\.//*%/%' -e 's%\.ERR$$%%'` ; \
			for revert in $${revert_list} ; do \
				echo "    not stripping perl file [...]$${revert}" ; \
				rm -f ./$${revert}.ERR ; \
				rm -f ./$${revert}.LOG ; \
				cp -f $(DESTDIR)$${revert} ./$${revert} ; \
			done ; \
		done ; \
	fi

mm-gen-files:
	@depmod -b "$(mm_ROOTFSDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@cd $(mm_ROOTFSDIR)$(libdir)/X11/fonts/misc ; mkfontscale . ; mkfontdir .
	@cd $(mm_ROOTFSDIR)$(libdir)/X11/fonts/TTF  ; mkfontscale . ; mkfontdir .
	@for font in `cd $(mm_ROOTFSDIR)$(libdir)/X11/fonts/TTF ; ls -1 *.{TTF,ttf} 2> /dev/null` ; do \
		ln -sf ./$(call DIRSTODOTS,$(datadir)/mythtv)/$(libdir)/X11/fonts/TTF/$${font} $(mm_ROOTFSDIR)$(datadir)/mythtv/$${font} ; \
	done

mm-make-udev:
	$(foreach file, $(shell cd ./dirs/udev/scripts.d ; ls -1 *      ), \
		install -m 755 -D  ./dirs/udev/scripts.d/$(file) $(mm_ROOTFSDIR)$(elibdir)/udev/$(file) ; )
	$(foreach file, $(shell cd ./dirs/udev/rules.d   ; ls -1 *.rules *.rules.disabled), \
		install -m 644 -D  ./dirs/udev/rules.d/$(file)   $(mm_ROOTFSDIR)$(sysconfdir)/udev/rules.d/$(file) ; )
	@mkdir -p $(mm_ROOTFSDIR)$(elibdir)/udev/devices

mm-make-other:
	@# Get version.
	@mkdir -p $(mm_STAGEDIR)
	@rm -rf $(mm_STAGEDIR)/version
	@echo "$(mm_VERSION)" > $(mm_STAGEDIR)/version
	@# Get changelog.
	@cp -pdR $(mm_HOME)/html/minimyth/document-changelog.txt $(mm_STAGEDIR)/changelog.txt
	@# Get html documentation.
	@rm -rf $(mm_STAGEDIR)/html
	@cp -pdR $(mm_HOME)/html $(mm_STAGEDIR)
	@# Get scripts
	@rm -rf   $(mm_STAGEDIR)/scripts
	@mkdir -p $(mm_STAGEDIR)/scripts
	@cp  -pd ./files/mm_local_install $(mm_STAGEDIR)/scripts/mm_local_install
	@cp  -pd ./files/mm_local_update  $(mm_STAGEDIR)/scripts/mm_local_update
	@cp  -pd ./files/mm_local_helper  $(mm_STAGEDIR)/scripts/mm_local_helper
	@# Get kernel.
	@rm -rf $(mm_STAGEDIR)/kernel
	@cp $(DESTDIR)/$(LINUX_DIR)/vmlinuz $(mm_STAGEDIR)/kernel
	@# Get local helper.
	@rm -rf   $(mm_STAGEDIR)/helper
	@mkdir -p $(mm_STAGEDIR)/helper
	@cp  -pd ./files/mm_local_helper $(mm_STAGEDIR)/helper/mm_local_helper
	@cd ${mm_STAGEDIR}/helper ; md5sum mm_local_helper > mm_local_helper.md5
	@# Get /usr/bin MiniMyth scripts.
	@cp  -pd ./files/mm_local_update $(mm_ROOTFSDIR)/usr/bin/mm_local_update
	@chmod 0755 $(mm_ROOTFSDIR)/usr/bin/mm_local_update
	@cp  -pd ./files/mm_local_helper $(mm_ROOTFSDIR)/usr/bin/mm_local_helper_old
	@mkdir -p $(mm_STAGEDIR)/pxe-$(mm_NAME)
	@cp  -pd ./files/pxe.readme.txt $(mm_STAGEDIR)/pxe-$(mm_NAME)/readme.txt
	@mkdir -p $(mm_STAGEDIR)/pxe-$(mm_NAME)/gpxe/tftpboot/minimyth
	@if test -e $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/gpxe.0 ; then \
		cp -pd $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/gpxe.0 \
		       $(mm_STAGEDIR)/pxe-$(mm_NAME)/gpxe/tftpboot/minimyth/gpxe.0 ; \
	fi
	@mkdir -p $(mm_STAGEDIR)/pxe-$(mm_NAME)/gpxe/tftpboot/minimyth/gpxe.cfg
	@cat ./files/pxe.gpxe.cfg | sed -e 's%@MM_NAME@%$(mm_NAME)%' > $(mm_STAGEDIR)/pxe-$(mm_NAME)/gpxe/tftpboot/minimyth/gpxe.cfg/default
	@cp  -pd ./files/pxe.gpxe.dhcpd.conf $(mm_STAGEDIR)/pxe-$(mm_NAME)/gpxe/dhcpd.conf
	@mkdir -p $(mm_STAGEDIR)/pxe-$(mm_NAME)/pxelinux/tftpboot/minimyth
	@cp -pd $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/pxelinux.0 $(mm_STAGEDIR)/pxe-$(mm_NAME)/pxelinux/tftpboot/minimyth/pxelinux.0
	@mkdir -p $(mm_STAGEDIR)/pxe-$(mm_NAME)/pxelinux/tftpboot/minimyth/pxelinux.cfg
	@cat ./files/pxe.pxelinux.cfg | sed -e 's%@MM_NAME@%$(mm_NAME)%' > $(mm_STAGEDIR)/pxe-$(mm_NAME)/pxelinux/tftpboot/minimyth/pxelinux.cfg/default
	@cp  -pd ./files/pxe.pxelinux.dhcpd.conf $(mm_STAGEDIR)/pxe-$(mm_NAME)/pxelinux/dhcpd.conf

mm-make-extras:
	@rm -rf $(mm_EXTRASDIR) ; mkdir -p $(mm_EXTRASDIR)
	@mv $(mm_ROOTFSDIR)/$(extras_rootdir)/* $(mm_EXTRASDIR)
	@rm -rf $(mm_ROOTFSDIR)/$(extras_rootdir) ; mkdir -p $(mm_ROOTFSDIR)/$(extras_rootdir)

mm-make-themes:
	@rm -rf   $(mm_THEMESDIR) 
	@mkdir -p $(mm_THEMESDIR)
	@mv       $(mm_ROOTFSDIR)/usr/share/mythtv/themes/* $(mm_THEMESDIR)
	@rm -rf   $(mm_ROOTFSDIR)/usr/share/mythtv/themes
	@mkdir -p $(mm_ROOTFSDIR)/usr/share/mythtv/themes
	@# Include all the menu themes in the root file system.
	@for theme in `cd $(mm_THEMESDIR) ; ls -1` ; do \
		if test -e $(mm_THEMESDIR)/$${theme}/mainmenu.xml ; then \
			mv $(mm_THEMESDIR)/$${theme} $(mm_ROOTFSDIR)/usr/share/mythtv/themes/ ; \
		fi ; \
	done
	@# Include the default themes in the root file system because other themes depend on them.
	@if test -e $(mm_THEMESDIR)/default ; then \
		mv $(mm_THEMESDIR)/default $(mm_ROOTFSDIR)/usr/share/mythtv/themes/ ; \
	fi
	@if test -e $(mm_THEMESDIR)/default-wide ; then \
		mv $(mm_THEMESDIR)/default-wide $(mm_ROOTFSDIR)/usr/share/mythtv/themes/ ; \
	fi

mm-make-rootfs:
	@if test -e $(mm_ROOTFSDIR).ro ; then rm -rf $(mm_ROOTFSDIR).ro ; fi
	@mv $(mm_ROOTFSDIR) $(mm_ROOTFSDIR).ro
	@mkdir -p                           $(mm_ROOTFSDIR)
	@mkdir -p                           $(mm_ROOTFSDIR)/rootfs
	@mv $(mm_ROOTFSDIR).ro              $(mm_ROOTFSDIR)/rootfs-ro
	@mkdir -p                           $(mm_ROOTFSDIR)/rw
	@mkdir -p                           $(mm_ROOTFSDIR)/bin
	@ln -s rootfs-ro/dev                $(mm_ROOTFSDIR)/dev
	@ln -s rootfs-ro/lib                $(mm_ROOTFSDIR)/lib
	@mkdir -p                           $(mm_ROOTFSDIR)/sbin
	@ln -s ../rootfs-ro/bin/mkdir       $(mm_ROOTFSDIR)/bin/mkdir
	@ln -s ../rootfs-ro/sbin/modprobe   $(mm_ROOTFSDIR)/sbin/modprobe
	@ln -s ../rootfs-ro/bin/mount       $(mm_ROOTFSDIR)/bin/mount
	@ln -s ../rootfs-ro/sbin/pivot_root $(mm_ROOTFSDIR)/sbin/pivot_root
	@ln -s ../rootfs-ro/bin/sh          $(mm_ROOTFSDIR)/bin/sh
	@cp -pdR ./dirs/initrd/sbin/init    $(mm_ROOTFSDIR)/sbin/init

mm-remove-svn:
	@find $(mm_STAGEDIR) -name .svn -exec rm -rf '{}' +

mm-make-distro-base:
	@echo 'making minimyth distribution'
	@# Make source tarball file.
	@echo "  making source tarball file"
	@$(MAKE) -f minimyth.mk mm-make-source DESTIMG=$(DESTIMG)          \
		SOURCE_DIR_HEAD=`echo $(mm_HOME) | sed 's%/[^/]*$$%/%'` \
		SOURCE_DIR_TAIL=`echo $(mm_HOME) | sed 's%^.*/%%'`
	@chmod 0644 $(mm_STAGEDIR)/$(mm_SOURCENAME).tar.bz2
	@# Make documentation tarball file.
	@echo "  making documentation tarball file"
	@rm -rf $(mm_STAGEDIR)/html.tar.bz2
	@fakeroot sh -c                                                     " \
		chmod -R go-w $(mm_STAGEDIR)/html                           ; \
		tar -C $(mm_STAGEDIR) -jcf $(mm_STAGEDIR)/html.tar.bz2 html "
	@chmod 0644 $(mm_STAGEDIR)/html.tar.bz2
	@# Make helper tarball file.
	@echo "  making helper tarball file"
	@rm -rf $(mm_STAGEDIR)/helper.tar.bz2
	@fakeroot sh -c                                                         " \
		chmod -R go-w $(mm_STAGEDIR)/helper                             ; \
		tar -C $(mm_STAGEDIR) -jcf $(mm_STAGEDIR)/helper.tar.bz2 helper "
	@chmod 0644 $(mm_STAGEDIR)/helper.tar.bz2
	@# Make PXE tarball file.
	@echo "  making helper tarball file"
	@rm -rf $(mm_STAGEDIR)/pxe-$(mm_NAME).tar.bz2
	@fakeroot sh -c                                                                         " \
		chmod -R go-w $(mm_STAGEDIR)/pxe-$(mm_NAME)                                     ; \
		tar -C $(mm_STAGEDIR) -jcf $(mm_STAGEDIR)/pxe-$(mm_NAME).tar.bz2 pxe-$(mm_NAME) "
	@chmod 0644 $(mm_STAGEDIR)/pxe-$(mm_NAME).tar.bz2

mm-make-distro-ram:
	@# Make RAM root file system distribution
	@echo "  making RAM root file system distribution"
	@rm -rf   $(mm_STAGEDIR)/ram-$(mm_NAME)
	@mkdir -p $(mm_STAGEDIR)/ram-$(mm_NAME)
	@# Get version.
	@cp -pdR $(mm_STAGEDIR)/version $(mm_STAGEDIR)/ram-$(mm_NAME)/
	@# Get documentation 
	@cp -pdR $(mm_STAGEDIR)/html    $(mm_STAGEDIR)/ram-$(mm_NAME)/
	@# Get scripts
	@cp -pdR $(mm_STAGEDIR)/scripts $(mm_STAGEDIR)/ram-$(mm_NAME)/
	@# Get kernel.
	@cp -pdR $(mm_STAGEDIR)/kernel  $(mm_STAGEDIR)/ram-$(mm_NAME)/
	@# Make root file system squashfs image file.
	@echo "    making root file system squashfs image file"
	@rm -rf $(mm_STAGEDIR)/ram-$(mm_NAME)/rootfs
	@fakeroot sh -c                                                                          " \
		chmod -R -s   $(mm_ROOTFSDIR)                                                    ; \
		chmod -R -t   $(mm_ROOTFSDIR)                                                    ; \
		chmod -R go-w $(mm_ROOTFSDIR)                                                    ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(ebindir)/busybox                       ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(ebindir)/ping                          ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(bindir)/pmount                         ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(esbindir)/poweroff                     ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(bindir)/pumount                        ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(bindir)/X                              ; \
		rm -rf $(mm_ROOTFSDIR)/rootfs-ro/$(rootdir)/dev                                  ; \
		mkdir -p $(mm_ROOTFSDIR)/rootfs-ro/$(rootdir)/dev                                ; \
		mknod -m 0600 $(mm_ROOTFSDIR)/rootfs-ro/$(rootdir)/dev/console c 5 1             ; \
		mknod -m 0600 $(mm_ROOTFSDIR)/rootfs-ro/$(rootdir)/dev/initctl p                 ; \
		mksquashfs $(mm_ROOTFSDIR) $(mm_STAGEDIR)/ram-$(mm_NAME)/rootfs > /dev/null 2>&1 "
	@chmod 0644 $(mm_STAGEDIR)/ram-$(mm_NAME)/rootfs
	@# Make extras squashfs image file.
	@echo "    making extras squashfs image file"
	@rm -rf $(mm_STAGEDIR)/ram-$(mm_NAME)/extras.sfs
	@fakeroot sh -c                                                                              " \
		chmod -R go-w $(mm_EXTRASDIR)                                                        ; \
		mksquashfs $(mm_EXTRASDIR) $(mm_STAGEDIR)/ram-$(mm_NAME)/extras.sfs > /dev/null 2>&1 "
	@chmod 0644 $(mm_STAGEDIR)/ram-$(mm_NAME)/extras.sfs
	@# Make themes squashfs image files.
	@echo "    making themes squashfs image files"
	@rm -rf    $(mm_STAGEDIR)/ram-$(mm_NAME)/themes
	@mkdir -p  $(mm_STAGEDIR)/ram-$(mm_NAME)/themes
	@for theme in `cd $(mm_THEMESDIR) ; ls -1` ; do                                                                              \
		fakeroot sh -c                                                                                                   "   \
			chmod -R go-w $(mm_THEMESDIR)/$${theme}                                                                  ;   \
			mksquashfs $(mm_THEMESDIR)/$${theme} $(mm_STAGEDIR)/ram-$(mm_NAME)/themes/$${theme}.sfs > /dev/null 2>&1 " ; \
		chmod 0644 $(mm_STAGEDIR)/ram-$(mm_NAME)/themes/$${theme}.sfs                                                       ; \
	done

mm-make-distro-nfs:
	@# Make NFS root file system distribution
	@echo "  making NFS root file system distribution"
	@rm -rf   $(mm_STAGEDIR)/nfs-$(mm_NAME)
	@mkdir -p $(mm_STAGEDIR)/nfs-$(mm_NAME)
	@# Get version.
	@cp -pdR $(mm_STAGEDIR)/version $(mm_STAGEDIR)/nfs-$(mm_NAME)/
	@# Get documentation 
	@cp -pdR $(mm_STAGEDIR)/html    $(mm_STAGEDIR)/nfs-$(mm_NAME)/
	@# Get scripts
	@cp -pdR $(mm_STAGEDIR)/scripts $(mm_STAGEDIR)/nfs-$(mm_NAME)/
	@# Get kernel.
	@cp -pdR $(mm_STAGEDIR)/kernel  $(mm_STAGEDIR)/nfs-$(mm_NAME)/
	@echo "    making root file system tarball file"
	@rm -rf $(mm_STAGEDIR)/nfs-$(mm_NAME)/rootfs.tar.bz2
	@fakeroot sh -c                                                                        " \
		chmod -R -s   $(mm_ROOTFSDIR)                                                  ; \
		chmod -R -t   $(mm_ROOTFSDIR)                                                  ; \
		chmod -R go-w $(mm_ROOTFSDIR)                                                  ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(ebindir)/busybox                     ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(ebindir)/ping                        ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(bindir)/pmount                       ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(esbindir)/poweroff                   ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(bindir)/pumount                      ; \
		chmod    u+s  $(mm_ROOTFSDIR)/rootfs-ro/$(bindir)/X                            ; \
		rm -rf $(mm_ROOTFSDIR)/rootfs-ro/$(rootdir)/dev                                ; \
		mkdir -p $(mm_ROOTFSDIR)/rootfs-ro/$(rootdir)/dev                              ; \
		mknod -m 0600 $(mm_ROOTFSDIR)/rootfs-ro/$(rootdir)/dev/console c 5 1           ; \
		mknod -m 0600 $(mm_ROOTFSDIR)/rootfs-ro/$(rootdir)/dev/initctl p               ; \
		tar -C $(mm_STAGEDIR) -jcf $(mm_STAGEDIR)/nfs-$(mm_NAME)/rootfs.tar.bz2 rootfs "
	@chmod 0644 $(mm_STAGEDIR)/nfs-$(mm_NAME)/rootfs.tar.bz2
	@# Make extras tarball file.
	@echo "    making extras tarball file"
	@rm -rf $(mm_STAGEDIR)/nfs-$(mm_NAME)/extras.tar.bz2
	@fakeroot sh -c                                                                        " \
		chmod -R go-w $(mm_EXTRASDIR)                                                  ; \
		tar -C $(mm_STAGEDIR) -jcf $(mm_STAGEDIR)/nfs-$(mm_NAME)/extras.tar.bz2 extras "
	@chmod 0644 $(mm_STAGEDIR)/nfs-$(mm_NAME)/extras.tar.bz2
	@# Make themes tarball file.
	@echo "    making themes tarball file"
	@rm -rf $(mm_STAGEDIR)/nfs-$(mm_NAME)/themes.tar.bz2
	@fakeroot sh -c                                                                        " \
		chmod -R go-w $(mm_THEMESDIR)                                                  ; \
		tar -C $(mm_STAGEDIR) -jcf $(mm_STAGEDIR)/nfs-$(mm_NAME)/themes.tar.bz2 themes "
	@chmod 0644 $(mm_STAGEDIR)/nfs-$(mm_NAME)/themes.tar.bz2
	@# Make local (private) distribution

mm-make-distro-local:
	@# Make local (private) distribution
	@echo "  making local (private) distribution"
	@rm -rf   $(mm_LOCALDIR)
	@mkdir -p $(mm_LOCALDIR)
	@cp -pdR  $(mm_STAGEDIR)/scripts                $(mm_LOCALDIR)/scripts
	@cp -pdR  $(mm_STAGEDIR)/version                $(mm_LOCALDIR)/version
	@cd $(mm_LOCALDIR) ; md5sum version                          > version.md5
	@cp -pdR  $(mm_STAGEDIR)/html.tar.bz2           $(mm_LOCALDIR)/html.tar.bz2
	@cd $(mm_LOCALDIR) ; md5sum html.tar.bz2                     > html.tar.bz2.md5
	@cp -pdR  $(mm_STAGEDIR)/helper.tar.bz2         $(mm_LOCALDIR)/helper.tar.bz2
	@cd $(mm_LOCALDIR) ; md5sum helper.tar.bz2                   > helper.tar.bz2.md5
	@cp -pdR  $(mm_STAGEDIR)/pxe-$(mm_NAME).tar.bz2 $(mm_LOCALDIR)/pxe-$(mm_NAME).tar.bz2
	@cd $(mm_LOCALDIR) ; md5sum pxe-$(mm_NAME).tar.bz2           > pxe-$(mm_NAME).tar.bz2.md5
	@cp -pdR  $(mm_STAGEDIR)/gar-$(mm_NAME).tar.bz2 $(mm_LOCALDIR)/gar-$(mm_NAME).tar.bz2
	@cd $(mm_LOCALDIR) ; md5sum gar-$(mm_NAME).tar.bz2           > gar-$(mm_NAME).tar.bz2.md5
	@if [ -e $(mm_STAGEDIR)/ram-$(mm_NAME) ] ; then \
		echo "    making RAM root file system part of the distribution"                 ; \
		cp -pdR  $(mm_STAGEDIR)/ram-$(mm_NAME)  $(mm_LOCALDIR)/ram-$(mm_NAME)           ; \
		$(MAKE) -f minimyth.mk mm-checksum-create DESTIMG=$(DESTIMG)      \
			_MM_CHECKSUM_CREATE_BASE=$(mm_LOCALDIR)/ram-$(mm_NAME) \
			_MM_CHECKSUM_CREATE_FILE=minimyth.md5                                   ; \
		tar -C $(mm_LOCALDIR) -jcf $(mm_LOCALDIR)/ram-$(mm_NAME).tar.bz2 ram-$(mm_NAME) ; \
		rm -rf $(mm_LOCALDIR)/ram-$(mm_NAME)                                            ; \
		cd $(mm_LOCALDIR) ; md5sum ram-$(mm_NAME).tar.bz2 > ram-$(mm_NAME).tar.bz2.md5  ; \
	 fi
	@if [ -e $(mm_STAGEDIR)/nfs-$(mm_NAME) ] ; then \
		echo "    making NFS root file system part of the distribution"                 ; \
		cp -pdR  $(mm_STAGEDIR)/nfs-$(mm_NAME)  $(mm_LOCALDIR)/nfs-$(mm_NAME)           ; \
		$(MAKE) -f minimyth.mk mm-checksum-create DESTIMG=$(DESTIMG)      \
			_MM_CHECKSUM_CREATE_BASE=$(mm_LOCALDIR)/nfs-$(mm_NAME) \
			_MM_CHECKSUM_CREATE_FILE=minimyth.md5                                   ; \
		tar -C $(mm_LOCALDIR) -jcf $(mm_LOCALDIR)/nfs-$(mm_NAME).tar.bz2 nfs-$(mm_NAME) ; \
		rm -rf $(mm_LOCALDIR)/nfs-$(mm_NAME)                                            ; \
		cd $(mm_LOCALDIR) ; md5sum nfs-$(mm_NAME).tar.bz2 > nfs-$(mm_NAME).tar.bz2.md5  ; \
	 fi
	@cp -pdR $(mm_HOME)/html/minimyth/document-changelog.txt $(mm_LOCALDIR)/changelog.txt

mm-make-distro-share:
	@# Make share (public) distribution
	@echo "  making share (public) distribution"
	@rm -rf   $(mm_SHAREDIR)
	@mkdir -p $(mm_SHAREDIR)
	@cp -pdR  $(mm_STAGEDIR)/scripts                $(mm_SHAREDIR)/scripts
	@cp -pdR  $(mm_STAGEDIR)/version                $(mm_SHAREDIR)/version
	@cd $(mm_SHAREDIR) ; md5sum version                          > version.md5
	@cp -pdR  $(mm_STAGEDIR)/html.tar.bz2           $(mm_SHAREDIR)/html.tar.bz2
	@cd $(mm_SHAREDIR) ; md5sum html.tar.bz2                     > html.tar.bz2.md5
	@cp -pdR  $(mm_STAGEDIR)/helper.tar.bz2         $(mm_SHAREDIR)/helper.tar.bz2
	@cd $(mm_SHAREDIR) ; md5sum helper.tar.bz2                   > helper.tar.bz2.md5
	@cp -pdR  $(mm_STAGEDIR)/pxe-$(mm_NAME).tar.bz2 $(mm_SHAREDIR)/pxe-$(mm_NAME).tar.bz2
	@cd $(mm_SHAREDIR) ; md5sum pxe-$(mm_NAME).tar.bz2           > pxe-$(mm_NAME).tar.bz2.md5
	@cp -pdR  $(mm_STAGEDIR)/gar-$(mm_NAME).tar.bz2 $(mm_SHAREDIR)/gar-$(mm_NAME).tar.bz2
	@cd $(mm_SHAREDIR) ; md5sum gar-$(mm_NAME).tar.bz2           > gar-$(mm_NAME).tar.bz2.md5
	@if [ -e $(mm_STAGEDIR)/ram-$(mm_NAME) ] ; then \
		echo "    making RAM root file system part of the distribution"                 ; \
		cp -pdR  $(mm_STAGEDIR)/ram-$(mm_NAME)  $(mm_SHAREDIR)/ram-$(mm_NAME)           ; \
		rm -rf $(mm_SHAREDIR)/ram-$(mm_NAME)/extras.sfs                                 ; \
		$(MAKE) -f minimyth.mk mm-checksum-create DESTIMG=$(DESTIMG)      \
			_MM_CHECKSUM_CREATE_BASE=$(mm_SHAREDIR)/ram-$(mm_NAME) \
			_MM_CHECKSUM_CREATE_FILE=minimyth.md5                                   ; \
		tar -C $(mm_SHAREDIR) -jcf $(mm_SHAREDIR)/ram-$(mm_NAME).tar.bz2 ram-$(mm_NAME) ; \
		rm -rf $(mm_SHAREDIR)/ram-$(mm_NAME)                                            ; \
		cd $(mm_SHAREDIR) ; md5sum ram-$(mm_NAME).tar.bz2 > ram-$(mm_NAME).tar.bz2.md5  ; \
	 fi
	@if [ -e $(mm_STAGEDIR)/nfs-$(mm_NAME) ] ; then \
		echo "    making NFS root file system part of the distribution"                 ; \
		cp -pdR  $(mm_STAGEDIR)/nfs-$(mm_NAME)  $(mm_SHAREDIR)/nfs-$(mm_NAME)           ; \
		rm -rf $(mm_SHAREDIR)/nfs-$(mm_NAME)/extras.tar.bz2                             ; \
		$(MAKE) -f minimyth.mk mm-checksum-create DESTIMG=$(DESTIMG)      \
			_MM_CHECKSUM_CREATE_BASE=$(mm_SHAREDIR)/nfs-$(mm_NAME) \
			_MM_CHECKSUM_CREATE_FILE=minimyth.md5                                   ; \
		tar -C $(mm_SHAREDIR) -jcf $(mm_SHAREDIR)/nfs-$(mm_NAME).tar.bz2 nfs-$(mm_NAME) ; \
		rm -rf $(mm_SHAREDIR)/nfs-$(mm_NAME)                                            ; \
		cd $(mm_SHAREDIR) ; md5sum nfs-$(mm_NAME).tar.bz2 > nfs-$(mm_NAME).tar.bz2.md5  ; \
	 fi
	@cp -pdR $(mm_HOME)/html/minimyth/document-changelog.txt $(mm_SHAREDIR)/changelog.txt
	@cp -pdR ./files/share-readme.txt                        $(mm_SHAREDIR)/readme.txt

mm-make-distro: \
	mm-make-distro-base \
	$(if $(filter yes,$(mm_DISTRIBUTION_RAM)),  mm-make-distro-ram   ) \
	$(if $(filter yes,$(mm_DISTRIBUTION_NFS)),  mm-make-distro-nfs   ) \
	$(if $(filter yes,$(mm_DISTRIBUTION_LOCAL)),mm-make-distro-local ) \
	$(if $(filter yes,$(mm_DISTRIBUTION_SHARE)),mm-make-distro-share )

mm-make-source:
	@rm -rf   $(mm_STAGEDIR)/source
	@mkdir -p $(mm_STAGEDIR)/source
	@tar  -C $(SOURCE_DIR_HEAD) \
		--exclude '$(SOURCE_DIR_TAIL)/images/*' \
		--exclude '$(SOURCE_DIR_TAIL)/source/*' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*/cookies' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*/cookies/*' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*/download' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*/download/*' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*/tmp' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*/tmp/*' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*/work' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*/work/*' \
		--exclude '$(SOURCE_DIR_TAIL)/*.log' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*.log' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*.log' \
		--exclude '$(SOURCE_DIR_TAIL)/script/*/*/*.log' \
		-jcf $(mm_STAGEDIR)/source/$(SOURCE_DIR_TAIL).tar.bz2 \
		$(SOURCE_DIR_TAIL)
	@cd $(mm_STAGEDIR)/source ; tar -jxf $(SOURCE_DIR_TAIL).tar.bz2
	@cd $(mm_STAGEDIR)/source ; test "$(SOURCE_DIR_TAIL)" = "gar-$(mm_NAME)" || mv $(SOURCE_DIR_TAIL) gar-$(mm_NAME)
	@find $(mm_STAGEDIR)/source/gar-$(mm_NAME) -name .svn -exec rm -rf '{}' +
	@tar -C $(mm_STAGEDIR)/source -jcf $(mm_STAGEDIR)/gar-$(mm_NAME).tar.bz2 gar-$(mm_NAME)
	@rm -fr $(mm_STAGEDIR)/source
	@chmod 0644 $(mm_STAGEDIR)/$(mm_SOURCENAME).tar.bz2

mm-checksum-create:
	@rm -rf $(_MM_CHECKSUM_CREATE_BASE)/$(_MM_CHECKSUM_CREATE_FILE)              ; \
	for file in `cd $(_MM_CHECKSUM_CREATE_BASE) ; ls -1` ; do                      \
		$(MAKE) -f minimyth.mk DESTIMG=$(DESTIMG)                                 \
			mm-$${file}/checksum-create                                    \
				_MM_CHECKSUM_CREATE_BASE=$(_MM_CHECKSUM_CREATE_BASE)   \
				_MM_CHECKSUM_CREATE_FILE=$(_MM_CHECKSUM_CREATE_FILE) ; \
	done

mm-%/checksum-create:
	@if   test -d $(_MM_CHECKSUM_CREATE_BASE)/$* ; then                                     \
		for file in `cd $(_MM_CHECKSUM_CREATE_BASE)/$* ; ls -1` ; do                    \
			$(MAKE) -f minimyth.mk mm-$*/$${file}/checksum-create DESTIMG=$(DESTIMG)   \
				_MM_CHECKSUM_CREATE_BASE=$(_MM_CHECKSUM_CREATE_BASE)            \
				_MM_CHECKSUM_CREATE_FILE=$(_MM_CHECKSUM_CREATE_FILE)          ; \
		done                                                                          ; \
	elif test -f $(_MM_CHECKSUM_CREATE_BASE)/$* ; then                                      \
		cd $(_MM_CHECKSUM_CREATE_BASE)                                                ; \
		md5sum $* >> $(_MM_CHECKSUM_CREATE_FILE)                                      ; \
	fi

mm-install: mm-check
	@rm -rf   $(mm_DESTDIR)
	@mkdir -p $(mm_DESTDIR)
	@if [ -e $(mm_LOCALDIR) ] ; then \
		cp -pdR $(mm_LOCALDIR) $(mm_DESTDIR)/ ; \
	 fi
	@if [ -e $(mm_SHAREDIR) ] ; then \
		cp -pdR $(mm_SHAREDIR) $(mm_DESTDIR)/ ; \
	 fi
	@if [ $(mm_INSTALL_RAM_BOOT) = yes ] || [ $(mm_INSTALL_NFS_BOOT) = yes ] || [ $(mm_INSTALL_LATEST) = yes ] ; then \
		su -c " \
			if [ $(mm_INSTALL_RAM_BOOT) = yes ] ; then \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME) ; \
			fi ; \
			\
			if [ $(mm_INSTALL_NFS_BOOT) = yes ] ; then \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME) ; \
				rm -rf   $(mm_NFS_ROOT)/$(mm_NAME)  ; \
			fi ; \
			\
			if [ $(mm_INSTALL_LATEST)           = yes ] ; then \
				rm -rf   $(mm_TFTP_ROOT)/latest ; \
			fi ; \
			\
			if [ $(mm_INSTALL_RAM_BOOT) = yes ] ; then \
				mkdir -p $(mm_TFTP_ROOT)/                                                                               ; \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME).tmp                                                                 ; \
				mkdir -p $(mm_TFTP_ROOT)/$(mm_NAME).tmp                                                                 ; \
				tar -jxf $(mm_LOCALDIR)/ram-$(mm_NAME).tar.bz2 -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp                        ; \
				\
				mkdir -p $(mm_TFTP_ROOT)/$(mm_NAME)                                                                     ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/version    $(mm_TFTP_ROOT)/$(mm_NAME)/version    ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/kernel     $(mm_TFTP_ROOT)/$(mm_NAME)/kernel     ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/rootfs     $(mm_TFTP_ROOT)/$(mm_NAME)/rootfs     ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/themes     $(mm_TFTP_ROOT)/$(mm_NAME)/themes     ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/extras.sfs $(mm_TFTP_ROOT)/$(mm_NAME)/extras.sfs ; \
				\
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME).tmp                                                                 ; \
			fi ; \
			\
			if [ $(mm_INSTALL_NFS_BOOT) = yes ] ; then \
				mkdir -p $(mm_TFTP_ROOT)/                                                                                    ; \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME).tmp                                                                      ; \
				mkdir -p $(mm_TFTP_ROOT)/$(mm_NAME).tmp                                                                      ; \
				tar -jxf $(mm_LOCALDIR)/nfs-$(mm_NAME).tar.bz2 -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp                             ; \
				\
				mkdir -p $(mm_TFTP_ROOT)/                                                                                    ; \
				mkdir -p $(mm_TFTP_ROOT)/$(mm_NAME)                                                                          ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/version $(mm_TFTP_ROOT)/$(mm_NAME)/version            ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/kernel  $(mm_TFTP_ROOT)/$(mm_NAME)/kernel             ; \
				\
				tar -jxf $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/rootfs.tar.bz2  -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp     ; \
				tar -jxf $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/extras.tar.bz2  -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp     ; \
				tar -jxf $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/themes.tar.bz2  -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp     ; \
				mkdir -p $(mm_NFS_ROOT)                                                                                      ; \
				mv       $(mm_TFTP_ROOT)/$(mm_NAME).tmp/rootfs   $(mm_NFS_ROOT)/$(mm_NAME)                                   ; \
				mv       $(mm_TFTP_ROOT)/$(mm_NAME).tmp/themes/* $(mm_NFS_ROOT)/$(mm_NAME)/rootfs-ro/usr/share/mythtv/themes ; \
				mv       $(mm_TFTP_ROOT)/$(mm_NAME).tmp/extras/* $(mm_NFS_ROOT)/$(mm_NAME)/rootfs-ro/$(extras_rootdir)       ; \
				\
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME).tmp                                                                      ; \
			fi ; \
			\
			if [ $(mm_INSTALL_LATEST)  = yes ] ; then \
				mkdir -p $(mm_TFTP_ROOT)/latest                    ; \
				cp -pdR  $(mm_LOCALDIR)/* $(mm_TFTP_ROOT)/latest/  ; \
			fi ; \
		" ; \
	fi
