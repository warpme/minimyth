GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

MM_BINS   := $(sort $(shell cat minimyth-bin-list   | sed 's%[ \t]*\#.*%%'))
MM_LIBS   := $(sort $(shell cat minimyth-lib-list   | sed 's%[ \t]*\#.*%%'))
MM_ETCS   := $(sort $(shell cat minimyth-etc-list   | sed 's%[ \t]*\#.*%%'))
MM_SHARES := $(sort $(shell cat minimyth-share-list | sed 's%[ \t]*\#.*%%'))

bindirs := \
	$(esbindir) \
	$(ebindir) \
	$(sbindir) \
	$(bindir) \
	$(x11bindir) \
	$(qtbindir)
libdirs := \
	$(elibdir) \
	$(libdir) \
	$(libdir)/mysql \
	$(x11libdir) \
	$(qtlibdir)

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
	ln -s /tmp/$(strip $(1)) $(mm_DESTDIR)$(strip $(1))

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
			if test -d $(DESTDIR)/$${dir} ; then \
				if test x`cd $(DESTDIR)/$${dir} ; ls -1 $${bin} 2>/dev/null` == x$${bin} ; then \
					bindir=$${dir} ; \
				fi ; \
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
		source_etc="$(DESTDIR)/$(sysconfdir)/$${etc}" ; \
		target_etc="$(mm_DESTDIR)/$(sysconfdir)/$${etc}" ; \
		if test -e $${source_etc} ; then \
			if test ! -e $${target_etc} ; then \
				cp -fa  $${source_etc} $${target_etc} ; \
			fi ; \
		else \
			echo "warning: etc \"$${etc}\" not found." ; \
		fi ; \
	done

mm-copy-shares:
	@echo 'copying shares'
	@for share in $(MM_SHARES) ; do \
		source_share="$(DESTDIR)/$(sharedstatedir)/$${share}" ; \
		target_share="$(mm_DESTDIR)/$(sharedstatedir)/$${share}" ; \
		if test -e $${source_share} ; then \
			if test ! -e $${target_share} ; then \
				cp -fa  $${source_share} $${target_share} ; \
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
	sed -i 's%@PATH@%$(call MAKE_PATH,$(bindirs))%g' $(mm_DESTDIR)$(sysconfdir)/rc
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
	$(call CONVERT_TO_LINK, $(sharedstatedir)/mythtv/mysql.txt      )
	$(call CONVERT_TO_LINK, /root/.xinitrc                          )
	ln -s $(sysconfdir)/lircrc $(mm_DESTDIR)/root/.lircrc
	ln -s $(sysconfdir)/lircrc $(mm_DESTDIR)/root/.mythtv/lircrc
	ln -s /proc/mounts $(mm_DESTDIR)/etc/mtab
