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

## print the error logs if any

if(@error!=0)
{
  print "ERRORS ENCOUNTERED IN THE LOGS: \n";
  print "====================================\n";
  print "@error";
  print "\n ================================== \n";
}

foreach $rec(@fatal)
{
chomp($rec);

    if($rec =~ m/Failed to start namenode/)
	{
	   push(@fail1,$rec);
	}

	elsif($rec =~ m/flush failed for required journal/)
	{
	  push(@fail2,$rec);
        }

	elsif($rec =~ m/Exception in namenode join/)
	{
	  push(@fail3,$rec);
	}
}
if(@fail1!=0|@fail2!=0|@fail3!=0)
{
  print "\n FATAL ERRORS ENCOUNTERED \n";
   print "===============================\n";
}

if(@fail1!=0)
{
  print "Failed to start the namenode\n\n";
           print "@fail1 \n";
}
if(@fail2!=0)
{
  print " NOT ABLE TO GET THE REQURIED JOURNAL \n\n";
  print "@fail2 \n";
      }
if(@fail3!=0)
{
   print "Exception in namenode join\n\n";
   print "@fail3\n";
}
