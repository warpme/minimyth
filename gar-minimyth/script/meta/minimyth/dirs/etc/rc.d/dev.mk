################################################################################
# dev.mk
################################################################################

DEV_LIST = \
	/dev/console \
	/dev/core \
	/dev/fd \
	/dev/mem \
	/dev/null \
	/dev/ptmx \
	/dev/pts \
	/dev/random \
	/dev/shm \
	/dev/stderr \
	/dev/stdin \
	/dev/stdout \
	/dev/tty \
	/dev/tty0 \
	/dev/tty1 \
	/dev/tty2 \
	/dev/urandom \
	/dev/zero

dev: /dev
	touch dev

/dev: dev-dev $(DEV_LIST)
	echo "/sbin/udev" > /proc/sys/kernel/hotplug
	udevstart
	touch /dev

dev-dev:
	mount -t ramfs none /dev
	touch dev-dev

/dev/console: dev-dev
	mknod -m 600 /dev/console c 5 1
	touch /dev/console

/dev/core: dev-dev /proc
	ln -s /proc/kcore /dev/core

/dev/fd: dev-dev /proc
	ln -s /proc/self/fd /dev/fd

/dev/mem: dev-dev
	mknod -m 640 /dev/mem c 1 1
	touch /dev/mem

/dev/null: dev-dev
	mknod -m 666 /dev/null c 1 3
	touch /dev/null

/dev/ptmx: dev-dev
	mknod -m 666 /dev/ptmx c 5 2
	touch /dev/ptmx

/dev/pts: dev-dev-pts
	touch /dev/pts

dev-dev-pts: dev-dev
	mkdir -p /dev/pts
	mount -t devpts none /dev/pts
	touch dev-dev-pts

/dev/random: dev-dev
	mknod -m 666 /dev/random  c 1 8
	touch /dev/random

/dev/shm: dev-dev-shm
	touch /dev/shm

dev-dev-shm: dev-dev
	mkdir -p /dev/shm
	mount -t tmpfs none /dev/shm
	touch dev-dev-shm

/dev/stderr: dev-dev /proc
	ln -s /proc/self/fd/2 /dev/stderr

/dev/stdin: dev-dev /proc
	ln -s /proc/self/fd/0 /dev/stdin

/dev/stdout: dev-dev /proc
	ln -s /proc/self/fd/1 /dev/stdout

/dev/tty: dev-dev
	mknod -m 666 /dev/tty c 5 0
	touch /dev/tty

/dev/tty0: dev-dev
	mknod -m 660 /dev/tty0 c 4 0
	touch /dev/tty0

/dev/tty1: dev-dev
	mknod -m 660 /dev/tty1 c 4 1
	touch /dev/tty1

/dev/tty2: dev-dev
	mknod -m 660 /dev/tty2 c 4 2
	touch /dev/tty2

/dev/urandom: dev-dev
	mknod -m 444 /dev/urandom c 1 9
	touch /dev/urandom

/dev/zero: dev-dev
	mknod -m 666 /dev/zero c 1 5
	touch /dev/zero
