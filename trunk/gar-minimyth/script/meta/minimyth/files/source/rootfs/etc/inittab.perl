# Default runlevel.
#   0 - halt.
#   1 - init.
#   2 - init.
#   3 - init.
#   4 - init.
#   5 - init.
#   6 - reboot.
id:5:initdefault:

# System initialization.
si::sysinit:/etc/rc.d/rc.sysinit.sh

l0:0:wait:/etc/rc.d/rc.pl 0
l1:1:wait:/etc/rc.d/rc.pl 1
l2:2:wait:/etc/rc.d/rc.pl 2
l3:3:wait:/etc/rc.d/rc.pl 3
l4:4:wait:/etc/rc.d/rc.pl 4
l5:5:wait:/etc/rc.d/rc.pl 5
l6:6:wait:/etc/rc.d/rc.pl 6

# Run a virtual terminal.
# Note: X is run on virtual terminal 2.
# Note: The following virtual terminal is started 
#       either by /etc/rc.d/rc.pl when an init error occurs.
#       or by /etc/rc.d/init/console when security is disabled.
#       Therefore, we do not start it here.
#1:2345:respawn:/sbin/agetty 9600 tty1

ca::ctrlaltdel:/sbin/shutdown -t3 -r now
