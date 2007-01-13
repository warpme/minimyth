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
	/var/lock \
	/var/log \
	/var/run \
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

/dev: fs-dev
	touch /dev

fs-dev: /proc /sys
	mount -n -t tmpfs tmpfs /dev
	mknod -m 640 /dev/mem     c 1 1
	mknod -m 666 /dev/null    c 1 3
	mknod -m 666 /dev/zero    c 1 5
	mknod -m 666 /dev/random  c 1 8
	mknod -m 444 /dev/urandom c 1 9
	mknod -m 660 /dev/tty0    c 4 0
	mknod -m 660 /dev/tty1    c 4 1
	mknod -m 660 /dev/tty2    c 4 2
	mknod -m 666 /dev/tty     c 5 0
	mknod -m 600 /dev/console c 5 1
	mknod -m 666 /dev/ptmx    c 5 2
	ln -s /proc/kcore     /dev/core
	ln -s /proc/self/fd   /dev/fd
	ln -s /proc/self/fd/0 /dev/stdin
	ln -s /proc/self/fd/1 /dev/stdout
	ln -s /proc/self/fd/2 /dev/stderr
	mkdir -p /dev/pts ; mount -n -t devpts none /dev/pts
	mkdir -p /dev/shm ; mount -n -t tmpfs  none /dev/shm
	echo "/sbin/udev" > /proc/sys/kernel/hotplug
	udevstart
	touch /dev
	touch fs-dev

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

/var/log: /var
	mkdir -p /var/log
	touch /var/log

/var/run: /var
	mkdir -p /var/run
	touch /var/run

/var/unionfs: /var
	mkdir -p /var/unionfs
	mount -n -t tmpfs tmpfs /var/unionfs
	touch /var/unionfs
