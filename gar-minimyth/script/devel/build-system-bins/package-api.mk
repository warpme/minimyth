build_system_bins = $(strip $(sort \
	$(build_system_bins_binutils) \
	$(build_system_bins_bison) \
	$(build_system_bins_bzip2) \
	$(build_system_bins_coreutils) \
	$(build_system_bins_cvs) \
	$(build_system_bins_diffutils) \
	$(build_system_bins_findutils) \
	$(build_system_bins_flex) \
	$(build_system_bins_gawk) \
	$(build_system_bins_gcc) \
	$(build_system_bins_glibc) \
	$(build_system_bins_grep) \
	$(build_system_bins_gzip) \
	$(build_system_bins_util_linux) \
	$(build_system_bins_make) \
	$(build_system_bins_patch) \
	$(build_system_bins_perl) \
	$(build_system_bins_sed) \
	$(build_system_bins_subversion) \
	$(build_system_bins_tar) \
	$(build_system_bins_wget) \
))

# Overridden by binaries from package devel/binutils.
build_system_bins_binutils = \
	ar \
	as \
	ld \
	nm \
	ranlib

# Overridden by binaries from package devel/bison.
build_system_bins_bison = \
	bison

# Overridden by binaries from package utils/bzip2.
build_system_bins_bzip2 = \
	bzip2

# Overridden by binaries from package utils/coreutils, except 'su'.
build_system_bins_coreutils = \
	basename \
	cat \
	chmod \
	cp \
	cut \
	date \
	echo \
	expr \
	false \
	head \
	install \
	ln \
	ls \
	md5sum \
	mkdir \
	mv \
	rm \
	rmdir \
	sleep \
	sort \
	su \
	tail \
	test \
	touch \
	tr \
	true \
	uname \
	uniq

build_system_bins_cvs = \
	cvs

# Overridden by binaries from package utils/diffutils.
build_system_bins_diffutils = \
	cmp

# Overridden by binaries from package utils/findutils.
build_system_bins_findutils = \
	find

# Overridden by binaries from package utils/flex.
build_system_bins_flex = \
	flex

# Overridden by binaries from package utils/gawk.
build_system_bins_gawk = \
	gawk

# Overridden by binaries from package devel/gcc.
build_system_bins_gcc = \
	cpp \
	gcc

build_system_bins_glibc = \
	getconf \
	ldconfig

# Overridden by binaries from package utils/grep.
build_system_bins_grep = \
	egrep \
	fgrep \
	grep

# Overridden by binaries from package utils/gzip.
build_system_bins_gzip = \
	gzip

# Overridden by binaries from package utils/util-linux.
build_system_bins_util_linux = \
	arch

# Overridden by binaries from package devel/make.
build_system_bins_make = \
	make

# Overridden by binaries from package devel/patch.
build_system_bins_patch = \
	patch

build_system_bins_perl = \
	perl

# Overridden by binaries from package utils/sed.
build_system_bins_sed = \
	sed

build_system_bins_subversion = \
	svn

# Overridden by binaries from package utils/tar.
build_system_bins_tar = \
	tar

build_system_bins_wget = \
	wget
