#!/usr/bin/perl
use Data::Dumper;

$log="/Users/singla/Downloads/hdfs-audit_trimmed.log";
@arr= `cut -d " " -f 2 $log | cut -d "," -f 1 | uniq -c`;
chomp(@arr);
foreach $rec(@arr)
{
  @arr1=split / /,$rec;
  chomp(@arr1[0]);
  if(@arr1[0] >14000 && @arr1[1])
  {
    $var="@arr1[0] => @arr1[1]";
    print "$var\n";
  }
}
