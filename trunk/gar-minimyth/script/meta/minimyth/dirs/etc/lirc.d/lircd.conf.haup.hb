
# Please make this file available to others
# by sending it to <lirc@bartelmus.de>
#
# this config file was automatically generated
# using lirc-0.6.6(serial) on Fri Jan 23 03:39:02 2004
#
# contributed by Larry Matter (lirc@matter.net)
#
# brand:  Hauppauge grey remote on a homebrew receiver (uses RC-5)
#

begin remote

  name  RC-5.conf.conf
  bits           13
  flags RC5|CONST_LENGTH
  eps            30
  aeps          100

  one           889   889
  zero          889   889
  plead         889
  gap          113792
  toggle_bit      2

  frequency    36000
  duty_cycle   50

      begin codes
          Power                    0x00000000000017FD
          Go                       0x00000000000017FB
          1                        0x00000000000017C1
          2                        0x00000000000017C2
          3                        0x00000000000017C3
          4                        0x00000000000017C4
          5                        0x00000000000017C5
          6                        0x00000000000017C6
          7                        0x00000000000017C7
          8                        0x00000000000017C8
          9                        0x00000000000017C9
          Back                     0x00000000000017DF
          0                        0x00000000000017C0
          Menu                     0x00000000000017CD
          Red                      0x00000000000017CB
          Green                    0x00000000000017EE
          Yellow                   0x00000000000017F8
          Blue                     0x00000000000017E9
          Up                       0x00000000000017E0
          Left                     0x00000000000017D1
          Enter                    0x00000000000017E5
          Right                    0x00000000000017D0
          Down                     0x00000000000017E1
          Mute                     0x00000000000017CF
          Empty                    0x00000000000017CC
          Exit                     0x00000000000017FC
          Rewind                   0x00000000000017F2
          Play                     0x00000000000017F5
          FForward                 0x00000000000017F4
          Record                   0x00000000000017F7
          Stop                     0x00000000000017F6
          Pause                    0x00000000000017F0
          Replay                   0x00000000000017E4
          Skip                     0x00000000000017DE
      end codes

end remote


