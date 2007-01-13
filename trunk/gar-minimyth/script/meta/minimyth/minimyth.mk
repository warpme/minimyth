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
# This is a hack.
MM_LDD = $(DESTDIR)$(elibdir)/ld-linux.so.2 --list

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
		) \
	)
CONVERT_TO_LINK = \
	test -e $(mm_DESTDIR)/$(strip $(1)) && mv $(mm_DESTDIR)/$(strip $(1)) $(mm_DESTDIR)/$(strip $(1)).default ; \
	ln -sf /tmp/$(strip $(1)) $(mm_DESTDIR)$(strip $(1))

mm-all: mm-clean mm-make-busybox mm-make-dirs mm-copy mm-strip mm-conf
#mm-all: mm-clean mm-make-busybox mm-make-dirs mm-copy mm-conf

mm-clean:
	@rm -rf $(mm_BASEDIR)

mm-make-dirs:
	@mkdir -p $(mm_DESTDIR)
	@$(foreach dir, $(bindirs), mkdir -p $(mm_DESTDIR)$(dir) ;)
	@$(foreach dir, $(libdirs), mkdir -p $(mm_DESTDIR)$(dir) ;)
	@mkdir -p $(mm_DESTDIR)$(sysconfdir)
	@mkdir -p $(mm_DESTDIR)$(sharedstatedir)
	@mkdir -p $(mm_DESTDIR)$(localstatedir)
	@mkdir -p $(mm_DESTDIR)/dev
	@mkdir -p $(mm_DESTDIR)/mnt
	@mkdir -p $(mm_DESTDIR)/proc
	@mkdir -p $(mm_DESTDIR)/sys
	@mkdir -p $(mm_DESTDIR)/tmp

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

mm-copy-bins:
	@echo 'copying binaries'
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
				cp -fa  $${source_bin} $${target_bin} ; \
				make -s -f minimyth.mk mm-$${target_bin}/copy-libs DESTIMG=$(DESTIMG) ; \
			fi ; \
		else \
			echo "warning: binary \"$${bin}\" not found." ; \
		fi ; \
	done

mm-copy-etcs:
	@echo 'copying etcs'
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
					cp -fa  $${source_etc} $${target_etc} ; \
				fi ; \
			fi ; \
		else \
			echo "warning: etc \"$${etc}\" not found." ; \
		fi ; \
	done

mm-copy-shares:
	@echo 'copying shares'
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
					cp -fa  $${source_share} $${target_share} ; \
				fi ; \
			fi ; \
		else \
			echo "warning: share \"$${share}\" not found." ; \
		fi ; \
	done

mm-copy-libs:
	@echo 'copying shared libraries'
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
				cp -f  $${source_lib} $${target_lib} ; \
				make -s -f minimyth.mk mm-$${target_lib}/copy-libs DESTIMG=$(DESTIMG) ; \
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

mm-conf:
	rm -rf $(mm_BASEDIR)/$(mm_KERNELNAME) ; cp -f $(DESTDIR)$(KERNEL_DIR)/vmlinuz $(mm_BASEDIR)/$(mm_KERNELNAME)
	cp -r ./dirs/etc/* $(mm_DESTDIR)$(sysconfdir)
	sed -i 's%@PATH@%$(call MAKE_PATH,$(bindirs))%' $(mm_DESTDIR)$(sysconfdir)/minimyth.d/env.script
	sed -i 's%@EXTRAS_ROOTDIR@%$(extras_rootdir)%'  $(mm_DESTDIR)/$(sysconfdir)/minimyth.d/extras.script
	rm -f $(mm_DESTDIR)$(sysconfdir)/ld.so.conf
	$(foreach dir, $(libdirs), echo $(dir) >> $(mm_DESTDIR)$(sysconfdir)/ld.so.conf ; )
	rm -f $(mm_DESTDIR)$(sysconfdir)/ld.so.cache{,~}
	rm -rf $(mm_DESTDIR)/root ; cp -r ./dirs/root $(mm_DESTDIR)
	rm -rf $(mm_DESTDIR)/root/.mplayer 
	mkdir -p $(mm_DESTDIR)/root/.mplayer
	mkdir -p $(mm_DESTDIR)/root/.mythtv
	ln -s $(x11libdir)/X11/fonts/TTF/luxisr.ttf $(mm_DESTDIR)/root/.mplayer/subfont.ttf
	sed -i 's%@mm_NAME_PRETTY@%$(mm_NAME_PRETTY)%' $(mm_DESTDIR)/etc/www/cgi/status.cgi
	$(call CONVERT_TO_LINK, $(sysconfdir)/ld.so.cache               )
	$(call CONVERT_TO_LINK, $(sysconfdir)/lircd.conf                )
	$(call CONVERT_TO_LINK, $(sysconfdir)/lircrc                    )
	$(call CONVERT_TO_LINK, $(sysconfdir)/localtime                 )
	$(call CONVERT_TO_LINK, $(sysconfdir)/ntp.conf                  )
	$(call CONVERT_TO_LINK, $(sysconfdir)/resolv.conf               )
	$(call CONVERT_TO_LINK, $(sysconfdir)/minimyth.d/dhcp.conf      )
	$(call CONVERT_TO_LINK, $(sysconfdir)/minimyth.d/loadmods.script)
	$(call CONVERT_TO_LINK, $(sysconfdir)/minimyth.d/minimyth.conf  )
	$(call CONVERT_TO_LINK, $(sysconfdir)/minimyth.d/minimyth.script)
	$(call CONVERT_TO_LINK, $(sysconfdir)/X11/xorg.conf             )
	$(call CONVERT_TO_LINK, /root/.mythtv/mysql.txt                 )
	$(call CONVERT_TO_LINK, /root/.xinitrc                          )
	ln -s $(sysconfdir)/lircrc $(mm_DESTDIR)/root/.lircrc
	ln -s $(sysconfdir)/lircrc $(mm_DESTDIR)/root/.mythtv/lircrc
	ln -s /proc/mounts $(mm_DESTDIR)/etc/mtab
	rm -rf $(mm_EXTRASDIR) ; mkdir -p $(mm_EXTRASDIR)
	mv $(mm_DESTDIR)/$(extras_rootdir)/* $(mm_EXTRASDIR)
	rm -rf $(mm_DESTDIR)/$(extras_rootdir) ; mkdir -p $(mm_DESTDIR)/$(extras_rootdir)

mm-install:
	@su -c "cp -a $(mm_DESTDIR) $(mm_DESTDIR).tmp ; \
		rm -f $(mm_TFTPDIR)/$(mm_KERNELNAME) ; \
			cp $(mm_BASEDIR)/$(mm_KERNELNAME) $(mm_TFTPDIR)/$(mm_KERNELNAME) ; \
		chown -Rh root:root $(mm_DESTDIR).tmp ; \
		mknod -m 666 $(mm_DESTDIR).tmp/$(rootdir)/dev/null c 1 3 ; \
		mknod -m 600 $(mm_DESTDIR).tmp/$(rootdir)/dev/console c 5 1 ; \
		cp -a $(mm_EXTRASDIR) $(mm_EXTRASDIR).tmp ; \
		chown -Rh root:root $(mm_EXTRASDIR).tmp ; \
		if [ $(mm_INSTALL_CRAMFS) = yes ] ; then \
			mkfs.cramfs $(mm_DESTDIR).tmp $(mm_BASEDIR)/$(mm_CRAMFSNAME) ; \
			rm -f $(mm_TFTPDIR)/$(mm_CRAMFSNAME) ; \
				cp $(mm_BASEDIR)/$(mm_CRAMFSNAME) $(mm_TFTPDIR)/$(mm_CRAMFSNAME) ; \
			cd $(mm_EXTRASDIR).tmp ; tar -jc -f $(mm_BASEDIR)/$(mm_EXTRASNAME) * ; \
			rm -f $(mm_TFTPDIR)/$(mm_EXTRASNAME) ; \
				cp $(mm_BASEDIR)/$(mm_EXTRASNAME) $(mm_TFTPDIR)/$(mm_EXTRASNAME) ; \
		fi ; \
		if [ $(mm_INSTALL_NFS) = yes ] ; then \
			rm -rf $(mm_NFSDIR)/$(mm_NFSNAME) ; \
				cp -a $(mm_DESTDIR).tmp $(mm_NFSDIR)/$(mm_NFSNAME) ; \
			cp -a $(mm_EXTRASDIR).tmp/* $(mm_NFSDIR)/$(mm_NFSNAME)/$(extras_rootdir) ; \
		fi ; \
		rm -rf $(mm_DESTDIR).tmp ; \
		rm -rf $(mm_EXTRASDIR).tmp"
