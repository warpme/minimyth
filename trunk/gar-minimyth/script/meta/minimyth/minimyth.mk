GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

MM_BINS   := $(sort $(shell cat minimyth-bin-list   ../../extras/extras-bin-list   | sed 's%[ \t]*\#.*%%'))
MM_LIBS   := $(sort $(shell cat minimyth-lib-list   ../../extras/extras-lib-list   | sed 's%[ \t]*\#.*%%'))
MM_ETCS   := $(sort $(shell cat minimyth-etc-list   ../../extras/extras-etc-list   | sed 's%[ \t]*\#.*%%'))
MM_SHARES := $(sort $(shell cat minimyth-share-list ../../extras/extras-share-list | sed 's%[ \t]*\#.*%%'))

bindirs := \
	$(extras_sbindir) \
	$(extras_bindir) \
	$(esbindir) \
	$(ebindir) \
	$(sbindir) \
	$(bindir) \
	$(x11bindir) \
	$(qtbindir)
libdirs := \
	$(extras_libdir) \
	$(elibdir) \
	$(libdir) \
	$(libdir)/mysql \
	$(x11libdir) \
	$(qtlibdir)
etcdirs :=  \
	$(extras_sysconfdir) \
	$(sysconfdir)
sharedirs :=  \
	$(extras_sharedstatedir) \
	$(sharedstatedir)

IS_BIN = $(if $(shell file $(1) | grep -i 'ELF ..-bit LSB Shared Object'),yes,no)
IS_LIB = $(if $(shell file $(1) | grep -i 'ELF ..-bit LSB executable'   ),yes,no)

MM_PATH := $(PATH)

MM_LD_LIBRARY_PATH = $(call MAKE_PATH, /lib $(addprefix $(DESTDIR), $(libdirs)))
# This is a hack that attempts to determine the MM_LDD that will work on the system.
MM_LDD_CROSS  := $(DESTDIR)$(elibdir)/ld-linux.so.2 --list
MM_LDD_SYSTEM := $(shell which ldd)
MM_LDD_TEST = \
	$(shell \
		PATH="$(MM_PATH)" ; \
		LD_LIBRARY_PATH=$(MM_LD_LIBRARY_PATH) ; \
		$(1) $(DESTDIR)$(esbindir)/mkfs.cramfs >& /dev/null ; \
		if [ "$$?" = "0" ] ; then \
			echo "yes" ; \
		else \
			echo "no"  ; \
		fi \
	)
MM_LDD_CROSS_VALID  := $(call MM_LDD_TEST, $(MM_LDD_CROSS))
MM_LDD_SYSTEM_VALID := $(call MM_LDD_TEST, $(MM_LDD_SYSTEM))
MM_LDD := $(strip $(if $(filter $(MM_LDD_CROSS_VALID),yes),$(MM_LDD_CROSS), \
                  $(if $(filter $(MM_LDD_SYSTEM_VALID),yes),$(MM_LDD_SYSTEM),)))

MAKE_PATH = \
	$(patsubst @%@,%,$(subst @ @,:, $(strip $(patsubst %,@%@,$(1)))))

LIST_FILES = \
	$(strip $(sort $(foreach dir, $(2), $(shell cd $(strip $(1))$(dir) ; ls -1) )))
LIST_LIBS = \
	$(filter-out \
		$(call LIST_FILES, $(mm_DESTDIR), $(libdirs)), \
		$(shell PATH="$(MM_PATH)" ; LD_LIBRARY_PATH=$(MM_LD_LIBRARY_PATH) ; $(MM_LDD) $(1) 2>/dev/null \
			| grep ' => ' \
			| sed 's%^[ \t]*%%' \
			| sed 's%[ \t].*%%' \
			| sed 's%.*/%%' \
                        | sed 's%linux-gate\.so\.1%%' \
		) \
	)


mm-all: mm-check mm-clean mm-make-conf mm-make-busybox mm-copy mm-strip mm-make-udev mm-make-extras

mm-check:
	@if [ ! "$(mm_GARCH)" = "c3" ] && [ ! "$(mm_GARCH)" = "c3-2" ] && [ ! "$(mm_GARCH)" = "pentium-mmx" ] ; then \
		echo "error: mm_GARCH is set to an invalid value." ; \
		exit 1 ; \
	fi
	@if [ ! "$(mm_INSTALL_CRAMFS)" = "yes" ] && [ ! "$(mm_INSTALL_CRAMFS)" = "no" ] ; then \
		echo "error: mm_INSTALL_CRAMFS is set to an invalid value." ; \
		exit 1 ; \
	fi
	@if [ ! "$(mm_INSTALL_NFS)" = "yes" ] && [ ! "$(mm_INSTALL_NFS)" = "no" ] ; then \
		echo "error: mm_INSTALL_NFS is set to an invalid value." ; \
		exit 1 ; \
	fi
	@if [ ! "$(mm_HOME)" = "`cd $(GARDIR)/.. ; pwd`" ] ; then \
		echo "error: mm_HOME must be set to \"`cd $(GARDIR)/.. ; pwd`\"." ; \
		exit 1 ; \
	fi
	@if [ ! -d "$(mm_TFTP_ROOT)" ] ; then \
		echo "error: the directory specified by mm_TFTP_ROOT does not exist." ; \
		exit 1 ; \
	fi
	@if [ "$(mm_INSTALL_NFS)" = "yes" ] && [ ! -d "$(mm_NFS_ROOT)" ] ; then \
		echo "error: the directory specified by mm_NFS_ROOT does not exist." ; \
		exit 1 ; \
	fi
	@if [ "$(MM_LDD)" = "" ] ; then \
		echo "error: no working ldd command for determining libraries." ; \
		exit 1 ; \
	fi

mm-clean:
	@rm -rf $(mm_BASEDIR)

mm-make-conf:
	@mkdir -p $(mm_DESTDIR)$(sysconfdir)
	@rm -rf $(mm_BASEDIR)/$(mm_KERNELNAME) ; cp -f $(DESTDIR)$(KERNEL_DIR)/vmlinuz $(mm_BASEDIR)/$(mm_KERNELNAME)
	@cp -r ./dirs/etc/* $(mm_DESTDIR)$(sysconfdir)
	@sed -i 's%@PATH@%$(call MAKE_PATH,$(bindirs))%' $(mm_DESTDIR)$(sysconfdir)/minimyth.d/env.conf
	@sed -i 's%@EXTRAS_ROOTDIR@%$(extras_rootdir)%'  $(mm_DESTDIR)/$(sysconfdir)/minimyth.d/extras.script
	@rm -f $(mm_DESTDIR)$(sysconfdir)/ld.so.conf
	@$(foreach dir, $(libdirs), echo $(dir) >> $(mm_DESTDIR)$(sysconfdir)/ld.so.conf ; )
	@rm -f $(mm_DESTDIR)$(sysconfdir)/ld.so.cache{,~}
	@rm -rf $(mm_DESTDIR)/root          ; cp -r ./dirs/root $(mm_DESTDIR)
	@rm -rf $(mm_DESTDIR)/root/.mplayer ; mkdir -p $(mm_DESTDIR)/root/.mplayer
	@rm -rf $(mm_DESTDIR)/root/.mythtv  ; mkdir -p $(mm_DESTDIR)/root/.mythtv
	@rm -rf $(mm_DESTDIR)/srv        ; cp -r ./dirs/srv  $(mm_DESTDIR)
	@rm -rf $(mm_DESTDIR)/srv/www/fs ; ln -s / $(mm_DESTDIR)/srv/www/fs
	@sed -i 's%@mm_VERSION@%$(mm_VERSION)%' $(mm_DESTDIR)/srv/www/cgi/functions
	@ln -s $(sysconfdir)/lircrc $(mm_DESTDIR)/root/.lircrc
	@ln -s $(sysconfdir)/lircrc $(mm_DESTDIR)/root/.mythtv/lircrc
	@ln -s $(x11libdir)/X11/fonts/TTF/luxisr.ttf $(mm_DESTDIR)/root/.mplayer/subfont.ttf
	@ln -s /proc/mounts $(mm_DESTDIR)/etc/mtab

mm-make-busybox:
	@main_DESTDIR=$(mm_DESTDIR) make -C $(GARDIR)/utils/busybox DESTIMG=$(DESTIMG) install

mm-copy: mm-copy-kernel mm-copy-qt mm-copy-mythtv mm-copy-x11 mm-copy-bins mm-copy-etcs mm-copy-shares mm-copy-libs

mm-copy-kernel:
	@mkdir -p $(mm_DESTDIR)$(elibdir)
	@cp -fa $(DESTDIR)$(elibdir)/modules $(mm_DESTDIR)$(elibdir)

mm-copy-qt:
	@mkdir -p $(mm_DESTDIR)$(qtprefix)/plugins
	@cp -fa $(DESTDIR)$(qtprefix)/plugins/sqldrivers   $(mm_DESTDIR)$(qtprefix)/plugins

mm-copy-mythtv:
	@mkdir -p $(mm_DESTDIR)$(datadir)
	@cp -fa $(DESTDIR)$(datadir)/mythtv $(mm_DESTDIR)$(datadir)
	@mkdir -p $(mm_DESTDIR)$(libdir)
	@cp -fa $(DESTDIR)$(libdir)/mythtv $(mm_DESTDIR)$(libdir)

mm-copy-x11:
	@mkdir -p $(mm_DESTDIR)$(x11bindir)
	@mkdir -p $(mm_DESTDIR)$(x11libdir)
	@cp -fa $(DESTDIR)$(x11libdir)/modules $(mm_DESTDIR)$(x11libdir)
	@mkdir -p $(mm_DESTDIR)$(x11libdir)/X11
	@cp -fa $(DESTDIR)$(x11libdir)/X11/fonts   $(mm_DESTDIR)$(x11libdir)/X11
	@cp -fa $(DESTDIR)$(x11libdir)/X11/rgb.txt $(mm_DESTDIR)$(x11libdir)/X11
	@mkdir -p $(mm_DESTDIR)$(x11libdir)/X11/xserver
	@cp -fa $(DESTDIR)$(x11libdir)/X11/xserver/SecurityPolicy $(mm_DESTDIR)$(x11libdir)/X11/xserver

mm-copy-bins:
	@echo 'copying binaries'
	@$(foreach dir, $(bindirs), mkdir -p $(mm_DESTDIR)$(dir) ;)
	@$(foreach dir, $(libdirs), mkdir -p $(mm_DESTDIR)$(dir) ;)
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
			target_bin="$(mm_DESTDIR)/$${bindir}/$${bin}" ; \
			if test ! -e $${target_bin} ; then \
                                target_dir=`echo $${target_bin} | sed -e 's%/[^/]*$$%/%'` ; \
                                mkdir -p $${target_dir} ; \
				cp -fa  $${source_bin} $${target_bin} ; \
				make -s -f minimyth.mk mm-$${target_bin}/copy-libs DESTIMG=$(DESTIMG) ; \
			fi ; \
		else \
			echo "warning: binary \"$${bin}\" not found." ; \
		fi ; \
	done

mm-copy-etcs:
	@echo 'copying etcs'
	@mkdir -p $(mm_DESTDIR)$(sysconfdir)
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
			target_etc="$(mm_DESTDIR)/$${etcdir}/$${etc}" ; \
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
	@mkdir -p $(mm_DESTDIR)$(sharedstatedir)
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
			target_share="$(mm_DESTDIR)/$${sharedir}/$${share}" ; \
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
	@$(foreach dir, $(libdirs), mkdir -p $(mm_DESTDIR)$(dir) ;)
	@for lib in $(MM_LIBS) ; do \
		libdir="" ; \
		for dir in $(libdirs) ; do \
			if test -e $(DESTDIR)/$${dir}/$${lib} ; then \
				libdir=$${dir} ; \
				break; \
			fi ; \
		done ; \
		if test ! -z $${libdir} ; then \
			source_lib="$(DESTDIR)/$${libdir}/$${lib}" ; \
			target_lib="$(mm_DESTDIR)/$${libdir}/$${lib}" ; \
			if test ! -e $${target_lib} ; then \
				if test -d $${source_lib} ; then \
                                        target_dir=`echo $${target_lib} | sed -e 's%/[^/]*$$%/%'` ; \
                                        mkdir -p $${target_dir} ; \
					cp -fa  $${source_lib} $${target_lib} ; \
				else \
                                        target_dir=`echo $${target_lib} | sed -e 's%/[^/]*$$%/%'` ; \
                                        mkdir -p $${target_dir} ; \
					cp -f  $${source_lib} $${target_lib} ; \
					make -s -f minimyth.mk mm-$${target_lib}/copy-libs DESTIMG=$(DESTIMG) ; \
				fi ; \
			fi ; \
		else \
			echo "warning: library \"$${lib}\" not found." ; \
		fi ; \
	done
	@make -s -f minimyth.mk mm-$(mm_DESTDIR)/copy-libs DESTIMG=$(DESTIMG)

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
						fi ; \
					fi ; \
				done ; \
				if test ! -z $${libdir} ; then \
					source_lib="$(DESTDIR)/$${libdir}/$${lib}" ; \
					target_lib="$(mm_DESTDIR)/$${libdir}/$${lib}" ; \
					if test ! -e $${target_lib} ; then \
                                                target_dir=`echo $${target_lib} | sed -e 's%/[^/]*$$%/%'` ; \
                                                mkdir -p $${target_dir} ; \
						cp -f  $${source_lib} $${target_lib} ; \
						make -s -f minimyth.mk mm-$${target_lib}/copy-libs DESTIMG=$(DESTIMG) ; \
					fi ; \
				else \
					echo "warning: library \"$${lib}\" not found." ; \
				fi ; \
			done ; \
		fi ; \
	fi

mm-strip:
	@echo 'stripping binaries and shared libraries'
	@make -s -f minimyth.mk mm-$(mm_DESTDIR)/strip DESTIMG=$(DESTIMG)

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
	$(foreach file, $(shell cd ./dirs ; ls -1 udev/scripts.d/*    ), install -m 755 -D ./dirs/$(file) $(mm_DESTDIR)$(sysconfdir)/$(file) ; )
	$(foreach file, $(shell cd ./dirs ; ls -1 udev/rules.d/*.rules), install -m 644 -D ./dirs/$(file) $(mm_DESTDIR)$(sysconfdir)/$(file) ; )

mm-make-extras:
	@rm -rf $(mm_EXTRASDIR) ; mkdir -p $(mm_EXTRASDIR)
	@mv $(mm_DESTDIR)/$(extras_rootdir)/* $(mm_EXTRASDIR)
	@rm -rf $(mm_DESTDIR)/$(extras_rootdir) ; mkdir -p $(mm_DESTDIR)/$(extras_rootdir)
	@cp -f ./dirs/usr/bin/* $(mm_DESTDIR)$(bindir)

mm-install:
	@su -c "[ -e $(mm_DESTDIR).tmp   ] && rm -rf $(mm_DESTDIR).tmp   ; \
		[ -e $(mm_EXTRASDIR).tmp ] && rm -rf $(mm_EXTRASDIR).tmp ; \
		mkdir -p $(mm_DESTDIR).tmp ; \
		cp -a $(mm_DESTDIR) $(mm_DESTDIR).tmp/rootfs-ro ; \
		rm -f $(mm_TFTPDIR)/$(mm_KERNELNAME) ; \
			mkdir -p $(mm_TFTPDIR) ; \
			cp $(mm_BASEDIR)/$(mm_KERNELNAME) $(mm_TFTPDIR)/$(mm_KERNELNAME) ; \
		chown -Rh root:root $(mm_DESTDIR).tmp ; \
		mkdir $(mm_DESTDIR).tmp/rootfs-ro/$(rootdir)/dev ; \
		mknod -m 666 $(mm_DESTDIR).tmp/rootfs-ro/$(rootdir)/dev/null c 1 3 ; \
		mknod -m 600 $(mm_DESTDIR).tmp/rootfs-ro/$(rootdir)/dev/console c 5 1 ; \
		cp -r ./dirs/initrd/etc $(mm_DESTDIR).tmp/ ; \
		ln -s rootfs-ro/bin  $(mm_DESTDIR).tmp/bin  ; \
		ln -s rootfs-ro/lib  $(mm_DESTDIR).tmp/lib  ; \
		ln -s rootfs-ro/sbin $(mm_DESTDIR).tmp/sbin ; \
		cp -dr $(mm_DESTDIR).tmp/rootfs-ro/dev     $(mm_DESTDIR).tmp/ ; \
		cp -dr $(mm_DESTDIR).tmp/rootfs-ro/linuxrc $(mm_DESTDIR).tmp/ ; \
		mkdir -p $(mm_DESTDIR).tmp/rootfs-rw ; \
		mkdir -p $(mm_DESTDIR).tmp/rootfs ; \
		cp -a $(mm_EXTRASDIR) $(mm_EXTRASDIR).tmp ; \
		chown -Rh root:root $(mm_EXTRASDIR).tmp ; \
		if [ $(mm_INSTALL_CRAMFS) = yes ] ; then \
			mkfs.cramfs $(mm_DESTDIR).tmp $(mm_BASEDIR)/$(mm_CRAMFSNAME) ; \
			rm -f $(mm_TFTPDIR)/$(mm_CRAMFSNAME) ; \
				mkdir -p $(mm_TFTPDIR) ; \
				cp $(mm_BASEDIR)/$(mm_CRAMFSNAME) $(mm_TFTPDIR)/$(mm_CRAMFSNAME) ; \
			cd $(mm_EXTRASDIR).tmp ; tar -jcf $(mm_BASEDIR)/$(mm_EXTRASNAME) * ; \
			rm -f $(mm_TFTPDIR)/$(mm_EXTRASNAME) ; \
				mkdir -p $(mm_TFTPDIR) ; \
				cp $(mm_BASEDIR)/$(mm_EXTRASNAME) $(mm_TFTPDIR)/$(mm_EXTRASNAME) ; \
		fi ; \
		if [ $(mm_INSTALL_NFS) = yes ] ; then \
			rm -rf $(mm_NFSDIR)/$(mm_NFSNAME) ; \
				mkdir -p $(mm_NFSDIR) ; \
				cp -a $(mm_DESTDIR).tmp $(mm_NFSDIR)/$(mm_NFSNAME) ; \
			cp -a $(mm_EXTRASDIR).tmp/* $(mm_NFSDIR)/$(mm_NFSNAME)/rootfs-ro/$(extras_rootdir) ; \
		fi ; \
		rm -rf $(mm_DESTDIR).tmp ; \
		rm -rf $(mm_EXTRASDIR).tmp"
