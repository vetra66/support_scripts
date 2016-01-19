#!/usr/bin/perl

use Data::Dumper;

$log=$ARGV[1];

@arr= `cut -d " " -f 2 $log | cut -d "," -f 1 | uniq -c`;
chomp(@arr);
#print Dumper (@arr);

foreach $rec(@arr)
{
    $rec =~ s/^\s+//;
    @arr1=split / /,$rec;
    chomp(@arr1[0]);
    chomp(@arr1[1]);
# print Dumper(@arr1[0]);
    if(@arr1[0] >16 && @arr1[1])
    {
        $var="@arr1[0] => @arr1[1]";
        print "$var\n";
#       push(@new_tr,$var);
    }
}
