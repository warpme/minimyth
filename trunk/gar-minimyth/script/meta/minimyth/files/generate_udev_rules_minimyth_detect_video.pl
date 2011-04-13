#!/usr/bin/perl

sub modalias
{
    $vendor = shift;
    $product = shift;

    $vendor = uc($vendor);
    $product = uc($product);

    return "pci:v0000" . $vendor . "d0000" . $product . "sv0000????sd0000????bc03sc00i??";
}

my %entries = undef;

my $outfile_udev_rules = qq(05-minimyth-detect-video.rules.disabled);
die qq(error: output file $outfile_udev_rules already exists.\n) if (-e $outfile_udev_rules);

my $tmpfile_udev_rules = qq(/tmp/$$.05-minimyth-detect-video.rules.disabled);
die qq(error: temporary file $tmpfile_udev_rules already exists.\n) if (-e $tmpfile_udev_rules);

my $tmpfile_pciids_txt = qq(/tmp/$$.pciids.txt);
die qq(error: temporary file $tmpfile_pciids_txt already exists.\n) if (-e $tmpfile_pciids_txt);

system(qq(wget 'http://cgit.freedesktop.org/mesa/drm/tree/shared-core/drm_pciids.txt?id=a66cf9ce68bdf9bd887f91a38ced4b59c129b3c7' -O $tmpfile_pciids_txt));
die qq(error: failed to download DRM PCI ids file.\n) if (! -e $tmpfile_pciids_txt);
if (open(FILE, '<', qq($tmpfile_pciids_txt)))
{
    my $driver = undef;
    while (<FILE>)
    {
        if    (/^\[viadrv\]$/) { $driver = q(openchrome); }
        elsif (/^\[savage\]$/) { $driver = q(savage);     }
        elsif (/^\[sis\]$/)    { $driver = q(sis);        }
        elsif (/^\[.*\]$/)     { $driver = undef;         }
        if (defined($driver))
        {
            if (/^0x(....) 0x(....) /)
            {
                my $vendor  = uc($1);
                my $product = uc($2);
                $entries{qq($vendor.$product)} = $driver;
            }
        }
    }
    close(FILE);
}
unlink(qq($tmpfile_pciids_txt));

system(qq(wget 'http://cgit.freedesktop.org/xorg/driver/xf86-video-ati/plain/src/radeon_chipinfo_gen.h' -O $tmpfile_pciids_txt));
die qq(error: failed to download xf86-video-ati PCI ids file.\n) if (! -e $tmpfile_pciids_txt);
if (open(FILE, '<', qq($tmpfile_pciids_txt)))
{
    my $driver = undef;
    while (<FILE>)
    {
        if (/^ *(static +)?RADEONCardInfo +RADEONCards\[\] *= *{/)
        {
            $driver = 'radeon';
            last;
        }
    }
    while (<FILE>)
    {
        if (defined($driver))
        {
            if (/^ *{ *0x(....),/)
            {
                my $vendor  = uc(q(1002));
                my $product = uc($1);
                $entries{qq($vendor.$product)} = $driver;
            }
        }
        if (/^ *} *;/)
        {
            $driver = undef;
            last;
        }
    }
    close(FILE);
}
unlink(qq($tmpfile_pciids_txt));

# AMD geode.
{
    my $vendor = q(1022);
    {
        my $driver= q(geode);
        my $product = q(2081);
        $entries{qq($vendor.$product)} = $driver;
    }

}

# Intel.
{
    my $vendor = q(8086);
    {
        my $driver= q(intel_915);
        my $product = q(????);
        $entries{qq($vendor.$product)} = $driver;
    }
    {
        my $driver= q(intel_810);
        foreach my $product (qw(1132 7121 7123 7125))
        {
            $entries{qq($vendor.$product)} = $driver;
        }
    }

}

# NVIDIA.
{
    my $vendor = q(10DE);
    {
        my $driver= q(nvidia);
        my $product = q(????);
        $entries{qq($vendor.$product)} = $driver;
    }
    {
        my $driver= q(nouveau);
	# The Open Source nouveau driver replaces the proprietary NVIDIA 71.86.xx driver.
        foreach my $product (qw(0020 0028 0029 002c 002d 00a0 0100 0101 0103 0150 0151 0152 0153))
        {
            $entries{qq($vendor.$product)} = $driver;
        }
	# The Open Source nouveau driver replaces the proprietary NVIDIA 96.43.xx driver.
        foreach my $product (qw(0110 0111 0112 0113 0170 0171 0172 0173 0174 0175 0176 0177 0178 0179 017a 017c 017d 0181 0182 0183 0185 0188 018a 018b 018c 01a0 01f0 0200 0201 0202 0203 0250 0251 0253 0258 0259 025b 0280 0281 0282 0286 0288 0289 028c))
        {
            $entries{qq($vendor.$product)} = $driver;
        }
	# The Open Source nouveau driver replaces the proprietary NVIDIA 173.14.xx driver.
        foreach my $product (qw(00fa 00fb 00fc 00fd 00fe 0301 0302 0308 0309 0311 0312 0314 031a 031b 031c 0320 0321 0322 0323 0324 0325 0326 0327 0328 032a 032b 032c 032d 0330 0331 0332 0333 0334 0338 033f 0341 0342 0343 0344 0347 0348 034c 034e))
        {
            $entries{qq($vendor.$product)} = $driver;
        }
    }
}

# SiS.
{
    my $vendor = q(1039);
    {
        my $driver= q(sis);
        foreach my $product (qw(6325))
        {
            $entries{qq($vendor.$product)} = $driver;
        }
    }
}

# VMWare.
{
    my $vendor = q(15AD);
    {
        my $driver= q(vmware);
        my $product = q(0405);
        $entries{qq($vendor.$product)} = $driver;
    }
}

if (open(FILE, '>', qq($outfile_udev_rules)))
{
    print FILE qq(#-------------------------------------------------------------------------------\n);
    print FILE qq(# Detect video devices.\n);
    print FILE qq(#\n);
    print FILE qq(# mm_detect_state_video has the following format:\n);
    print FILE qq(#     <driver>\n);
    print FILE qq(# where\n);
    print FILE qq(#     <driver>: The X video driver. Actually, this is the 'Identifier' \(sans the\n);
    print FILE qq(#               'Device_' prefix\) of the 'Device' section in the\n);
    print FILE qq(#               '/etc/xorg.conf' file.\n);
    print FILE qq(#-------------------------------------------------------------------------------\n);
    print FILE qq(ACTION!="add|change|remove", GOTO="end"\n);
    print FILE qq(SUBSYSTEM=="pci", ATTR{class}=="0x0300??", GOTO="begin"\n);
    print FILE qq(GOTO="end"\n);
    print FILE qq(LABEL="begin"\n);
    print FILE qq(\n);
    print FILE qq(ENV{mm_detect_state_video}=""\n);
    print FILE qq(\n);
    print FILE qq(#-------------------------------------------------------------------------------\n);
    print FILE qq(# autogenerated from:\n);
    print FILE qq(# http://cgit.freedesktop.org/mesa/drm/plain/shared-core/drm_pciids.txt\n);
    print FILE qq(# http://cgit.freedesktop.org/xorg/driver/xf86-video-ati/plain/src/radeon_chipinfo_gen.h\n);
    print FILE qq(# built-in nvidia/nv driver information\n);
    print FILE qq(# built-in vmdriver driver information\n);
    print FILE qq(#-------------------------------------------------------------------------------\n);
    print FILE qq(\n);
    my $vendor_previous = undef;
    my @keys = sort
    {
        my ($a_vendor, $a_product) = split(/\./, $a);
        my ($b_vendor, $b_product) = split(/\./, $b);

        if ($a_vendor eq $b_vendor)
        {
            if    ($a_product eq '????') { return -1;                        }
            elsif ($b_product eq '????') { return  1;                        }
            else                         { return $a_product cmp $b_product; }
        }
        else
        {
            return $a_vendor cmp $b_vendor;
        }
    } keys(%entries);
    foreach my $key (@keys)
    {
        if ($key)
        {
            my ($vendor, $product) = split(/\./, $key);
            my $driver = $entries{$key};
            if ((! defined($vendor_previous)) || ($vendor != $vendor_previous))
            {
                if (defined($vendor_previous))
                {
                    print FILE qq(  LABEL="end-$vendor_previous"\n);
                    print FILE qq(\n);
                }
                my $modalias = modalias($vendor, q(????));
                print FILE qq(  ENV{MODALIAS}!="$modalias", GOTO="end-$vendor"\n);
                $vendor_previous = $vendor;
            }
            my $modalias = modalias($vendor, $product);
            print FILE qq(  ENV{MODALIAS}=="$modalias", ENV{mm_detect_state_video}="$driver"\n);

        }
    }
    if (defined($vendor_previous))
    {
        print FILE qq(  LABEL="end-$vendor_previous"\n);
        print FILE qq(\n);
    }
    print FILE qq(# The state has been set, so save it.\n);
    print FILE qq(ENV{mm_detect_state_video}=="?*", RUN+="/lib/udev/mm_detect video %k \$env{mm_detect_state_video}"\n);
    print FILE qq(\n);
    print FILE qq(LABEL="end"\n);
    close(FILE);
  }

1;
