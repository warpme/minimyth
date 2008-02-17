#!C:\perl\bin\perl.exe
#!/usr/bin/perl
=Copyright Infomation
==========================================================
Program Name: Mewsoft PerlSharp
Program Author: Elsheshtawy, A. A.
Home Page: http://www.mewsoft.com
File Version: 1.00
Copyrights © 2005 Mewsoft CorpoRatio. All rights reserved.

Mewsoft Provide Full Featured Auction Software, Classifieds Software, Directory 
and Pay Per Click Search Engine Software, Site Builder, Traffic Builder For Every 
Business Size With The Lowest Prices on The Earth To Make Everyone Dreams 
Comes True. Open Source Code in Perl SQL based database to provide the biggest
and fastest solutions ever for our products.
==========================================================
 ==========================================================
 This application is free to use, modify, redistribute provided that you do not change
 anything in the above copyright and advertising information.
=cut
#==========================================================
#This application will reduce most perl modules and scripts by more than 80%
#and will reorganize the code in readable format like that can be produced by
#MS Visual Basic IDE. This application will remove all unnecessary comments,
#POD blocks and extras semicolons at end of lines and will optimize spacing.
#==========================================================
#											Main Start
#==========================================================
$| = 1;
no warnings;
#use CGI::Carp qw(fatalsToBrowser);
#==========================================================
#==========================================================
BEGIN{
	undef %Param;
}
	&MainProcess;
#==========================================================
#==========================================================
sub MainProcess{

	if ($ENV{HTTP_HOST}) {
			$BrowserCall = 1;
			print "Content-type: text/html\n\n";
			use CGI::Carp qw(fatalsToBrowser); 
			eval "use Perl::Tidy;";
			if ($@) { 
					print "Perl module Perl::Tidy is required for this application and it is not installed on this server. Please ask your hosting or server administrator to install it from www.cpan.org http://search.cpan.org/~shancock/Perl-Tidy-20031021/ or by using the ActiveState ppm tool.<br>";
					exit;
			}
	} else {
			$BrowserCall = 0;
			eval "use Perl::Tidy;";
			if ($@) { 
					print "Perl module Perl::Tidy is required for this application and it is not installed on this server. Please ask your hosting or server administrator to install it from www.cpan.org http://search.cpan.org/~shancock/Perl-Tidy-20031021/ or by using the ActiveState ppm tool.<br>";
					exit;
			}

			if (!@ARGV) { 
					&PrintUsage;
					exit;
			}
			
			$TotalSize    = 0;
			$TotalNewSize = 0;
			@Input = @ARGV;
			shift @Input;

			if (lc($ARGV[0]) eq "-p") {
					&OpenLogFile;
					&ProcessInstalledPerl;
					close LogFile;
			}
			elsif (lc($ARGV[0]) eq "-d" && @Input) {
					&OpenLogFile;
					&ProcessSubDirectories(@Input);
					close LogFile;
			}
			elsif (lc($ARGV[0]) eq "-r" && @Input) {
					&OpenLogFile;
					&ProcessDirectories(@Input);
					close LogFile;
			}
			elsif (lc($ARGV[0]) eq "-f" && @Input) {
					&OpenLogFile;
					&ProcessPerlFiles(@Input);
					close LogFile;
			}
			else{
					&PrintUsage;
					exit;
				}
	}

	exit;
}
#==========================================================
sub OpenLogFile{
	print "PerlSharp 1.0 Copyright (c) 2005 Mewsoft Corporation www.mewsoft.com\n\n";
	print "PerlSharp Log will be written to the file PerlSharpLog.txt\n\n";
	open(LogFile, ">PerlSharpLog.txt");
	print LogFile sprintf("  Size     New Size    Ratio                      File\n");
	print sprintf("  Size     New Size    Ratio                      File\n");
}
#==========================================================
sub PrintUsage{
	print "\nUsage:\n\n" .
			$0 ." -p " . "\t\tTo Process current working full Perl installation\n" . 
			$0 ." -d directories..." . "\tTo Process all files in [directories]\n" . 
			$0 ." -r directories..." . "\tTo Process files recursively in [directories]\n".
			$0 ." -f Files..." . "\tTo Process Files\n"; 
}
#==========================================================
sub ProcessPerlFiles {
my (@Files) = @_;
my ($File);
	foreach $File (@Files) {
			&ProcessPerlFile($File);
	}
	$TotalSize ||= 1;
	$Ratio = 100 - int(($TotalNewSize / $TotalSize) * 100);
	print "\nTotal Size: $TotalSize, Total New Size: $TotalNewSize, Total Ratio: $Ratio\%\n";
	print "Done...\n";
	print LogFile "\nTotal Size: $TotalSize, Total New Size: $TotalNewSize, Total Ratio: $Ratio\%\n";
}
#==========================================================
sub ProcessSubDirectories {
my (@Directories) = @_;
my ($Dir, @Files, $CurFile, $File);

	foreach $Dir (@Directories) {
			opendir(DIR, "$Dir") or return undef;
			@Files = readdir(DIR);
			closedir(DIR);
			@Files = sort @Files;
			foreach $File (@Files) {
					$CurFile = "$Dir/$File";
					if (!-d $CurFile && $File ne "." && $File ne ".." && ($File =~ /\.pm$/i || $File =~ /\.pl$/i || $File =~ /\.cgi$/i)) {
								&ProcessPerlFile($CurFile);
					}
			}
	}
	$TotalSize ||= 1;
	$Ratio = 100 - int(($TotalNewSize / $TotalSize) * 100);
	print "\nTotal Size: $TotalSize, Total New Size: $TotalNewSize, Total Ratio: $Ratio\%\n";
	print "Done...\n";
	print LogFile "\nTotal Size: $TotalSize, Total New Size: $TotalNewSize, Total Ratio: $Ratio\%\n";
}
#==========================================================
sub ProcessDirectories {
my (@Directories) = @_;
	
	foreach $Dir (@Directories) {
			&ProcessDirectoryTree($Dir);
	}

	$TotalSize ||= 1;
	$Ratio = 100 - int(($TotalNewSize / $TotalSize) * 100);
	print "\nTotal Size: $TotalSize, Total New Size: $TotalNewSize, Total Ratio: $Ratio\%\n";
	print "Done...\n";
	print LogFile "\nTotal Size: $TotalSize, Total New Size: $TotalNewSize, Total Ratio: $Ratio\%\n";
}
#==========================================================
sub ProcessInstalledPerl {
my ($Dir, $Ratio);

	$TotalSize    = 0;
	$TotalNewSize = 0;
	foreach $Dir (@INC) {
			$Dir =~ s/^\s//g;
			$Dir =~ s/\s$//g;
			if (!$Dir) {next;}
			&ProcessDirectoryTree($Dir);
	}

	$Ratio = 100 - int(($TotalNewSize / $TotalSize) * 100);

	print "\nTotal Size: $TotalSize, Total New Size: $TotalNewSize, Total Ratio: $Ratio\%\n";
	print "Done...\n";
	print LogFile "\nTotal Size: $TotalSize, Total New Size: $TotalNewSize, Total Ratio: $Ratio\%\n";
}
#==========================================================
sub ProcessDirectoryTree {
my ($Directory) = @_;
my (@Directories, @Files, $CurDir, $File, $CurFile);

	undef @Directories;
	undef @Files;

	if (!$Directory) {$Directory = '.';}
	push @Directories, $Directory;

	while (@Directories) {
			$CurDir = shift(@Directories);

			opendir(DIR, "$CurDir") or return undef;
			@Files = readdir(DIR);
			@Files = sort @Files;
			closedir(DIR);

			foreach $File (@Files) {
					$CurFile = "$CurDir/$File";
					if (-d $CurFile && $File ne "." && $File ne "..") {
							push @Directories, $CurFile;
							next;
					} else {
							if ($File ne "." && $File ne ".." && ($File =~ /\.pm$/i || $File =~ /\.pl$/i || $File =~ /\.cgi$/i)) {
										&ProcessPerlFile($CurFile);
							}
					}
			}
	}

}
#==========================================================
sub ProcessPerlFile1 {
my ($File) = @_;
my (@Lines, $OrigSize, $Source, $Argv, $NewSize, $Ratio, @Result, $NewSource);
	
	if (!-f $File) {return;}
	open(F, $File) or return undef;
	@Lines = <F>;
	close F;
	$Source = join "", @Lines;
	$OrigSize = length($Source);
	
	undef @Result;

	$Argv = "-i=0 -ce -l=120 -nbl -pt=2 -bt=2 -sbt=2 -bbt=2 -bvt=1 -sbvt=2 -pvtc=1 -lp -cti=0 -ci=0 -bar -bol  -dac -dbc -dsc -dp";
	perltidy(source => \$Source, destination => \@Result, argv => $Argv);
	
	$NewSource = join ("", @Result);
	$NewSize = length($NewSource);

	if ($NewSize >= $OrigSize) {
			$OrigSize ||= 1;
			$Ratio = 100 - int(($NewSize / $OrigSize) * 100);
			print "Skipped...  Same size \t $File\n";
			print LogFile "Skipped... $OrigSize \t $NewSize \t\t\t $Ratio\% \t $File\n";
			return;
	}

	unlink($File);

	open(F, ">$File") || return undef;
	print F "$NewSource";
	close F;

	$OrigSize ||= 1;
	$Ratio = 100 - int(($NewSize / $OrigSize) * 100);
	$TotalSize    += $OrigSize;
	$TotalNewSize += $NewSize;

	print "$OrigSize \t $NewSize \t $Ratio\% \t $File\n";
	print LogFile "$OrigSize \t $NewSize \t\t\t $Ratio\% \t $File\n";
}
#==========================================================
sub ProcessPerlFile {
my ($File) = @_;
my (@Lines, $NewFile, $OrigSize, $Source, $Argv, $NewSize, $Ratio, @Result, $NewSource);
	
	if (!-f $File) {return;}
	$OrigSize = -s $File;
	$NewFile = $File.".tmp";
	unlink $NewFile;

	$Argv = "-i=0 -ce -l=1024 -nbl -pt=2 -bt=2 -sbt=2 -bbt=2 -bvt=1 -sbvt=2 -pvtc=1 -lp -cti=0 -ci=0 -bar -bol  -dac -dbc -dsc -dp";
	perltidy(source => $File, destination => $NewFile, argv => $Argv);
	
	$NewSize = -s $NewFile;
	rename ($NewFile, $File);
	unlink $NewFile;

	if ($NewSize < $OrigSize) {
		$TotalSize    += $OrigSize;
		$TotalNewSize += $NewSize;
	}

	$OrigSize ||= 1;
	$Ratio = 100 - int(($NewSize / $OrigSize) * 100);
	print sprintf("%8d %8d %8d%  $File\n", $OrigSize, $NewSize, $Ratio);
	print LogFile sprintf("%8d %8d %8d%  $File\n", $OrigSize, $NewSize, $Ratio);
}
#==========================================================
#==========================================================
sub GetForm { 
my ($Buffer, @pair, $key, $value, $pair, $original_value);

	undef %Param;
    $Buffer = "";
	if ($ENV{CONTENT_LENGTH} ) {
				read(STDIN, $Buffer, $ENV{CONTENT_LENGTH});
				@pair=split(/&/, $Buffer);
				$Global{QUERY_STRING} = $Buffer;
    } 
	elsif ($ENV{QUERY_STRING}) {
		        @pair = split(/\\*\&/, $ENV{QUERY_STRING});
				$Global{QUERY_STRING} = $ENV{QUERY_STRING};
    }

    foreach $pair (@pair) {
			($key,$value)= split(/=/,$pair);
			$original_value=$value;
			$value =~ tr/+/ /;
			$value =~ s/%([A-Fa-f0-9]{2})/pack("C", hex($1))/ge;
			$value =~ s/\r$//g;
			$value =~ s/\n$//sg;  
			$key =~ s/\cM$//;

			$key =~ tr/\+/ /;
			$key =~ s/%([A-Fa-f0-9]{2})/pack("C", hex($1))/eg;
			$key =~ s/\r$//g;
			$key =~ s/\n$//g;
			$key =~ s/\cM$//;

			if(!$Param{$key}) {
					$Param{$key} = $value;
					$Paramx{$key}=$original_value;
			}
			else {
  					$Param{$key} = $Param{$key}."||".$value;
					$Paramx{$key}=$Paramx{$key}."||".$original_value;
			 }

	 }

}
#==========================================================
=Options

These are Perl::Tidy module options that can be passed in the $Argv variable 
to the ProcessPerlFile sub routine.

Basic Options:
 -i=n    use n columns per indentation level (default n=4)
 -t      tabs: use one tab character per indentation level, not recommeded
 -nt     no tabs: use n spaces per indentation level (default)
 -et=n   entab leading whitespace n spaces per tab; not recommended
 -io     "indent only": just do indentation, no other formatting.
 -sil=n  set starting indentation level to n;  use if auto detection fails
 -ole=s  specify output line ending (s=dos or win, mac, unix)
 -ple    keep output line endings same as input (input must be filename)

Whitespace Control
 -fws    freeze whitespace; this disables all whitespace changes
           and disables the following switches: 
 -bt=n   sets brace tightness,  n= (0 = loose, 1=default, 2 = tight)
 -bbt    same as -bt but for code block braces; same as -bt if not given
 -bbvt   block braces vertically tight; use with -bl or -bli
 -bbvtl=s  make -bbvt to apply to selected list of block types
 -pt=n   paren tightness (n=0, 1 or 2)
 -sbt=n  square bracket tightness (n=0, 1, or 2)
 -bvt=n  brace vertical tightness, 
         n=(0=open, 1=close unless multiple steps on a line, 2=always close)
 -pvt=n  paren vertical tightness (see -bvt for n)
 -sbvt=n square bracket vertical tightness (see -bvt for n)
 -bvtc=n closing brace vertical tightness: 
         n=(0=open, 1=sometimes close, 2=always close)
 -pvtc=n closing paren vertical tightness, see -bvtc for n.
 -sbvtc=n closing square bracket vertical tightness, see -bvtc for n.
 -ci=n   sets continuation indentation=n,  default is n=2 spaces
 -lp     line up parentheses, brackets, and non-BLOCK braces
 -sfs    add space before semicolon in for( ; ; )
 -aws    allow perltidy to add whitespace (default)
 -dws    delete all old non-essential whitespace 
 -icb    indent closing brace of a code block
 -cti=n  closing indentation of paren, square bracket, or non-block brace: 
         n=0 none, =1 align with opening, =2 one full indentation level
 -icp    equivalent to -cti=2
 -wls=s  want space left of tokens in string; i.e. -nwls='+ - * /'
 -wrs=s  want space right of tokens in string;
 -sts    put space before terminal semicolon of a statement
 -sak=s  put space between keywords given in s and '(';
 -nsak=s no space between keywords in s and '('; i.e. -nsak='my our local'

Line Break Control
 -fnl    freeze newlines; this disables all line break changes
            and disables the following switches:
 -anl    add newlines;  ok to introduce new line breaks
 -bbs    add blank line before subs and packages
 -bbc    add blank line before block comments
 -bbb    add blank line between major blocks
 -sob    swallow optional blank lines
 -ce     cuddled else; use this style: '} else {'
 -dnl    delete old newlines (default)
 -mbl=n  maximum consecutive blank lines (default=1)
 -l=n    maximum line length;  default n=80
 -bl     opening brace on new line 
 -sbl    opening sub brace on new line.  value of -bl is used if not given.
 -bli    opening brace on new line and indented
 -bar    opening brace always on right, even for long clauses
 -vt=n   vertical tightness (requires -lp); n controls break after opening
         token: 0=never  1=no break if next line balanced   2=no break
 -vtc=n  vertical tightness of closing container; n controls if closing
         token starts new line: 0=always  1=not unless list  1=never
 -wba=s  want break after tokens in string; i.e. wba=': .'
 -wbb=s  want break before tokens in string

Following Old Breakpoints
 -boc    break at old comma breaks: turns off all automatic list formatting
 -bol    break at old logical breakpoints: or, and, ||, && (default)
 -bok    break at old list keyword breakpoints such as map, sort (default)
 -bot    break at old conditional (trinary ?:) operator breakpoints (default)
 -cab=n  break at commas after a comma-arrow (=>):
         n=0 break at all commas after =>
         n=1 stable: break unless this breaks an existing one-line container
         n=2 break only if a one-line container cannot be formed
         n=3 do not treat commas after => specially at all

Comment controls
 -ibc    indent block comments (default)
 -isbc   indent spaced block comments; may indent unless no leading space
 -msc=n  minimum desired spaces to side comment, default 4
 -csc    add or update closing side comments after closing BLOCK brace
 -dcsc   delete closing side comments created by a -csc command
 -cscp=s change closing side comment prefix to be other than '## end'
 -cscl=s change closing side comment to apply to selected list of blocks
 -csci=n minimum number of lines needed to apply a -csc tag, default n=6
 -csct=n maximum number of columns of appended text, default n=20 
 -cscw   causes warning if old side comment is overwritten with -csc

 -sbc    use 'static block comments' identified by leading '##' (default)
 -sbcp=s change static block comment identifier to be other than '##'
 -osbc   outdent static block comments

 -ssc    use 'static side comments' identified by leading '##' (default)
 -sscp=s change static side comment identifier to be other than '##'

Delete selected text
 -dac    delete all comments AND pod
 -dbc    delete block comments     
 -dsc    delete side comments  
 -dp     delete pod

Send selected text to a '.TEE' file
 -tac    tee all comments AND pod
 -tbc    tee block comments       
 -tsc    tee side comments       
 -tp     tee pod           

Outdenting
 -olq    outdent long quoted strings (default) 
 -olc    outdent a long block comment line
 -ola    outdent statement labels
 -okw    outdent control keywords (redo, next, last, goto, return)
 -okwl=s specify alternative keywords for -okw command

Other controls
 -mft=n  maximum fields per table; default n=40
 -x      do not format lines before hash-bang line (i.e., for VMS)
 -asc    allows perltidy to add a ';' when missing (default)
 -dsm    allows perltidy to delete an unnecessary ';'  (default)

Combinations of other parameters
 -gnu     attempt to follow GNU Coding Standards as applied to perl
 -mangle  remove as many newlines as possible (but keep comments and pods)
 -extrude  insert as many newlines as possible

Dump and die, debugging
 -dop    dump options used in this run to standard output and quit
 -ddf    dump default options to standard output and quit
 -dsn    dump all option short names to standard output and quit
 -dln    dump option long names to standard output and quit
 -dpro   dump whatever configuRatio file is in effect to standard output
 -dtt    dump all token types to standard output and quit

HTML
 -html write an html file (see 'man perl2web' for many options)
       Note: when -html is used, no indentation or formatting are done.
       Hint: try perltidy -html -css=mystyle.css filename.pl
       and edit mystyle.css to change the appearance of filename.html.
       -nnn gives line numbers
       -pre only writes out <pre>..</pre> code section
       -toc places a table of contents to subs at the top (default)
       -pod passes pod text through pod2html (default)
       -frm write html as a frame (3 files)
       -text=s extra extension for table of contents if -frm, default='toc'
       -sext=s extra extension for file content if -frm, default='src'

A prefix of "n" negates short form toggle switches, and a prefix of "no"
negates the long forms.  For example, -nasc means don't add missing
semicolons.  

Perltidy home page at http://perltidy.sourceforge.net
=cut
#==========================================================
#==========================================================
