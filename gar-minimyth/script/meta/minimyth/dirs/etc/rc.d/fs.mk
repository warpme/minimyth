################################################################################
# fs.mk
################################################################################

FS = \
	/dev \
	/etc \
	/mnt \
	/proc \
	/root \
	/sys \
	/tmp \
	/var \
	/var/run \
	/var/lock \
	/var/unionfs

fs: fs-modules $(FS)
	touch fs

fs-modules:
	modprobe unionfs
	touch fs-modules

/sys: fs-sys
	touch /sys

fs-sys:
	mount -n -t sysfs /sys /sys
	touch /sys
	touch fs-sys

/proc: fs-proc
	touch /proc

fs-proc:
	mount -n -t proc /proc /proc
	touch /proc
	touch fs-proc

/var: fs-var
	touch /var

fs-var: /proc
	mount -t tmpfs -o size=512K tmpfs /var
	touch /var
	touch fs-var

/tmp: fs-tmp
	touch /tmp

fs-tmp:
	touch /tmp
	touch fs-tmp

/etc: fs-etc
	touch /etc

fs-etc: mm_dir_make_rw
	mm_dir_make_rw /etc
	touch /etc
	touch fs-etc

/mnt: fs-mnt
	touch /mnt

fs-mnt: mm_dir_make_rw
	mm_dir_make_rw /mnt
	touch /mnt
	touch fs-mnt

/root: fs-root
	touch /root

fs-root: mm_dir_make_rw
	mm_dir_make_rw /root
	touch /root
	touch fs-root

/var/lock: /var
	mkdir -p /var/lock
	touch /var/lock

/var/run: /var
	mkdir -p /var/run
	touch /var/run

/var/unionfs: fs-var-unionfs
	touch /var/unionfs

fs-var-unionfs: /var
	mkdir -p /var/unionfs
	mount -t tmpfs tmpfs /var/unionfs
	touch /var/unionfs
	touch fs-var-unionfs
