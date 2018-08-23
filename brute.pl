#!/usr/bin/perl

# Author:
#   Alessandro Cavagni, year 2008

### Modules
use strict;
use warnings;
use Getopt::Long;

### Global vars
my $separator    = "";
my $need_index   = 0;
my $need_help    = 0;
my $must_reverse = 0;

### Cmd line options
GetOptions(
    'sep=s' => \$separator,
    'index' => \$need_index,
    'rev'   => \$must_reverse,
    'help'  => \$need_help,
) or exit(1);

### Main
(my $prgname = $0) =~ s|.*[\/]||;
&usage() if @ARGV < 1 or $need_help;

my @data = ();
for (my $i = 0; @ARGV; $i++) {
    for (split(",", shift(@ARGV))) {
        if (m/(\d)-(\d)/ || m/([a-zA-Z])-([a-zA-Z])/) {
            push(@{$data[$i]}, $1 .. $2);
        }
        else {
            push(@{$data[$i]}, $_);
        }
    }
}

&brute(\@data, $separator, $need_index, $must_reverse);

### Subroutines
sub brute(\@$$) {
    my ($dref, $sep, $index, $rev) = @_;
    my ($nval, @currval) = (1, ());

    for (0 .. $#{$dref}) {
        $currval[$_] = 0;
        $nval *= @{$dref->[$_]};
    }

    my $space   = length($nval);
    my @swtable = &make_switch_table($dref);

    for (my $i = 1; $i <= $nval; $i++) {
        printf(" %${space}d: ", $i) if $index;

        my @row = ();
        for (0 .. $#{$dref}) {
            push(@row, $dref->[$_][ $currval[$_] ]);
            if ($swtable[$_] && (($i % $swtable[$_]) == 0)) {
                $currval[$_] = ($currval[$_] + 1) % @{$dref->[$_]};
            }
        }

	@row = reverse @row if $rev;
        print join($sep, @row), "\n";
    }
}

sub make_switch_table(\@) {
    my $dref = shift;
    my (@swtable, $i) = ((), undef);

    for my $pos (0 .. $#{$dref}) {
        if (@{$dref->[$pos]} > 1) {
            if (defined $i) {
                $swtable[$pos] =  $swtable[$i] * @{$dref->[$i]};
            }
            else {
                $swtable[$pos] = 1;
            }
            $i = $pos;
        }
        else {
            $swtable[$pos] = 0;
        }
    }
    return @swtable;
}

sub usage {
    die <<"EOF"

Usage: $prgname [options] list1 [list2 ...]

This script is used to generate all possible combinations
of the character lists passed as arguments.
list<X> must be a list of characters separated by comma
(or a range specified by - sign) of the <X> output column.

Options must be one of the following:
    --index                    display line number
    --sep    <separator>       use <separator> to catenate lists
    --rev                      reverse each line before print
    --help                     this help

Examples:
    $prgname --sep ' - ' --rev 0,1 0,1 0,1
    $prgname --index 0x 0-9,A-F 0-9,A-F

EOF
}
