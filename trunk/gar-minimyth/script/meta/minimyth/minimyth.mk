PWD := `pwd`

WORKSRC = $(WORKDIR)/minimyth-$(mm_VERSION)

MM_BINS    := $(sort $(shell cat minimyth-bin-list   ../../extras/extras-bin-list   | sed 's%[ \t]*\#.*%%'))

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

mm_ROOTFSDIR := $(PWD)/$(WORKSRC)/rootfs.d
mm_EXTRASDIR := $(PWD)/$(WORKSRC)/extras.d

MM_LIBS    := $(sort $(shell cat minimyth-lib-list   ../../extras/extras-lib-list   | sed 's%[ \t]*\#.*%%'))
MM_ETCS    := $(sort $(shell cat minimyth-etc-list   ../../extras/extras-etc-list   | sed 's%[ \t]*\#.*%%'))
MM_SHARES  := $(sort $(shell cat minimyth-share-list ../../extras/extras-share-list | sed 's%[ \t]*\#.*%%'))

MM_REMOVES := $(sort $(shell \
	cat minimyth-remove-list $(filter-out $(patsubst %,minimyth-remove-list.%,$(mm_CHIPSETS)),$(wildcard minimyth-remove-list.*)) | \
	sed 's%[ \t]*\#.*%%'))

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
	$(libdir)/nvidia \
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

mm-all: mm-clean mm-make-busybox mm-copy mm-make-conf mm-remove mm-strip mm-make-udev mm-make-extras mm-make-initrd mm-make-distro

mm-check:
	@if [ ! "$(mm_GARCH)" = "athlon64"    ] && \
	    [ ! "$(mm_GARCH)" = "c3"          ] && \
	    [ ! "$(mm_GARCH)" = "c3-2"        ] && \
	    [ ! "$(mm_GARCH)" = "pentium-mmx" ] ; then \
		echo "error: mm_GARCH=\"$(mm_GARCH)\" is an invalid value." ; \
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
	@if [ ! "$(mm_HOME)" = "`cd $(GARDIR)/.. ; pwd`" ] ; then \
		echo "error: mm_HOME must be set to \"`cd $(GARDIR)/.. ; pwd`\" but has been set to \"$(mm_HOME)\"."; \
		exit 1 ; \
	fi
	@if [ ! -d "$(mm_TFTP_ROOT)" ] ; then \
		echo "error: the directory specified by mm_TFTP_ROOT=\"$(mm_TFTP_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_NFS)" = "yes" ] && [ ! -d "$(mm_NFS_ROOT)" ] ; then \
		echo "error: the directory specified by mm_NFS_ROOT=\"$(mm_NFS_ROOT)\" does not exist." ; \
		exit 1 ; \
	fi

mm-clean:
	@rm -rf $(mm_DESTDIR)

mm-make-busybox:
	@main_DESTDIR=$(mm_ROOTFSDIR) make -C $(GARDIR)/utils/busybox DESTIMG=$(DESTIMG) install
	@rm -rf $(mm_ROOTFSDIR)/var

mm-copy: mm-copy-kernel mm-copy-qt mm-copy-mythtv mm-copy-x11 mm-copy-bins mm-copy-etcs mm-copy-shares mm-copy-libs

mm-copy-kernel:
	@mkdir -p $(WORKSRC)
	@cp -f $(DESTDIR)$(KERNEL_DIR)/vmlinuz $(WORKSRC)/$(mm_KERNELNAME)
	@mkdir -p $(mm_ROOTFSDIR)$(elibdir)
	@cp -fa $(DESTDIR)$(elibdir)/modules $(mm_ROOTFSDIR)$(elibdir)

mm-copy-qt:
	@mkdir -p $(mm_ROOTFSDIR)$(qtprefix)/plugins
	@cp -fa $(DESTDIR)$(qtprefix)/plugins/sqldrivers   $(mm_ROOTFSDIR)$(qtprefix)/plugins

mm-copy-mythtv:
	@mkdir -p $(mm_ROOTFSDIR)$(datadir)
	@cp -fa $(DESTDIR)$(datadir)/mythtv $(mm_ROOTFSDIR)$(datadir)
	@mkdir -p $(mm_ROOTFSDIR)$(libdir)
	@cp -fa $(DESTDIR)$(libdir)/mythtv $(mm_ROOTFSDIR)$(libdir)

mm-copy-x11:
	@mkdir -p $(mm_ROOTFSDIR)$(libdir)/xorg
	@cp -fa $(DESTDIR)$(libdir)/xorg/modules        $(mm_ROOTFSDIR)$(libdir)/xorg
	@mkdir -p $(mm_ROOTFSDIR)$(libdir)/nvidia/xorg
	@cp -fa $(DESTDIR)$(libdir)/nvidia/xorg/modules $(mm_ROOTFSDIR)$(libdir)/nvidia/xorg
	@mkdir -p $(mm_ROOTFSDIR)$(prefix)/share/X11
	@cp -fa $(DESTDIR)$(prefix)/share/X11/rgb.txt $(mm_ROOTFSDIR)$(prefix)/share/X11
	@mkdir -p $(mm_ROOTFSDIR)$(libdir)/X11/fonts
	@cp -fa $(DESTDIR)$(libdir)/X11/fonts/TTF $(mm_ROOTFSDIR)$(libdir)/X11/fonts
	@cp -fa $(DESTDIR)$(libdir)/X11/fonts/misc $(mm_ROOTFSDIR)$(libdir)/X11/fonts
	@mkdir -p $(mm_ROOTFSDIR)$(libdir)/xserver
	@cp -fa $(DESTDIR)$(libdir)/xserver/SecurityPolicy $(mm_ROOTFSDIR)$(libdir)/xserver

mm-copy-bins:
	@echo 'copying binaries'
	@$(foreach dir, $(bindirs), mkdir -p $(mm_ROOTFSDIR)$(dir) ;)
	@$(foreach dir, $(libdirs), mkdir -p $(mm_ROOTFSDIR)$(dir) ;)
	@for bin in $(MM_BINS) ; do \
		bindir="" ; \
		for dir in $(bindirs) ; do \
			if test -e $(DESTDIR)/$${dir}/$${bin} ; then \
				bindir=$${dir} ; \
				break ; \
			fi ; \
		done ; \
		if test ! -z $${bindir} ; then \
			source_bin="$(DESTDIR)/$${bindir}/$${bin}" ; \
			target_bin="$(mm_ROOTFSDIR)/$${bindir}/$${bin}" ; \
			if test ! -e $${target_bin} ; then \
                                target_dir=`echo $${target_bin} | sed -e 's%/[^/]*$$%/%'` ; \
                                mkdir -p $${target_dir} ; \
				cp -fa  $${source_bin} $${target_bin} ; \
			fi ; \
		else \
			echo "warning: binary \"$${bin}\" not found." ; \
		fi ; \
	done
	@cp ./dirs/usr/bin/* $(mm_ROOTFSDIR)$(bindir)/

mm-copy-etcs:
	@echo 'copying etcs'
	@mkdir -p $(mm_ROOTFSDIR)$(sysconfdir)
	@for etc in $(MM_ETCS) ; do \
		etcdir="" ; \
		for dir in $(etcdirs) ; do \
			if test -e $(DESTDIR)/$${dir}/$${etc} ; then \
				etcdir=$${dir} ; \
				break ; \
			fi ; \
		done ; \
		if test ! -z $${etcdir} ; then \
			source_etc="$(DESTDIR)/$${etcdir}/$${etc}" ; \
			target_etc="$(mm_ROOTFSDIR)/$${etcdir}/$${etc}" ; \
			if test -e $${source_etc} ; then \
				if test ! -e $${target_etc} ; then \
                                        target_dir=`echo $${target_etc} | sed -e 's%/[^/]*$$%/%'` ; \
                                        mkdir -p $${target_dir} ; \
					cp -fa  $${source_etc} $${target_etc} ; \
				fi ; \
			fi ; \
		else \
			echo "warning: etc \"$${etc}\" not found." ; \
		fi ; \
	done

mm-copy-shares:
	@echo 'copying shares'
	@mkdir -p $(mm_ROOTFSDIR)$(sharedstatedir)
	@for share in $(MM_SHARES) ; do \
		sharedir="" ; \
		for dir in $(sharedirs) ; do \
			if test -e $(DESTDIR)/$${dir}/$${share} ; then \
				sharedir=$${dir} ; \
				break ; \
			fi ; \
		done ; \
		if test ! -z $${sharedir} ; then \
			source_share="$(DESTDIR)/$${sharedir}/$${share}" ; \
			target_share="$(mm_ROOTFSDIR)/$${sharedir}/$${share}" ; \
			if test -e $${source_share} ; then \
				if test ! -e $${target_share} ; then \
                                        target_dir=`echo $${target_share} | sed -e 's%/[^/]*$$%/%'` ; \
                                        mkdir -p $${target_dir} ; \
					cp -fa  $${source_share} $${target_share} ; \
				fi ; \
			fi ; \
		else \
			echo "warning: share \"$${share}\" not found." ; \
		fi ; \
	done

mm-copy-libs:
	@echo 'copying shared libraries'
	@$(foreach dir, $(libdirs), mkdir -p $(mm_ROOTFSDIR)$(dir) ;)
	@for lib in $(MM_LIBS) ; do \
		libdir="" ; \
		for dir in $(libdirs) ; do \
			if test -e $(DESTDIR)/$${dir}/$${lib} ; then \
				libdir=$${dir} ; \
				if test ! -z $${libdir} ; then \
					source_lib="$(DESTDIR)/$${libdir}/$${lib}" ; \
					target_lib="$(mm_ROOTFSDIR)/$${libdir}/$${lib}" ; \
					if test ! -e $${target_lib} ; then \
						if test -d $${source_lib} ; then \
                                        		target_dir=`echo $${target_lib} | sed -e 's%/[^/]*$$%/%'` ; \
                                        		mkdir -p $${target_dir} ; \
							cp -fa  $${source_lib} $${target_lib} ; \
						else \
                                        		target_dir=`echo $${target_lib} | sed -e 's%/[^/]*$$%/%'` ; \
                                        		mkdir -p $${target_dir} ; \
							cp -f  $${source_lib} $${target_lib} ; \
						fi ; \
					fi ; \
				fi ; \
			fi ; \
		done ; \
		if test -z $${libdir} ; then \
			echo "warning: library \"$${lib}\" not found." ; \
		fi ; \
	done
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
                                                			target_dir=`echo $${target_lib} | sed -e 's%/[^/]*$$%/%'` ; \
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
	@sed -i 's%@PATH@%$(call MAKE_PATH,$(bindirs))%' $(mm_ROOTFSDIR)$(sysconfdir)/conf.d/core
	@sed -i 's%@EXTRAS_ROOTDIR@%$(extras_rootdir)%'  $(mm_ROOTFSDIR)$(sysconfdir)/rc.d/init.d/extras
	@rm -f $(mm_ROOTFSDIR)$(sysconfdir)/ld.so.conf
	@$(foreach dir, $(libdirs_base), echo $(dir) >> $(mm_ROOTFSDIR)$(sysconfdir)/ld.so.conf ; )
	@rm -f $(mm_ROOTFSDIR)$(sysconfdir)/ld.so.cache{,~}
	@rm -rf $(mm_ROOTFSDIR)/root          ; cp -r ./dirs/root $(mm_ROOTFSDIR)
	@rm -rf $(mm_ROOTFSDIR)/root/.mythtv  ; mkdir -p $(mm_ROOTFSDIR)/root/.mythtv
	@rm -rf $(mm_ROOTFSDIR)/srv        ; cp -r ./dirs/srv  $(mm_ROOTFSDIR)
	@rm -rf $(mm_ROOTFSDIR)/srv/www/fs ; ln -sf / $(mm_ROOTFSDIR)/srv/www/fs
	@sed -i 's%@mm_VERSION@%$(mm_VERSION)%' $(mm_ROOTFSDIR)/srv/www/cgi-bin/functions
	@ln -sf $(sysconfdir)/lircrc $(mm_ROOTFSDIR)/root/.lircrc
	@ln -sf $(sysconfdir)/lircrc $(mm_ROOTFSDIR)/root/.mythtv/lircrc

mm-remove:
	@echo 'removing unneeded files'
	@for remove in $(addprefix $(mm_ROOTFSDIR),$(MM_REMOVES)) ; do \
		rm -rf $${remove} ; \
	done
	@depmod -b "$(mm_ROOTFSDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"

mm-strip:
	@echo 'stripping binaries and shared libraries'
	@make -s -f minimyth.mk mm-$(mm_ROOTFSDIR)/strip DESTIMG=$(DESTIMG)

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
	@# Make root file system carm image and tarball files.
	rm -rf $(WORKSRC)/$(mm_ROOTFSNAME)
	rm -rf $(WORKSRC)/$(mm_ROOTFSNAME).bz2
	rm -rf $(WORKSRC)/rootfs.d/rootfs-ro/$(rootdir)/dev
	mkdir -p $(WORKSRC)/rootfs.d/rootfs-ro/$(rootdir)/dev
	fakeroot sh -c                                                                  " \
		mknod -m 600 $(WORKSRC)/rootfs.d/rootfs-ro/$(rootdir)/dev/console c 5 1 ; \
		mknod -m 600 $(WORKSRC)/rootfs.d/rootfs-ro/$(rootdir)/dev/initctl p     ; \
		mkfs.cramfs $(WORKSRC)/rootfs.d $(WORKSRC)/$(mm_ROOTFSNAME)             ; \
		tar -C $(WORKSRC)/rootfs.d -jcf $(WORKSRC)/$(mm_ROOTFSNAME).tar.bz2 .   "
	@# Make extras cram image and tarball files.
	rm -rf $(WORKSRC)/$(mm_EXTRASNAME).cmg
	rm -rf $(WORKSRC)/$(mm_EXTRASNAME).tar.bz2
	fakeroot sh -c                                                      " \
		mkfs.cramfs $(WORKSRC)/extras.d $(WORKSRC)/$(mm_EXTRASNAME).cmg       ; \
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
	@cp -f $(mm_HOME)/docs/changelog.txt       $(WORKSRC)/distro.d/changelog.txt
	@cp -f $(mm_HOME)/docs/readme.txt          $(WORKSRC)/distro.d/readme.txt
	@cd $(WORKSRC)/distro.d ; md5sum $(mm_SOURCENAME).tar.bz2 >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum $(mm_KERNELNAME)         >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum $(mm_ROOTFSNAME)         >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum minimyth.conf            >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum changelog.txt            >> md5sums.txt
	@cd $(WORKSRC)/distro.d ; md5sum readme.txt               >> md5sums.txt

mm-install:
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
