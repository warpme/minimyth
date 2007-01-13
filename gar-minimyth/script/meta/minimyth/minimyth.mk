PWD := `pwd`

WORKSRC = $(WORKDIR)/minimyth-$(mm_VERSION)

GAR_EXTRA_CONF += kernel/linux/package-api.mk devel/build-system-bins/package-api.mk
include ../../gar.mk

mm_ROOTFSDIR := $(PWD)/$(WORKSRC)/rootfs.d
mm_EXTRASDIR := $(PWD)/$(WORKSRC)/extras.d

MM_BIN_FILES    := $(strip \
	$(if $(wildcard               minimyth-bin-list   ),               minimyth-bin-list   ) \
	$(if $(wildcard    ../../extras/extras-bin-list   ),    ../../extras/extras-bin-list   ) \
	$(filter $(patsubst %,minimyth-bin-list.%,$(mm_CHIPSETS)),$(wildcard minimyth-bin-list.*)))
MM_LIB_FILES    := $(strip \
	$(if $(wildcard               minimyth-lib-list   ),               minimyth-lib-list   ) \
	$(if $(wildcard    ../../extras/extras-lib-list   ),    ../../extras/extras-lib-list   ) \
	$(filter $(patsubst %,minimyth-lib-list.%,$(mm_CHIPSETS)),$(wildcard minimyth-lib-list.*)))
MM_ETC_FILES    := $(strip \
	$(if $(wildcard               minimyth-etc-list   ),               minimyth-etc-list   ) \
	$(if $(wildcard    ../../extras/extras-etc-list   ),    ../../extras/extras-etc-list   ) \
	$(filter $(patsubst %,minimyth-etc-list.%,$(mm_CHIPSETS)),$(wildcard minimyth-etc-list.*)))
MM_SHARE_FILES  := $(strip \
	$(if $(wildcard               minimyth-share-list ),               minimyth-share-list ) \
	$(if $(wildcard    ../../extras/extras-share-list ),    ../../extras/extras-share-list ) \
	$(filter $(patsubst %,minimyth-share-list.%,$(mm_CHIPSETS)),$(wildcard minimyth-share-list.*)))
MM_REMOVE_FILES := $(strip \
	$(if $(wildcard               minimyth-remove-list),               minimyth-remove-list) \
	$(filter-out $(patsubst %,minimyth-remove-list.%,$(mm_CHIPSETS)),$(wildcard minimyth-remove-list.*)))

MM_BIN_DEBUG    := $(strip $(if $(filter yes,$(mm_DEBUG)), \
	gdb \
	strace \
	xdpyinfo \
	valgrind \
	valgrind-listener \
	cg_annotate \
	callgrind_control \
	callgrind_annotate \
	))
MM_LIB_DEBUG    := $(strip $(if $(filter yes,$(mm_DEBUG)), \
	valgrind \
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

bindirs := \
	$(extras_sbindir) \
	$(extras_bindir) \
	$(esbindir) \
	$(ebindir) \
	$(sbindir) \
	$(bindir) \
	$(qtbindir)
libdirs_base := \
	$(extras_libdir) \
	$(elibdir) \
	$(libdir) \
	$(libdir)/mysql \
	$(qtlibdir)
libdirs := \
	$(libdir)/xorg/modules \
	$(if $(filter $(mm_CHIPSETS),nvidia),$(libdir)/nvidia) \
	$(if $(filter $(mm_CHIPSETS),nvidia),$(libdir)/nvidia/xorg/modules) \
	$(libdirs_base)
etcdirs :=  \
	$(extras_sysconfdir) \
	$(sysconfdir)
sharedirs :=  \
	$(extras_sharedstatedir) \
	$(sharedstatedir)

IS_BIN = $(if $(shell file $(1) | grep -i 'ELF ..-bit LSB executable'   ),yes,no)
IS_LIB = $(if $(shell file $(1) | grep -i 'ELF ..-bit LSB shared object'),yes,no)

MM_PATH := $(PATH)

MAKE_PATH = \
	$(patsubst @%@,%,$(subst @ @,:, $(strip $(patsubst %,@%@,$(1)))))
LIST_FILES = \
	$(strip $(sort $(foreach dir, $(2), $(shell if test -d $(strip $(1)$(dir)) ; then cd $(strip $(1))$(dir) ; ls -1 ; fi) )))
LIST_LIBS = \
	$(filter-out \
		$(call LIST_FILES, $(mm_ROOTFSDIR), $(libdirs)), \
		$(shell $(OBJDUMP) -x $(1) 2> /dev/null \
			| grep -e '^ *NEEDED  *' \
			| sed -e 's%^ *%%' -e 's% *$$%%' -e 's%  *% %' \
			| cut -d' ' -f 2 \
		) \
	)

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
				file_list=`cd $(DESTDIR)/$${dir} ; ls -1d $${file_item} 2> /dev/null` ; \
			fi ; \
			for file in $${file_list} ; do \
				if test -e $(DESTDIR)/$${dir}/$${file} ; then \
					found="true" ; \
					source_file="$(DESTDIR)/$${dir}/$${file}" ; \
					target_file="$(mm_ROOTFSDIR)/$${dir}/$${file}" ; \
					if test ! -e $${target_file} ; then \
						if test -d $${source_file} ; then \
                                       			target_dir=`dirname $${target_file}` ; \
                                       			mkdir -p $${target_dir} ; \
							cp -fa  $${source_file} $${target_file} ; \
						else \
                                       			target_dir=`dirname $${target_file}` ; \
                                       			mkdir -p $${target_dir} ; \
							cp -f  $${source_file} $${target_file} ; \
						fi ; \
					fi ; \
				fi ; \
			done ; \
		done ; \
		if test -z $${found} ; then \
			echo "warning: $(strip $(2)) \"$${file_item}\" not found." ; \
		fi ; \
	done

mm-all:

mm-build: mm-check mm-clean mm-make-busybox mm-copy mm-make-conf mm-remove-pre mm-copy-libs mm-remove-post mm-strip mm-gen-files mm-make-udev mm-make-extras mm-make-initrd mm-make-distro

mm-check:
	@if [ "`id -u`" = "0" ] ; then \
		echo "error: gar-minimyth must not be run as root." ; \
		exit 1 ; \
	fi
	@if [ ! -e $(HOME)/.minimyth/minimyth.conf.mk ] ; then \
		echo "error: configuration file '$(HOME)/.minimyth/minimyth.conf.mk' is missing." ; \
		exit 1 ; \
	fi
	@if [ ! "$(mm_GARCH)" = "athlon64"    ] && \
	    [ ! "$(mm_GARCH)" = "c3"          ] && \
	    [ ! "$(mm_GARCH)" = "c3-2"        ] && \
	    [ ! "$(mm_GARCH)" = "pentium-mmx" ] ; then \
		echo "error: mm_GARCH=\"$(mm_GARCH)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@if [ ! "$(mm_HOME)" = "`cd $(GARDIR)/.. ; pwd`" ] ; then \
		echo "error: mm_HOME must be set to \"`cd $(GARDIR)/.. ; pwd`\" but has been set to \"$(mm_HOME)\"."; \
		exit 1 ; \
	fi
	@if [ "$(firstword $(strip $(subst /, ,$(mm_HOME))))" = "$(firstword $(strip $(subst /, ,$(qtprefix))))" ] ; then \
		echo "error: MiniMyth cannot be built in a subdirectory of \"/$(firstword $(strip $(subst /, ,$(qtprefix))))\"."; \
		exit 1 ; \
	fi
	@if [ ! "$(mm_INSTALL_CRAMFS)" = "yes" ] && [ ! "$(mm_INSTALL_CRAMFS)" = "no" ] ; then \
		echo "error: mm_INSTALL_CRAMFS=\"$(mm_INSTALL_CRAMFS)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@if [ ! "$(mm_INSTALL_NFS)" = "yes" ] && [ ! "$(mm_INSTALL_NFS)" = "no" ] ; then \
		echo "error: mm_INSTALL_NFS=\"$(mm_INSTALL_NFS)\" is an invalid value." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_CRAMFS)" = "yes" ] && [ ! -d "$(mm_TFTP_ROOT)" ] ; then \
		echo "error: the directory specified by mm_TFTP_ROOT=\"$(mm_TFTP_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_NFS)" = "yes" ] && [ ! -d "$(mm_TFTP_ROOT)" ] ; then \
		echo "error: the directory specified by mm_TFTP_ROOT=\"$(mm_TFTP_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_NFS)" = "yes" ] && [ ! -d "$(mm_NFS_ROOT)" ] ; then \
		echo "error: the directory specified by mm_NFS_ROOT=\"$(mm_NFS_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@for bin in $(build_system_bins) ; do \
		which $${bin} > /dev/null 2>&1 ; \
		if [ ! "$$?" = "0" ] ; then \
			echo "error: the build system does not contain the program '$${bin}'." ; \
			exit 1 ; \
		fi ; \
	done

mm-clean:
	@rm -rf $(mm_DESTDIR)

mm-make-busybox:
	@main_DESTDIR=$(mm_ROOTFSDIR) make -C $(GARDIR)/utils/busybox DESTIMG=$(DESTIMG) install
	@rm -rf $(mm_ROOTFSDIR)/var

mm-copy:
	@# Copy licenses.
	@mkdir -p $(mm_ROOTFSDIR)$(licensedir)
	@cp -fa $(DESTDIR)$(licensedir)/* $(mm_ROOTFSDIR)$(licensedir)
	@mkdir -p $(mm_ROOTFSDIR)$(extras_licensedir)
	@cp -fa $(DESTDIR)$(licensedir)/* $(mm_ROOTFSDIR)$(extras_licensedir)
	@# Copy kernel.
	@mkdir -p $(WORKSRC)
	@cp -f $(DESTDIR)$(KERNEL_DIR)/vmlinuz $(WORKSRC)/$(mm_KERNELNAME)
	@# Copy QT mysql plugin.
	@mkdir -p $(mm_ROOTFSDIR)$(qtprefix)/plugins
	@cp -fa $(DESTDIR)$(qtprefix)/plugins/sqldrivers $(mm_ROOTFSDIR)$(qtprefix)/plugins
	@mkdir -p $(mm_ROOTFSDIR)$(bindir)
	@cp -fa ./dirs/usr/bin/*                         $(mm_ROOTFSDIR)$(bindir)
	@# Copy binaries, etcs, shares, and libraries.
	@$(call COPY_FILES, "binaries" , "binary" , $(bindirs)  , $(MM_BINS)  )
	@$(call COPY_FILES, "etcs"     , "etc"    , $(etcdirs)  , $(MM_ETCS)  )
	@$(call COPY_FILES, "shares"   , "share"  , $(sharedirs), $(MM_SHARES))
	@$(call COPY_FILES, "libraries", "library", $(libdirs)  , $(MM_LIBS)  )

mm-make-conf:
	@mkdir -p $(mm_ROOTFSDIR)$(sysconfdir)
	@mkdir -p $(mm_ROOTFSDIR)$(sysconfdir)/fonts
	@echo -n                                         >  $(mm_ROOTFSDIR)/$(sysconfdir)/fonts/local.conf
	@echo '<?xml version="1.0"?>'                    >> $(mm_ROOTFSDIR)/$(sysconfdir)/fonts/local.conf
	@echo '<!DOCTYPE fontconfig SYSTEM "fonts.dtd">' >> $(mm_ROOTFSDIR)/$(sysconfdir)/fonts/local.conf
	@echo '<fontconfig>'                             >> $(mm_ROOTFSDIR)/$(sysconfdir)/fonts/local.conf
	@echo '<dir>$(libdir)/X11/fonts/misc</dir>'      >> $(mm_ROOTFSDIR)/$(sysconfdir)/fonts/local.conf
	@echo '<dir>$(libdir)/X11/fonts/TTF</dir>'       >> $(mm_ROOTFSDIR)/$(sysconfdir)/fonts/local.conf
	@echo '</fontconfig>'                            >> $(mm_ROOTFSDIR)/$(sysconfdir)/fonts/local.conf
	@cp -r ./dirs/etc/* $(mm_ROOTFSDIR)$(sysconfdir)
	@sed -i 's%@PATH@%$(call MAKE_PATH,$(bindirs))%'          $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@sed -i 's%@MM_VERSION@%$(mm_VERSION)%'                   $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@sed -i 's%@MM_VERSION_MYTH@%$(mm_VERSION_MYTH)%'         $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@sed -i 's%@MM_VERSION_MINIMYTH@%$(mm_VERSION_MINIMYTH)%' $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@sed -i 's%@EXTRAS_ROOTDIR@%$(extras_rootdir)%'  $(mm_ROOTFSDIR)$(sysconfdir)/rc.d/init.d/extras
	@rm -f $(mm_ROOTFSDIR)$(sysconfdir)/ld.so.conf
	@$(foreach dir, $(libdirs_base), echo $(dir) >> $(mm_ROOTFSDIR)$(sysconfdir)/ld.so.conf ; )
	@rm -f $(mm_ROOTFSDIR)$(sysconfdir)/ld.so.cache{,~}
	@rm -rf $(mm_ROOTFSDIR)/root       ; cp -r ./dirs/root $(mm_ROOTFSDIR)
	@rm -rf $(mm_ROOTFSDIR)/srv        ; cp -r ./dirs/srv  $(mm_ROOTFSDIR)
	@rm -rf $(mm_ROOTFSDIR)/srv/www/fs ; ln -sf / $(mm_ROOTFSDIR)/srv/www/fs
	@sed -i 's%@MM_VERSION@%$(mm_VERSION)%' $(mm_ROOTFSDIR)/srv/www/cgi-bin/functions
	@ln -sf $(sysconfdir)/lircrc $(mm_ROOTFSDIR)/root/.lircrc
	@ln -sf $(sysconfdir)/lircrc $(mm_ROOTFSDIR)/root/.mythtv/lircrc

mm-remove-pre:
	@# Remove unwanted binaries, etc, shares and libraries.
	@echo 'removing unwanted files'
	@for remove in $(addprefix $(mm_ROOTFSDIR),$(MM_REMOVES)) ; do \
		rm -rf $${remove} ; \
	done

mm-remove-post:
	@# Remove unwanted binaries, etc, shares and libraries.
	@echo 'removing unwanted files'
	@for remove in $(addprefix $(mm_ROOTFSDIR),$(MM_REMOVES)) ; do \
		rm -rf $${remove} ; \
	done

mm-copy-libs:
	@# Copy dependent libraries.
	@echo 'copying dependent libraries'
	@make -s -f minimyth.mk mm-$(mm_ROOTFSDIR)/copy-libs DESTIMG=$(DESTIMG)

mm-%/copy-libs:
	@if test ! -L $* ; then \
		if   test -d $* ; then \
			for dir in `cd $* ; ls` ; do \
				make -s -f minimyth.mk mm-$*/$${dir}/copy-libs DESTIMG=$(DESTIMG) ; \
			done ; \
		elif test -f $* && ( test $(call IS_BIN, $*) == yes || test $(call IS_LIB, $*) == yes ) ; then \
			for lib in $(call LIST_LIBS, $*) ; do \
				libdir="" ; \
				for dir in $(libdirs) ; do \
					if test -d $(DESTDIR)/$${dir} ; then \
						if test x`cd $(DESTDIR)/$${dir} ; ls -1 $${lib} 2>/dev/null` == x$${lib} ; then \
							libdir=$${dir} ; \
							if test ! -z $${libdir} ; then \
								source_lib="$(DESTDIR)/$${libdir}/$${lib}" ; \
								target_lib="$(mm_ROOTFSDIR)/$${libdir}/$${lib}" ; \
								if test ! -e $${target_lib} ; then \
                                                			target_dir=`dirname $${target_lib}` ; \
                                                			mkdir -p $${target_dir} ; \
									cp -f  $${source_lib} $${target_lib} ; \
									make -s -f minimyth.mk mm-$${target_lib}/copy-libs DESTIMG=$(DESTIMG) ; \
								fi ; \
							fi ; \
						fi ; \
					fi ; \
				done ; \
				if test -z $${libdir} ; then \
					echo "warning: library \"$${lib}\" not found ($*)." ; \
				fi ; \
			done ; \
		fi ; \
	fi

mm-strip:
	@if test ! $(mm_DEBUG) == yes ; then \
		echo 'stripping binaries and shared libraries' ; \
		make -s -f minimyth.mk mm-$(mm_ROOTFSDIR)/strip DESTIMG=$(DESTIMG) ; \
	fi

mm-%/strip:
	@if test ! -L $* ; then \
		if   test -d $* ; then \
			for dir in `cd $* ; ls` ; do \
				make -s -f minimyth.mk mm-$*/$${dir}/strip DESTIMG=$(DESTIMG) ; \
			done ; \
		elif test -f $* && ( test $(call IS_BIN, $*) == yes || test $(call IS_LIB, $*) == yes ) ; then \
			chmod u+w $* ; \
			$(STRIP) --strip-all -R .note -R .comment $* ; \
		fi ; \
	fi

mm-gen-files:
	@depmod -b "$(mm_ROOTFSDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"
	@cd $(mm_ROOTFSDIR)$(libdir)/X11/fonts/misc ; mkfontscale . ; mkfontdir .
	@cd $(mm_ROOTFSDIR)$(libdir)/X11/fonts/TTF  ; mkfontscale . ; mkfontdir .

mm-make-udev:
	$(foreach file, $(shell cd ./dirs/udev/scripts.d ; ls -1 *      ), \
		install -m 755 -D  ./dirs/udev/scripts.d/$(file) $(mm_ROOTFSDIR)$(elibdir)/udev/$(file) ; )
	$(foreach file, $(shell cd ./dirs/udev/rules.d   ; ls -1 *.rules), \
		install -m 644 -D  ./dirs/udev/rules.d/$(file)   $(mm_ROOTFSDIR)$(sysconfdir)/udev/rules.d/$(file) ; )
	@mkdir -p $(mm_ROOTFSDIR)$(elibdir)/udev/devices

mm-make-extras:
	@rm -rf $(mm_EXTRASDIR) ; mkdir -p $(mm_EXTRASDIR)
	@mv $(mm_ROOTFSDIR)/$(extras_rootdir)/* $(mm_EXTRASDIR)
	@rm -rf $(mm_ROOTFSDIR)/$(extras_rootdir) ; mkdir -p $(mm_ROOTFSDIR)/$(extras_rootdir)

mm-make-initrd:
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
	@cp -r ./dirs/initrd/sbin/init      $(mm_ROOTFSDIR)/sbin/init

mm-make-distro:
	@echo 'making minimyth distribution'
	@# Make root file system cram image and tarball files.
	rm -rf $(WORKSRC)/$(mm_ROOTFSNAME)
	rm -rf $(WORKSRC)/$(mm_ROOTFSNAME).bz2
	rm -rf $(WORKSRC)/rootfs.d/rootfs-ro/$(rootdir)/dev
	mkdir -p $(WORKSRC)/rootfs.d/rootfs-ro/$(rootdir)/dev
	fakeroot sh -c                                                                  " \
		mknod -m 600 $(WORKSRC)/rootfs.d/rootfs-ro/$(rootdir)/dev/console c 5 1 ; \
		mknod -m 600 $(WORKSRC)/rootfs.d/rootfs-ro/$(rootdir)/dev/initctl p     ; \
		chown -R $(call GET_UID,root):$(call GET_GID,root) $(WORKSRC)/rootfs.d  ; \
		chmod -R go-w $(WORKSRC)/rootfs.d                                       ; \
		mkfs.cramfs $(WORKSRC)/rootfs.d $(WORKSRC)/$(mm_ROOTFSNAME)             ; \
		tar -C $(WORKSRC)/rootfs.d -jcf $(WORKSRC)/$(mm_ROOTFSNAME).tar.bz2 .   "
	@# Make extras cram image and tarball files.
	rm -rf $(WORKSRC)/$(mm_EXTRASNAME).cmg
	rm -rf $(WORKSRC)/$(mm_EXTRASNAME).tar.bz2
	fakeroot sh -c                                                      " \
		chown -R $(call GET_UID,root):$(call GET_GID,root) $(WORKSRC)/extras.d  ; \
		chmod -R go-w $(WORKSRC)/rootfs.d                                       ; \
		mkfs.cramfs $(WORKSRC)/extras.d $(WORKSRC)/$(mm_EXTRASNAME).cmg         ; \
		tar -C $(WORKSRC)/extras.d -jcf $(WORKSRC)/$(mm_EXTRASNAME).tar.bz2 . "
	@# Make source tarball file.
	@rm -f $(mm_HOME)/$(mm_SOURCENAME).tar.bz2
	@cd $(mm_HOME) ; make tarball
	@mv -f $(mm_HOME)/$(mm_SOURCENAME).tar.bz2 $(WORKSRC)/$(mm_SOURCENAME).tar.bz2
	@# Make public distribution files
	@rm -rf $(WORKSRC)/distro.d
	@mkdir -p $(WORKSRC)/distro.d
	@cp -f $(WORKSRC)/$(mm_SOURCENAME).tar.bz2 $(WORKSRC)/distro.d/$(mm_SOURCENAME).tar.bz2
	@cp -f $(WORKSRC)/$(mm_KERNELNAME)         $(WORKSRC)/distro.d/$(mm_KERNELNAME)
	@cp -f $(WORKSRC)/$(mm_ROOTFSNAME)         $(WORKSRC)/distro.d/$(mm_ROOTFSNAME)
	@cp -f $(mm_HOME)/docs/minimyth.conf       $(WORKSRC)/distro.d/minimyth.conf
	@cp -f $(mm_HOME)/docs/minimyth.script     $(WORKSRC)/distro.d/minimyth.script
	@cp -f $(mm_HOME)/docs/minimyth.dhcp       $(WORKSRC)/distro.d/minimyth.dhcp
	@cp -f $(mm_HOME)/docs/changelog.txt       $(WORKSRC)/distro.d/changelog.txt
	@cp -f $(mm_HOME)/docs/readme.txt          $(WORKSRC)/distro.d/readme.txt
	@cp -f ./files/mkusbkey                    $(WORKSRC)/distro.d/mkusbkey
	@cd $(WORKSRC)/distro.d ; md5sum $(mm_SOURCENAME).tar.bz2 >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum $(mm_KERNELNAME)         >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum $(mm_ROOTFSNAME)         >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum minimyth.conf            >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum minimyth.script          >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum minimyth.dhcp            >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum changelog.txt            >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum readme.txt               >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum mkusbkey                 >> md5sums.txt

mm-install: mm-check
	@rm -rf $(mm_DESTDIR)
	@mkdir -p $(mm_DESTDIR)
	@cp -f  $(WORKSRC)/$(mm_SOURCENAME).tar.bz2 $(mm_DESTDIR)/$(mm_SOURCENAME).tar.bz2
	@cp -f  $(WORKSRC)/$(mm_KERNELNAME)         $(mm_DESTDIR)/$(mm_KERNELNAME)
	@cp -f  $(WORKSRC)/$(mm_ROOTFSNAME)         $(mm_DESTDIR)/$(mm_ROOTFSNAME)
	@cp -f  $(WORKSRC)/$(mm_ROOTFSNAME).tar.bz2 $(mm_DESTDIR)/$(mm_ROOTFSNAME).tar.bz2
	@cp -f  $(WORKSRC)/$(mm_EXTRASNAME).cmg     $(mm_DESTDIR)/$(mm_EXTRASNAME).cmg
	@cp -f  $(WORKSRC)/$(mm_EXTRASNAME).tar.bz2 $(mm_DESTDIR)/$(mm_EXTRASNAME).tar.bz2
	@cp -rf $(WORKSRC)/distro.d                 $(mm_DESTDIR)/distro.d
	@if [ $(mm_INSTALL_CRAMFS) = yes ] || [ $(mm_INSTALL_NFS) = yes ] ; then \
		su -c " \
			if [ $(mm_INSTALL_CRAMFS) = yes ] ; then \
				mkdir -p $(mm_TFTPDIR) ; \
				\
				rm -rf $(mm_TFTPDIR)/$(mm_KERNELNAME) ; \
				cp -r $(mm_DESTDIR)/$(mm_KERNELNAME) $(mm_TFTPDIR)/$(mm_KERNELNAME) ; \
				\
				mkdir -p $(mm_TFTPDIR) ; \
				\
				rm -rf $(mm_TFTPDIR)/$(mm_ROOTFSNAME) ; \
				cp -r $(mm_DESTDIR)/$(mm_ROOTFSNAME) $(mm_TFTPDIR)/$(mm_ROOTFSNAME) ; \
				\
				rm -rf $(mm_TFTPDIR)/$(mm_EXTRASNAME).cmg ; \
				cp -r $(mm_DESTDIR)/$(mm_EXTRASNAME).cmg $(mm_TFTPDIR)/$(mm_EXTRASNAME).cmg ; \
			fi ; \
			\
			if [ $(mm_INSTALL_NFS) = yes ] ; then \
				mkdir -p $(mm_TFTPDIR) ; \
				\
				rm -rf $(mm_TFTPDIR)/$(mm_KERNELNAME) ; \
				cp -r $(mm_DESTDIR)/$(mm_KERNELNAME) $(mm_TFTPDIR)/$(mm_KERNELNAME) ; \
				\
				mkdir -p $(mm_NFSDIR) ; \
				\
				rm -rf $(mm_NFSDIR)/$(mm_NFSNAME) ; \
				mkdir -p $(mm_NFSDIR)/$(mm_NFSNAME) ; \
				tar -C $(mm_NFSDIR)/$(mm_NFSNAME) \
					-jxf $(mm_DESTDIR)/$(mm_ROOTFSNAME).tar.bz2 ; \
				\
				rm -rf $(mm_NFSDIR)/$(mm_NFSNAME)/rootfs-ro/$(extras_rootdir) ; \
				mkdir -p $(mm_NFSDIR)/$(mm_NFSNAME)/rootfs-ro/$(extras_rootdir) ; \
				tar -C $(mm_NFSDIR)/$(mm_NFSNAME)/rootfs-ro/$(extras_rootdir) \
					-jxf $(mm_DESTDIR)/$(mm_EXTRASNAME).tar.bz2 ; \
			fi ; \
			\
		" ; \
	fi
