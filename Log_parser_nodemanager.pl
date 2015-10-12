#!/usr/bin/perl

use Getopt::Long;
use Data::Dumper;

my $file;

GetOptions(
	'file=s' => \$file
	) or die "Usage: $0 --file NAME \n";

open INFILE, "$file" ;
my @data = <INFILE> ;
chomp @data;

foreach $element (@data)
{
## Searching for error patterns

       if (($element =~ m/error/)| ($element =~ m/ERROR/))
	{
		push(@error,$element);
	}
## FATAL encountered in the logs
	if ($element =~ /FATAL/)
	{
    push(@fatal,$element);
	}
}
foreach $rec(@fatal)
{
  chomp($rec);
  if($rec =~ m/Failed to start namenode/)
  {
    print "Failed to start the namenode\n";
    print $rec;
   }
  if($rec =~ m/flush failed for required journal/)
  {
    print "Flush failed,not able to get the required Journal \n";
    print $rec;
    print "\n";
  }
  elsif($rec =~ m/Exception in namenode join/)
  {
    print "Exception in namenode join\n";
    print "$rec";
  }
}
