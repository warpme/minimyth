top        = ../
top_source = ./
top_build  = ../build/

top        := $(shell cd $(top)        ; pwd)
top_source := $(shell cd $(top_source) ; pwd)
top_build  := $(shell cd $(top_build)  ; pwd)

cookiedir  := $(top_build)/cookie

include $(top_build)/config.mk

mm_NAME := minimyth-$(mm_VERSION)

MM_LIST_FILES    = $(strip \
	$(if $(wildcard lists/minimyth-$(strip $(1))-list), \
                        lists/minimyth-$(strip $(1))-list ) \
	$(if $(wildcard lists/extras/extras-$(strip $(1))-list), \
                        lists/extras/extras-$(strip $(1))-list ) \
	$(filter $(patsubst %,lists/graphics/minimyth-$(strip $(1))-list.%,$(mm_GRAPHICS)), \
                 $(wildcard   lists/graphics/minimyth-$(strip $(1))-list.*               )) \
	$(filter $(patsubst %,lists/software/minimyth-$(strip $(1))-list.%,$(mm_SOFTWARE)), \
                 $(wildcard   lists/software/minimyth-$(strip $(1))-list.*               )) \
	$(filter $(patsubst %,lists/software/minimyth-$(strip $(1))-list.%:$(mm_MYTH_VERSION),$(mm_SOFTWARE)), \
                 $(wildcard   lists/software/minimyth-$(strip $(1))-list.*:$(mm_MYTH_VERSION)              )))
MM_BIN_FILES    := $(call MM_LIST_FILES, bin)
MM_LIB_FILES    := $(call MM_LIST_FILES, lib)
MM_ETC_FILES    := $(call MM_LIST_FILES, etc)
MM_SHARE_FILES  := $(call MM_LIST_FILES, share)
MM_REMOVE_FILES := $(call MM_LIST_FILES, remove)

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

MAKE_PATH = \
	$(patsubst @%@,%,$(subst @ @,:, $(strip $(patsubst %,@%@,$(1)))))

DIRSTODOTS = \
	$(subst . /,./,$(patsubst %,/..,$(subst /, ,/$(1))))

# $1 = file type label plural.
# $2 = file type label singular.
# $3 = source destdir.
# $4 = target destdir.
# $5 = file directories.
# $6 = files.
COPY_FILES = \
	echo "copying $(strip $(1))" ; \
	for dir in $(strip $(5)) ; do \
		mkdir -p $(strip $(4))/$${dir} ; \
	done ; \
	for file_item in $(strip $(6)) ; do \
		found="" ; \
		for dir in $(strip $(5)) ; do \
			file_list="" ; \
			if [ -e $(3)/$${dir} ] ; then \
				if echo $${file_item} | grep -q -e '/$$' > /dev/null 2>&1 ; then \
					file_list=`cd $(3)/$${dir} ; find -L $${file_item} -maxdepth 0 -type d 2> /dev/null` ; \
				else \
					file_list=`cd $(3)/$${dir} ; find -L $${file_item} -maxdepth 0 -type f 2> /dev/null` ; \
				fi; \
			fi ; \
			for file in $${file_list} ; do \
				if [ -e $(3)/$${dir}/$${file} ] ; then \
					found="true" ; \
					source_file="$(3)/$${dir}/$${file}" ; \
					target_file="$(strip $(4))/$${dir}/$${file}" ; \
					if [ ! -e $${target_file} ] ; then \
						cp_flags=""                ; \
						cp_flags="$${cp_flags} -p" ; \
						file -L $${source_file} | grep -i -q 'ELF ..-bit LSB shared object' ; \
						if [ $$? -ne 0 ] ; then \
							cp_flags="$${cp_flags} -d" ; \
						fi ; \
						if [ -d $${source_file} ] ; then \
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
							if [ ! -e $${source_file} ] ; then \
								echo "error: $${source_file} not found." ; \
								exit 1 ; \
							fi ; \
							if [ ! -e $${target_file} ] ; then \
								target_dir=`dirname $${target_file}` ; \
								mkdir -p $${target_dir} ; \
								cp $${cp_flags} $${source_file} $${target_file} ; \
								chmod -R u+w $${target_file} ; \
							fi ; \
						done ; \
						chmod -R u+w $${target_file} ; \
					fi ; \
				fi ; \
			done ; \
		done ; \
		if [ -z $${found} ] ; then \
			echo "copying $(strip $(1)): warning: $(strip $(2)) \"$${file_item}\" not found." ; \
		fi ; \
	done

# $1 = file/directory
SET_PERMISSIONS = \
	chmod -R -s   $(strip $(1))                                                   ; \
	chmod -R -t   $(strip $(1))                                                   ; \
	chmod -R +r   $(strip $(1))                                                   ; \
	chmod -R u+w  $(strip $(1))                                                   ; \
	chmod -R go-w $(strip $(1))                                                   ; \
	find          $(strip $(1)) -depth -type d             -exec chmod +x '{}' \; ; \
	find          $(strip $(1)) -depth -type f -perm /0100 -exec chmod +x '{}' \;

all: build

build: \
	$(if $(filter yes,$(mm_DISTRIBUTION_LOCAL)),$(top_build)/local) \
	$(if $(filter yes,$(mm_DISTRIBUTION_SHARE)),$(top_build)/share)

$(top_build)/image/rootfs: $(build_DESTDIR)$(build_rootdir) $(DESTDIR)$(rootdir) $(top_source) $(top_build)/stage/gar-$(mm_NAME).tar.bz2
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@# Make home directory for user 'root'.
	@mkdir -p $@~/root
	@# Copy source.
	@mkdir -p $@~$(sourcedir)
	@cp -pdR $(top_build)/stage/gar-$(mm_NAME).tar.bz2 $@~$(sourcedir)/gar-$(mm_NAME).tar.bz2
	@# Copy versions.
	@mkdir -p $@~$(versiondir)-build
	@cp -pdR $(build_DESTDIR)$(build_versiondir)/* $@~$(versiondir)-build
	@mkdir -p $@~$(versiondir)
	@cp -pdR $(DESTDIR)$(versiondir)/* $@~$(versiondir)
	@rm -rf $@~$(versiondir)/minimyth
	@mkdir -p $@~$(extras_versiondir)
	@cp -pdR $(DESTDIR)$(extras_versiondir)/* $@~$(extras_versiondir)
	@# Copy licenses.
	@mkdir -p $@~$(licensedir)-build
	@cp -pdR $(build_DESTDIR)$(build_licensedir)/* $@~$(licensedir)-build
	@mkdir -p $@~$(licensedir)
	@cp -pdR $(DESTDIR)$(licensedir)/* $@~$(licensedir)
	@rm -rf $@~$(licensedir)/minimyth
	@mkdir -p $@~$(extras_licensedir)
	@cp -pdR $(DESTDIR)$(extras_licensedir)/* $@~$(extras_licensedir)
	@# Install busybox.
	@echo "installing busybox"
	@main_DESTDIR=$@~ $(MAKE) -C $(mm_HOME)/script/utils/busybox DESTIMG=$(DESTIMG) install
	@rm -rf $@~/var
	@# Copy binaries.
	@$(call COPY_FILES, "binaries", "binary", $(DESTDIR), $@~, $(bindirs), $(MM_BINS))
	@# Copy etcs.
	@$(call COPY_FILES, "etcs", "etc", $(DESTDIR), $@~, $(etcdirs), $(MM_ETCS))
	@# Copy libraries.
	@$(call COPY_FILES, "libraries", "library", $(DESTDIR), $@~, $(libdirs), $(MM_LIBS))
	@# Copy shares.
	@$(call COPY_FILES, "shares", "share", $(DESTDIR), $@~, $(sharedirs), $(MM_SHARES))
	@# Copy the QT plugins needed by MythTV.
	@rm -rf   $@~$(qt4prefix)/plugins
	@mkdir -p $@~$(qt4prefix)/plugins
	@cp -pdR $(DESTDIR)$(qt4prefix)/plugins/graphicssystems $@~$(qt4prefix)/plugins
	@cp -pdR $(DESTDIR)$(qt4prefix)/plugins/iconengines     $@~$(qt4prefix)/plugins
	@cp -pdR $(DESTDIR)$(qt4prefix)/plugins/imageformats    $@~$(qt4prefix)/plugins
	@cp -pdR $(DESTDIR)$(qt4prefix)/plugins/sqldrivers      $@~$(qt4prefix)/plugins
	@# Copy HTML files.
	@find $(top_source)/html -depth -type d \
		| sed -e 's%^\$(top_source)/html%$@~/srv/www%' \
		| xargs -n 1 mkdir -m 0755 -p
	@find $(top_source)/html -depth -type f \
		| sed -e 's%^\(\$(top_source)/html\)/\(.*\)$$%\1/\2 $@~/srv/www/\2%' \
		| xargs -n 2 cp -fpd
	@rm -rf $@~/srv/www/download
	@rm -rf $@~/srv/www/error
	@rm -rf $@~/srv/www/robots.txt
	@# Copy package rootfs files.
	@find $(top_source)/rootfs -depth -type d \
		| sed -e 's%^\$(top_source)/rootfs%$@~%' \
		| xargs -n 1 mkdir -m 0755 -p
	@find $(top_source)/rootfs -depth -type f \
		| sed -e 's%^\(\$(top_source)/rootfs\)/\(.*\)$$%\1/\2 $@~/\2%' \
		| xargs -n 2 cp -fpd
	@# Copy mm_local scripts.
	@cp  -pd $(top_source)/mm_local/mm_local_update $@~/usr/bin/mm_local_update
	@chmod 0755 $@~/usr/bin/mm_local_update
	@cp  -pd $(top_source)/mm_local/mm_local_helper $@~/usr/bin/mm_local_helper_old
	@# Substitute values for variables in files
	@sed -i 's%@MM_VERSION@%$(mm_VERSION)%g'                   $@~$(sysconfdir)/conf.d/core
	@sed -i 's%@MM_VERSION_MYTH@%$(mm_VERSION_MYTH)%g'         $@~$(sysconfdir)/conf.d/core
	@sed -i 's%@MM_VERSION_MINIMYTH@%$(mm_VERSION_MINIMYTH)%g' $@~$(sysconfdir)/conf.d/core
	@sed -i 's%@MM_CONF_VERSION@%$(mm_CONF_VERSION)%g'         $@~$(sysconfdir)/conf.d/core
	@sed -i 's%@PATH@%$(call MAKE_PATH,$(bindirs_base))%g'     $@~$(sysconfdir)/conf.d/core
	@sed -i 's%@GAR_datadir@%$(datadir)%g'                     $@~$(sysconfdir)/fonts/local.conf
	@sed -i 's%@EXTRAS_ROOTDIR@%$(extras_rootdir)%'            $@~$(sysconfdir)/rc.d/init/extras.pm
	@# Create the minimyth build configuration file.
	@rm -rf   $@~$(versiondir)/minimyth.conf.mk
	@mkdir -m 0755 -p $@~$(versiondir)
	@$(foreach build_var,$(build_vars), \
		echo "$(build_var)='$(strip $($(build_var)))'" >> $@~$(versiondir)/minimyth.conf.mk ; )
	@# Create the loader configuration file.
	@rm -f $@~$(sysconfdir)/ld.so.conf
	@$(foreach dir, $(libdirs_base), \
		echo $(dir) >> $@~$(sysconfdir)/ld.so.conf ; )
	@rm -f $@~$(sysconfdir)/ld.so.cache{,~}
	@# Make documentation links.
	@mkdir -m 0755 -p $@~/srv/www/software
	@ln -sf $(patsubst /%,%,$(call DIRSTODOTS,/srv/www/software))$(sourcedir)/gar-$(mm_NAME).tar.bz2 \
		$@~/srv/www/software/gar-$(mm_NAME).tar.bz2
	@mkdir -m 0755 -p $@~/srv/www/software/base
	@ln -sf $(patsubst /%,%,$(call DIRSTODOTS,/srv/www/software/base))$(versiondir) \
	        $@~/srv/www/software/base/versions
	@ln -sf $(patsubst /%,%,$(call DIRSTODOTS,/srv/www/software/base))$(licensedir) \
	        $@~/srv/www/software/base/licenses
	@mkdir -m 0755 -p $@~/srv/www/software/extras
	@ln -sf $(patsubst /%,%,$(call DIRSTODOTS,/srv/www/software/extras))$(extras_versiondir) \
	        $@~/srv/www/software/extras/versions
	@ln -sf $(patsubst /%,%,$(call DIRSTODOTS,/srv/www/software/extras))$(extras_licensedir) \
	        $@~/srv/www/software/extras/licenses
	@mkdir -m 0755 -p $@~/srv/www/software/build
	@ln -sf $(patsubst /%,%,$(call DIRSTODOTS,/srv/www/software/versions))$(versiondir)-build \
	        $@~/srv/www/software/build/versions
	@ln -sf $(patsubst /%,%,$(call DIRSTODOTS,/srv/www/software/versions))$(licensedir)-build \
	        $@~/srv/www/software/build/licenses
	@# Make user 'minimyth' configuration links.
	@mkdir -m 0755 -p $@~/home/minimyth
	@ln -sf $(patsubst /%,%,$(call DIRSTODOTS,/home/minimyth))$(sysconfdir)/lirc/lircrc \
	        $@~/home/minimyth/.lircrc
	@mkdir -m 0755 -p $@~/home/minimyth/.mythtv
	@ln -sf $(patsubst /%,%,$(call DIRSTODOTS,/home/minimyth/.mythtv))$(sysconfdir)/lirc/lircrc \
	        $@~/home/minimyth/.mythtv/lircrc
	@# Make perl init script links.
	@mkdir -m 0775 -p                $@~$(sysconfdir)/rc.d/rc
	@index=10 ; $(foreach file, $(MM_INIT_START), \
		test -e $@~$(sysconfdir)/rc.d/init/$(file).pm && \
		index=$$(($${index}+2)) && \
		ln -sf ../init/$(file).pm $@~$(sysconfdir)/rc.d/rc/S$${index}$(file) ; )
	@index=10 ; $(foreach file, $(MM_INIT_KILL) , \
		test -e $@~$(sysconfdir)/rc.d/init/$(file).pm && \
		index=$$(($${index}+2)) && \
		ln -sf ../init/$(file).pm $@~$(sysconfdir)/rc.d/rc/K$${index}$(file) ; )
	@# Make font file links.
	@
	@if [ $(mm_MYTH_VERSION) = "0.20" ]         || \
	    [ $(mm_MYTH_VERSION) = "0.20-softpad" ] || \
	    [ $(mm_MYTH_VERSION) = "0.21" ]         || \
	    [ $(mm_MYTH_VERSION) = "0.22" ]         || \
	    [ $(mm_MYTH_VERSION) = "0.23" ]         ; then \
		for font in `cd $@~$(datadir)/fonts/X11/TTF ; ls -1 *.{TTF,ttf} 2> /dev/null` ; do \
			ln -sf $(patsubst /%,%,$(call DIRSTODOTS,$(datadir)/mythtv))$(datadir)/fonts/X11/TTF/$${font} \
			       $@~$(datadir)/mythtv/$${font} ; \
	 	done ; \
	else \
		for font in `cd $@~$(datadir)/fonts/X11/TTF ; ls -1 *.{TTF,ttf} 2> /dev/null` ; do \
			ln -sf $(patsubst /%,%,$(call DIRSTODOTS,$(datadir)/mythtv/fonts))$(datadir)/fonts/X11/TTF/$${font} \
			       $@~$(datadir)/mythtv/fonts/$${font} ; \
	 	done ; \
	fi
	@# Remove unneeded perl files.
	@echo 'removing unneeded perl files'
	@dirs='$(PERL_libdir)' ; \
	 for dir in $${dirs} ; do \
		if [ -e $@~$${dir} ] ; then \
			cd $@~$${dir} ; \
			find . -depth -type f -name '.*'    -exec rm -rf '{}' \; ; \
			find . -depth -type f -name '*.bs'  -exec rm -rf '{}' \; ; \
			find . -depth -type f -name '*.e2x' -exec rm -rf '{}' \; ; \
			find . -depth -type f -name '*.eg'  -exec rm -rf '{}' \; ; \
			find . -depth -type f -name '*.h'   -exec rm -rf '{}' \; ; \
			find . -depth -type f -name '*.pod' -exec rm -rf '{}' \; ; \
			while [ `find . -depth -type d -empty | wc -l` -gt 0 ] ; do \
				find . -depth -type d -empty -exec rm -rf '{}' \; ; \
			done ; \
		fi ; \
	 done
	@# Remove unneeded python files.
	@echo 'removing unneeded python files'
	@dirs='$(PYTHON_libdir) $(datadir)/mythtv' ; \
	 for dir in $${dirs} ; do \
		if [ -e $@~$${dir} ] ; then \
			cd $@~$${dir} ; \
			find . -depth -type f -name 'EGG-INFO' -exec rm -rf '{}' \; ; \
			find . -depth -type f -name '*.egg-info' -exec rm -rf '{}' \; ; \
			find . -depth -type f -name '*.pyc' -exec rm -rf '{}' \; ; \
			find . -depth -type f -name '*.pyo' -exec rm -rf '{}' \; ; \
		fi ; \
	 done
	@# Remove unwanted binaries, etcs, shares and libraries.
	@echo 'removing unwanted files'
	@for file_item in $(addprefix $@~,$(MM_REMOVES)) ; do \
		if echo $${file_item} | grep -q -e '/$$' > /dev/null 2>&1 ; then \
			file_list=`ls -d1 $${file_item} 2> /dev/null` ; \
			for file in $${file_list} ; do \
				if [ -d $${file} ] ; then \
					rm -rf $${file} ; \
				fi ; \
			done ; \
		else \
			file_list=`ls -d1 $${file_item} 2> /dev/null` ; \
			for file in $${file_list} ; do \
				if [ -f $${file} ] ; then \
					rm -rf $${file} ; \
				fi ; \
			done ; \
		fi ; \
	 done
	@# Copy dependent libraries.
	@echo 'copying dependent libraries'
	@new_filter_path="\(`echo $(strip $(libdirs)) | sed -e 's%//*%/%g' -e 's% /% %g' -e 's%^/%%' -e 's%  *%\\\\|%g'`\)" ; \
	 pass=0 ; \
	 lib_count=1 ; \
	 old_list="" ; \
	 lib_list=`find $@~ -depth -exec file '{}' \; \
		| grep -E -i 'ELF ..-bit LSB executable|ELF ..-bit LSB shared object' \
		| sed -e 's%:.*%%' \
		| sed -e :a -e '$!N;s/\n/ /;ta' -e 'P;D'` ; \
	 while [ $${lib_count} -gt 0 ] ; do \
		pass=$$(($${pass}+1)) ; \
		old_list=`echo $${old_list} $${lib_list} \
			| sed -e 's%[^ ]*/%%g' \
			      -e 's% %\n%g' \
			| sort -u \
			| sed -e :a -e '$!N;s/\n/ /;ta' -e 'P;D'` ; \
		old_filter="\(`echo $${old_list} | sed -e 's%\([.+]\)%\\1%g' | sed -e 's%  *%\\\\|%g'`\)" ; \
		new_list=`$(OBJDUMP) -x $${lib_list} 2> /dev/null \
			| grep -e '^ *NEEDED  *' \
			| sort -u \
			| sed -e 's%^ *NEEDED  *%%' \
			      -e 's%  *$$%%' \
			      -e "s%^$${old_filter}$$%%g" \
			| sed -e :a -e '$!N;s/\n/ /;ta' -e 'P;D'` ; \
		lib_count=`echo "$${new_list}" | wc -w` ; \
		echo "copying dependent libraries: pass $${pass} found $${lib_count} libraries to copy" ; \
		if [ "$(mm_DEBUG_BUILD)" = "yes" ] ; then \
			echo "    lib_list : $${lib_list}" ; \
			echo "    old_list : $${old_list}" ; \
			echo "    new_list : $${new_list}" ; \
		fi ; \
		lib_list="" ; \
		if [ $${lib_count} -gt 0 ] ; then \
			new_filter_file="\(`echo $${new_list} | sed -e 's%\([.+]\)%\\\\\\1%g' | sed -e 's%  *%\\\\|%g'`\)" ; \
			new_filter="$${new_filter_path}/$${new_filter_file}" ; \
			new_list=`cd $(DESTDIR) ; find * -depth -regex "$${new_filter}"` ; \
			for lib in $${new_list} ; do \
				dir=`echo $${lib} | sed -e 's%[^/]*$$%%'` ; \
				mkdir -p $@~/$${dir} ; \
				cp -p $(DESTDIR)/$${lib} $@~/$${dir} ; \
				chmod -R u+w $@~/$${lib} ; \
				lib_list="$${lib_list} $@~/$${lib}" ; \
			done ; \
		fi ; \
	 done
	@# Copy dependent kernel modules.
	@echo 'copying dependent kernel modules'
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@find $@~$(LINUX_MODULESDIR) -depth -name '*.ko' | sed -e 's%^$@~$(LINUX_MODULESDIR)%/%' -e 's%//*%/%g' -e 's%^/%%' | \
	 while read module ; do \
		module_deps=`cat $(DESTDIR)$(LINUX_MODULESDIR)/modules.dep | grep -e "^$${module}:" | sed -e 's%[^:]*: *%%'` ; \
		for module_dep in $${module_deps} ; do \
			if [ ! -e $@~$(LINUX_MODULESDIR)/$${module_dep} ] ; then \
				mkdir -p `dirname $@~$(LINUX_MODULESDIR)/$${module_dep}` ; \
				cp -pd $(DESTDIR)$(LINUX_MODULESDIR)/$${module_dep} $@~$(LINUX_MODULESDIR)/$${module_dep} ; \
			fi ; \
		done ; \
	 done
	@# Remove unwanted binaries, etcs, shares and libraries.
	@echo 'removing unwanted files'
	@for file_item in $(addprefix $@~,$(MM_REMOVES)) ; do \
		if echo $${file_item} | grep -q -e '/$$' > /dev/null 2>&1 ; then \
			file_list=`ls -d1 $${file_item} 2> /dev/null` ; \
			for file in $${file_list} ; do \
				if [ -d $${file} ] ; then \
					rm -rf $${file} ; \
				fi ; \
			done ; \
		else \
			file_list=`ls -d1 $${file_item} 2> /dev/null` ; \
			for file in $${file_list} ; do \
				if [ -f $${file} ] ; then \
					rm -rf $${file} ; \
				fi ; \
			done ; \
		fi ; \
	 done
	@# Generate kernel files.
	@depmod -b "$@~$(rootdir)" "$(LINUX_FULL_VERSION)"
	@# Generate font files.
	@cd $@~$(datadir)/fonts/X11/misc ; mkfontscale . ; mkfontdir .
	@cd $@~$(datadir)/fonts/X11/TTF  ; mkfontscale . ; mkfontdir .
	@# Strip binaries and shared libraries.
	@if [ ! $(mm_DEBUG) = yes ] ; then \
		echo 'stripping binaries and shared libraries' ; \
		find $@~ -depth -exec file '{}' \; \
			| grep -E -i 'ELF ..-bit LSB executable|ELF ..-bit LSB shared object' \
			| sed -e 's%:.*%%' \
			| xargs $(STRIP) --strip-all -R .note -R .comment ; \
	 fi
	@# Strip Perl scripts
	@# If running a parallel build, then let perlstrip.pl start the same number of threads.
	@if [ ! $(mm_DEBUG) = yes ] ; then \
		echo 'stripping perl' ; \
		threads="$(patsubst -j%,%,$(filter -j%,$(PARALLELMFLAGS)))" ; \
		[ "$${threads}" = "" ] && threads="1" ; \
		dir_list="$@~$(PERL_libdir) $@~$(datadir)/mythtv" ; \
		perl $(build_DESTDIR)/$(build_bindir)/perlstrip.pl $${threads} $${dir_list} > /dev/null 2>&1 ; \
		revert_list=`find $${dir_list} -depth -name *.ERR | sed -e 's%\.ERR$$%%' -e 's%^$@~%%'` ; \
		for revert in $${revert_list} ; do \
			echo "stripping perl: not stripping file [...]$${revert}" ; \
			rm -f $@~$${revert}.ERR ; \
			rm -f $@~$${revert}.LOG ; \
			cp -f $(DESTDIR)$${revert} $@~$${revert} ; \
		done ; \
	 fi
	@# Strip Python scripts
	@#if [ ! $(mm_DEBUG) = yes ] ; then \
	#	echo 'stripping python' ; \
	#	dir_list="$@~$(PYTHON_libdir) $@~$(datadir)/mythtv" ; \
	#	file_list=`find $${dir_list} -depth -name '*.py'` ; \
	#	for file in $${file_list} ; do \
	#		python $(build_DESTDIR)/$(build_bindir)/pyminifier.py "$${file}" 1> "$${file}~" 2> /dev/null ; \
	#		if [ "x$$?" = "x0" ] ; then \
	#			mv -f "$${file}~" "$${file}" ; \
	#		else \
	#			echo "stripping python: not stripping file [...]$${file}" ; \
	#			rm -f "$${file}~" ; \
	#		fi ; \
	#	done ; \
	# fi
	@# Create library loader symbolic link to help out binary applications.
	@if [ -e $@~$(elibdir)/ld-linux.so.2 ] ; then \
		if [ ! $(elibdir) = '/lib32' ] ; then \
			mkdir -p $@~/lib32 ; \
			rm -f $@~/lib32/ld-linux.so.2 ; \
			ln -s $(elibdir)/ld-linux.so.2 $@~/lib32/ld-linux.so.2 ; \
		fi ; \
	 fi
	@if [ -e $@~$(elibdir)/ld-linux-x86-64.so.2 ] ; then \
		if [ ! $(elibdir) = '/lib64' ] ; then \
			mkdir -p $@~/lib64 ; \
			rm -f $@~/lib64/ld-linux-x86_64.so.2 ; \
			ln -s $(elibdir)/ld-linux-x86-64.so.2 $@~/lib64/ld-linux-x86-64.so.2 ; \
		fi ; \
	 fi
	@# Clean up permissions (at least somewhat)
	@find $@~ -depth -exec file '{}' \; \
		| grep -i 'ELF ..-bit LSB executable' \
		| sed -e 's%:.*%%' \
		| xargs chmod 0755
	@find $@~ -depth -exec file '{}' \; \
		| grep -i 'ELF ..-bit LSB shared object' \
		| sed -e 's%:.*%%' \
		| grep -v '*' \
		| grep -v '/libc.so.[0-9]\+$$' \
		| grep -v '/ld-linux.so.[0-9]\+$$' \
		| grep -v '/ld-linux-x86-64.so.[0-9]\+$$' \
		| xargs chmod 0644
	@$(call SET_PERMISSIONS,$@~)
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/image/rootfs: $(top_build)/image/rootfs
	@echo "making root file system directory"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@# Create the read-only root file system from the base file system.
	@# Copy the base file system to the read-only root file system location.
	@# Remove extras directory items because they is included in the extras file system image.
	@# Remove the non-menu themes and non-default themes because they are included in the themes file system.
	@cp -pdR $< $@~/rootfs-ro
	@rm -rf           $@~/rootfs-ro/$(extras_rootdir)
	@mkdir -m 0755 -p $@~/rootfs-ro/$(extras_rootdir)
	@for theme in `cd $@~/rootfs-ro/usr/share/mythtv/themes ; ls -1` ; do \
		if [ ! -e $@~/rootfs-ro/usr/share/mythtv/themes/$${theme}/mainmenu.xml ] && \
		   [ ! "$${theme}" = "default"                                         ] && \
		   [ ! "$${theme}" = "default-wide"                                    ] ; then \
			rm -rf $@~/rootfs-ro/usr/share/mythtv/themes/$${theme} ; \
		fi ; \
	 done
	@# Create the rest for root file system.
	@mkdir -m 0755 -p                   $@~/rootfs
	@mkdir -m 0755 -p                   $@~/rw
	@mkdir -m 0755 -p                   $@~/bin
	@mkdir -m 0755 -p                   $@~/sbin
	@ln -s rootfs-ro/dev                $@~/dev
	@ln -s rootfs-ro/lib                $@~/lib
	@ln -s rootfs-ro/usr                $@~/usr
	@ln -s ../rootfs-ro/bin/mkdir       $@~/bin/mkdir
	@ln -s ../rootfs-ro/sbin/modprobe   $@~/sbin/modprobe
	@ln -s ../rootfs-ro/bin/mount       $@~/bin/mount
	@ln -s ../rootfs-ro/sbin/pivot_root $@~/sbin/pivot_root
	@ln -s ../rootfs-ro/bin/sh          $@~/bin/sh
	@find $(top_source)/initrd -depth -type d \
		| sed -e 's%^\$(top_source)/initrd%$@~%' \
		| xargs -n 1 mkdir -m 0755 -p
	@find $(top_source)/initrd -depth -type f \
		| sed -e 's%^\(\$(top_source)/initrd\)/\(.*\)$$%\1/\2 $@~/\2%' \
		| xargs -n 2 cp -fpd
	@$(call SET_PERMISSIONS,$@~)
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/image/rootfs.fakeroot: $(top_build)/stage/image/rootfs
	@echo "making root file system directory fakeroot configuration file"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@fakeroot -s $@~ sh -c                                             " \
		chmod    u+s     $</rootfs-ro/$(ebindir)/busybox           ; \
		chmod    u+s     $</rootfs-ro/$(ebindir)/ping              ; \
		chmod    u+s     $</rootfs-ro/$(bindir)/pmount             ; \
		chmod    u+s     $</rootfs-ro/$(esbindir)/poweroff         ; \
		chmod    u+s     $</rootfs-ro/$(bindir)/pumount            ; \
		chmod    u+s     $</rootfs-ro/$(bindir)/X                  ; \
		rm -rf           $</rootfs-ro/$(rootdir)/dev               ; \
		mkdir -m 0755 -p $</rootfs-ro/$(rootdir)/dev               ; \
		mknod -m 0600    $</rootfs-ro/$(rootdir)/dev/console c 5 1 ; \
		mknod -m 0600    $</rootfs-ro/$(rootdir)/dev/initctl p     ; \
		mknod -m 0666    $</rootfs-ro/$(rootdir)/dev/null    c 1 3 "
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/image/themes: $(top_build)/image/rootfs
	@echo "making themes file system directory"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@cp -pdR $</usr/share/mythtv/themes/* $@~
	@# Remove the menu themes and default themes because they are included in the root file system.
	@for theme in `cd $@~ ; ls -1` ; do \
		if [ -e $@~/$${theme}/mainmenu.xml ] || \
		   [ "$${theme}" = "default"       ] || \
		   [ "$${theme}" = "default-wide"  ] ; then \
			rm -rf $@~/$${theme} ; \
		fi ; \
	 done
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/image/extras: $(top_build)/image/rootfs
	@echo "making extras file system directory"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@cp -pdR $</$(extras_rootdir)/* $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/pxe-$(mm_NAME): $(top_source)/pxe
	@echo "making PXE directory"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@cp -pdR $< $@~
	@sed -e 's%@MM_NAME@%$(mm_NAME)%' -i $@~/gpxe/tftpboot/minimyth/gpxe.cfg/default
	@sed -e 's%@MM_NAME@%$(mm_NAME)%' -i $@~/pxelinux/tftpboot/minimyth/pxelinux.cfg/default
	@if [ -e       $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/gpxe.0 ] ; then \
		cp -pd $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/gpxe.0 \
		       $@~/gpxe/tftpboot/minimyth/gpxe.0 ; \
	 fi
	@if [ -e       $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/pxelinux.0 ] ; then \
		cp -pd $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/pxelinux.0 \
		       $@~/pxelinux/tftpboot/minimyth/pxelinux.0 ; \
	 fi
	@find $@~ -depth -type d -exec chmod 0755 '{}' \;
	@find $@~ -depth -type f -exec chmod 0644 '{}' \;
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/helper: \
		$(top_source)/mm_local/mm_local_helper
	@echo "making helper directory"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@cp -pdR $^ $@~
	@cd $@~ ; for file in `ls -1` ; do  \
		md5sum $${file} > $${file}.md5 ; \
	 done
	@find $@~ -depth -type d -exec chmod 0755 '{}' \;
	@find $@~ -depth -type f -exec chmod 0644 '{}' \;
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/html: $(top_source)/html
	@echo "copying HTML documentation"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@cp -pdR $^ $@~
	@find $@~ -depth -type d -exec chmod 0755 '{}' \;
	@find $@~ -depth -type f -exec chmod 0644 '{}' \;
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/version:
	@echo "making version file"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@touch $@~
	@echo "$(mm_VERSION)" > $@~
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/scripts: \
		$(top_source)/mm_local/mm_local_install \
		$(top_source)/mm_local/mm_local_helper
	@echo "making scripts directory"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@cp -pdR $^ $@~
	@find $@~ -depth -type d -exec chmod 0755 '{}' \;
	@find $@~ -depth -type f -exec chmod 0644 '{}' \;
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/changelog.txt: $(top_source)/html/document-changelog.txt
	@echo "copying changelog file"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@cp -pdR $< $@~
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/readme.txt: $(top_source)/share-readme.txt
	@echo "copying readme file"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@cp -pdR $< $@~
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/gar-$(mm_NAME): $(top_source)/gar-minimyth
	@echo "copying build system source directory"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@cp -pdR $< $@~
	@$(call SET_PERMISSIONS,$@~)
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/kernel: $(DESTDIR)/$(LINUX_DIR)/vmlinuz
	@echo "copying kernel file"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@cp -pdR $< $@~
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/rootfs: $(top_build)/stage/image/rootfs $(top_build)/stage/image/rootfs.fakeroot
	@echo "making the squashfs version of the root file system"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@fakeroot -i $<.fakeroot sh -c "mksquashfs $< $@~ -comp xz -no-exports -no-progress -no-fragments > /dev/null 2>&1"
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/extras.sfs: $(top_build)/stage/image/extras
	@echo "making the squashfs version of the extras file system"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@fakeroot sh -c "mksquashfs $< $@~ -comp xz -no-exports -no-progress -no-fragments > /dev/null 2>&1"
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/themes: $(top_build)/stage/image/themes
	@echo "making the squashfs version of the themes file system"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@for theme in `cd $< ; ls -1` ; do  \
		fakeroot sh -c "mksquashfs $</$${theme} $@~/$${theme}.sfs -comp xz   -no-exports -no-progress -no-fragments > /dev/null 2>&1" ; \
	 done
	@find $@~ -depth -type d -exec chmod 0755 '{}' \;
	@find $@~ -depth -type f -exec chmod 0644 '{}' \;
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/rootfs.tar.bz2: $(top_build)/stage/image/rootfs $(top_build)/stage/image/rootfs.fakeroot
	@echo "making the tarball version of the root file system"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@fakeroot -i $<.fakeroot sh -c "tar -C $(<D) -jcf $@~ $(<F)"
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/extras.tar.bz2: $(top_build)/stage/image/extras
	@echo "making the tarball version of the extras file system"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@fakeroot                sh -c "tar -C $(<D) -jcf $@~ $(<F)"
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/themes.tar.bz2: $(top_build)/stage/image/themes
	@echo "making the tarball version of the themes file system"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@fakeroot                sh -c "tar -C $(<D) -jcf $@~ $(<F)"
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/%.md5: $(top_build)/stage/%
	@echo "making the checksum file for $(patsubst $(top)%,[...]%,$<)"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@(cd $(<D) ; find $(<F) -depth -type f -exec md5sum '{}' \; | sort -k 2) > $@~
	@chmod 644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/%.tar.bz2: $(top_build)/stage/%
	@echo "making the tarball file of $(patsubst $(top)%,[...]%,$<)"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@fakeroot                sh -c "tar -C $(<D) -jcf $@~ $(<F)"
	@chmod 0644 $@~
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/local/ram-$(mm_NAME)  \
$(top_build)/stage/local/nfs-$(mm_NAME)  \
$(top_build)/stage/share/ram-$(mm_NAME)  \
$(top_build)/stage/share/nfs-$(mm_NAME):
	@echo "making $(patsubst $(top)%,[...]%,$@)"
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@cp -pdR $^ $@~
	@rm -f $@~/minimyth.md5
	@rm -f $@~~minimyth.md5~
	@(cd $@~ ; find -depth -type f -exec md5sum '{}' \; | sed -e 's%\./%%' | sort -k 2) > $@~~minimyth.md5~
	@mv -f $@~~minimyth.md5~ $@~/minimyth.md5
	@chmod 0644 $@~/minimyth.md5
	@touch $@~
	@mv $@~ $@

$(top_build)/stage/share/ram-$(mm_NAME): \
		$(top_build)/stage/version \
		$(top_build)/stage/html    \
		$(top_build)/stage/scripts \
		$(top_build)/stage/kernel  \
		$(top_build)/stage/rootfs  \
		$(top_build)/stage/themes

$(top_build)/stage/share/nfs-$(mm_NAME): \
		$(top_build)/stage/version        \
		$(top_build)/stage/html           \
		$(top_build)/stage/scripts        \
		$(top_build)/stage/kernel         \
		$(top_build)/stage/rootfs.tar.bz2 \
		$(top_build)/stage/themes.tar.bz2

$(top_build)/stage/local/ram-$(mm_NAME): \
		$(top_build)/stage/version    \
		$(top_build)/stage/html       \
		$(top_build)/stage/scripts    \
		$(top_build)/stage/kernel     \
		$(top_build)/stage/rootfs     \
		$(top_build)/stage/themes     \
		$(top_build)/stage/extras.sfs

$(top_build)/stage/local/nfs-$(mm_NAME): \
		$(top_build)/stage/version        \
		$(top_build)/stage/html           \
		$(top_build)/stage/scripts        \
		$(top_build)/stage/kernel         \
		$(top_build)/stage/rootfs.tar.bz2 \
		$(top_build)/stage/themes.tar.bz2 \
		$(top_build)/stage/extras.tar.bz2

$(top_build)/local: \
		$(top_build)/stage/scripts                                                                      \
		$(top_build)/stage/version                $(top_build)/stage/version.md5                        \
		$(top_build)/stage/html.tar.bz2           $(top_build)/stage/html.tar.bz2.md5                   \
		$(top_build)/stage/helper.tar.bz2         $(top_build)/stage/helper.tar.bz2.md5                 \
		$(top_build)/stage/pxe-$(mm_NAME).tar.bz2 $(top_build)/stage/pxe-$(mm_NAME).tar.bz2.md5         \
		$(top_build)/stage/gar-$(mm_NAME).tar.bz2 $(top_build)/stage/gar-$(mm_NAME).tar.bz2.md5         \
		$(if $(filter yes,$(mm_DISTRIBUTION_RAM)), $(top_build)/stage/local/ram-$(mm_NAME).tar.bz2)     \
		$(if $(filter yes,$(mm_DISTRIBUTION_RAM)), $(top_build)/stage/local/ram-$(mm_NAME).tar.bz2.md5) \
		$(if $(filter yes,$(mm_DISTRIBUTION_NFS)), $(top_build)/stage/local/nfs-$(mm_NAME).tar.bz2)     \
		$(if $(filter yes,$(mm_DISTRIBUTION_NFS)), $(top_build)/stage/local/nfs-$(mm_NAME).tar.bz2.md5) \
		$(top_build)/stage/changelog.txt
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@cp -pdR $^ $@~
	@touch $@~
	@mv $@~ $@
	@echo "made local distribution"

$(top_build)/share: \
		$(top_build)/stage/scripts                                                                      \
		$(top_build)/stage/version                $(top_build)/stage/version.md5                        \
		$(top_build)/stage/html.tar.bz2           $(top_build)/stage/html.tar.bz2.md5                   \
		$(top_build)/stage/helper.tar.bz2         $(top_build)/stage/helper.tar.bz2.md5                 \
		$(top_build)/stage/pxe-$(mm_NAME).tar.bz2 $(top_build)/stage/pxe-$(mm_NAME).tar.bz2.md5         \
		$(top_build)/stage/gar-$(mm_NAME).tar.bz2 $(top_build)/stage/gar-$(mm_NAME).tar.bz2.md5         \
		$(if $(filter yes,$(mm_DISTRIBUTION_RAM)), $(top_build)/stage/share/ram-$(mm_NAME).tar.bz2)     \
		$(if $(filter yes,$(mm_DISTRIBUTION_RAM)), $(top_build)/stage/share/ram-$(mm_NAME).tar.bz2.md5) \
		$(if $(filter yes,$(mm_DISTRIBUTION_NFS)), $(top_build)/stage/share/nfs-$(mm_NAME).tar.bz2)     \
		$(if $(filter yes,$(mm_DISTRIBUTION_NFS)), $(top_build)/stage/share/nfs-$(mm_NAME).tar.bz2.md5) \
		$(top_build)/stage/changelog.txt                                                                \
		$(top_build)/stage/readme.txt
	@mkdir -m 0755 -p $(@D)
	@rm -rf $@ $@~
	@mkdir -m 0755 -p $@~
	@cp -pdR $^ $@~
	@touch $@~
	@mv $@~ $@
	@echo "made share distribution"

install: build
	@rm -rf   $(mm_DESTDIR)
	@mkdir -p $(mm_DESTDIR)
	@if [ -e $(top_build)/local ] ; then \
		cp -pdR $(top_build)/local $(mm_DESTDIR)/ ; \
	 fi
	@if [ -e $(top_build)/share ] ; then \
		cp -pdR $(top_build)/share $(mm_DESTDIR)/ ; \
	 fi
	@if [ $(mm_INSTALL_RAM_BOOT) = yes ] || \
	    [ $(mm_INSTALL_NFS_BOOT) = yes ] || \
	    [ $(mm_INSTALL_LATEST)   = yes ] ; then \
		su -c " \
			if [ $(mm_INSTALL_RAM_BOOT) = yes ] ; then                                      \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME)                                   ; \
			fi                                                                            ; \
			                                                                                \
			if [ $(mm_INSTALL_NFS_BOOT) = yes ] ; then                                      \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME)                                   ; \
				rm -rf   $(mm_NFS_ROOT)/$(mm_NAME)                                    ; \
			fi                                                                            ; \
			                                                                                \
			if [ $(mm_INSTALL_LATEST)   = yes ] ; then                                      \
				rm -rf   $(mm_TFTP_ROOT)/latest                                       ; \
			fi                                                                            ; \
			                                                                                \
			if [ $(mm_INSTALL_RAM_BOOT) = yes ] ; then                                      \
				mkdir -p $(mm_TFTP_ROOT)/                                             ; \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
				mkdir -p $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
				tar -jxf $(top_build)/local/ram-$(mm_NAME).tar.bz2                      \
				      -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
				                                                                        \
				mkdir -p $(mm_TFTP_ROOT)/$(mm_NAME)                                   ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/version          \
				         $(mm_TFTP_ROOT)/$(mm_NAME)/version                           ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/kernel           \
				         $(mm_TFTP_ROOT)/$(mm_NAME)/kernel                            ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/rootfs           \
				         $(mm_TFTP_ROOT)/$(mm_NAME)/rootfs                            ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/themes           \
				         $(mm_TFTP_ROOT)/$(mm_NAME)/themes                            ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/ram-$(mm_NAME)/extras.sfs       \
				         $(mm_TFTP_ROOT)/$(mm_NAME)/extras.sfs                        ; \
				                                                                        \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
			fi                                                                            ; \
			                                                                                \
			if [ $(mm_INSTALL_NFS_BOOT) = yes ] ; then                                      \
				mkdir -p $(mm_TFTP_ROOT)/                                             ; \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
				mkdir -p $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
				tar -jxf $(top_build)/local/nfs-$(mm_NAME).tar.bz2                      \
				      -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
				                                                                        \
				mkdir -p $(mm_TFTP_ROOT)/                                             ; \
				mkdir -p $(mm_TFTP_ROOT)/$(mm_NAME)                                   ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/version          \
				         $(mm_TFTP_ROOT)/$(mm_NAME)/version                           ; \
				cp -pdR  $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/kernel           \
				         $(mm_TFTP_ROOT)/$(mm_NAME)/kernel                            ; \
				                                                                        \
				tar -jxf $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/rootfs.tar.bz2   \
				      -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
				tar -jxf $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/extras.tar.bz2   \
				      -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
				tar -jxf $(mm_TFTP_ROOT)/$(mm_NAME).tmp/nfs-$(mm_NAME)/themes.tar.bz2   \
				      -C $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
				mkdir -p $(mm_NFS_ROOT)                                               ; \
				mv       $(mm_TFTP_ROOT)/$(mm_NAME).tmp/rootfs                          \
				         $(mm_NFS_ROOT)/$(mm_NAME)                                    ; \
				mv       $(mm_TFTP_ROOT)/$(mm_NAME).tmp/themes/*                        \
				         $(mm_NFS_ROOT)/$(mm_NAME)/rootfs-ro/usr/share/mythtv/themes  ; \
				mv       $(mm_TFTP_ROOT)/$(mm_NAME).tmp/extras/*                        \
				         $(mm_NFS_ROOT)/$(mm_NAME)/rootfs-ro/$(extras_rootdir)        ; \
				                                                                        \
				rm -rf   $(mm_TFTP_ROOT)/$(mm_NAME).tmp                               ; \
			fi                                                                            ; \
			                                                                                \
			if [ $(mm_INSTALL_LATEST)   = yes ] ; then                                      \
				mkdir -p $(mm_TFTP_ROOT)/latest                                       ; \
				cp -pdR  $(top_build)/local/* $(mm_TFTP_ROOT)/latest/                 ; \
			fi                                                                            ; \
		" ; \
	 fi

.PHONY: all build install
