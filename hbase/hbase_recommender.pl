#!/usr/bin/perl
use Data::Dumper;

$file=$ARGV[0];
open INFILE, "$file" ;
my @data = <INFILE> ;
chomp(@data);
foreach $rec(@data)
{
	if(($rec=~ m/ERROR/) && ($rec =~ m/Found lingering reference file/))
	{
		push(@lingering,$rec);

	}
	if(($rec=~ m/ERROR/) && ($rec =~ m/found in META, but not in HDFS or deployed on any region server/) )
    {
        push(@not_on_any_region,$rec);
    }
	if(($rec=~ m/ERROR/) && ($rec=~ m/but not listed in hbase:meta or deployed on any region server/))
    {
        push(@hds_meta,$rec);
    }
    if(($rec=~ m/ERROR/) && ($rec=~ m/You need to create a new .regioninfo and region dir in hdfs to plug the hole/))
    {
        push(@create_new,$rec);
    }
	if(($rec=~ m/ERROR/) && ($rec=~ m/Multiple regions have the same startkey/))
    {
        my @region_same_key;
        push(@region_same_key,$rec);
    }
}

##lingering refrence gets the most precedence.
if(@lingering!=0)

{
    print "hbase hbck -fixReferenceFiles\n";

}

if(@not_on_any_region!=0)
{

	print "===================================================================\n";
    print "ERROR RESULTS WHERE: Found in META, but not in HDFS or deployed on any region server\n";
    print "===================================================================\n\n";
	my $filename='not_in_hdfs_report.txt';
    print "Please review the details in file: $filename\n";
    print "Please execute the following to fix the issue:\n";
    print "hbase hbck -fixMeta\n\n";

	print `rm -f not_in_hdfs_report.txt`;
	open(my $FILE1, '>>', $filename) or die "could not open file '$filename' $!";
	foreach $rec1(@not_on_any_region)
	{
		my @line= split /,/,$rec1;
		my @liner=split /\{/,$line[0];
		print $FILE1 "$liner[1]";
		print $FILE1 "$line[1]\n";
		print $FILE1 "$line[2]\n";
		print $FILE1 "$line[3]\n";
		my @last_line=split /\}/,$line[4];
		print $FILE1 "$last_line[0]\n";
	}
	close $FILE1;
}

if(@hds_meta!=0)
{
	print `rm -f not_listed_in_hbase_report.txt`;
	my $filename='not_listed_in_hbase_report.txt';
	open(my $FILE2, '>>', $filename) or die "could not open file '$filename' $!";

    print $FILE2 "================================================================================\n";
	print $FILE2 "ERROR RESULTS WHERE: Not listed in Hbase:meta or deployed on any Region Server\n";
	print $FILE2 "================================================================================\n";
	foreach $rec2(@hds_meta)
	{
		my @line1=split /,/,$rec2;
		my @liner1=split /\{/,$line1[0];
		print $FILE2 "$liner1[1]\n";
		print $FILE2 "$line1[1]\n";
		my @last_line1=split /\}/,$line1[2];
		print $FILE2 "$last_line1[0]\n";
	}
	close $FILE2;
}

if(@create_new!=0)
{
	print `rm -f need_to_create_new_region_report.txt`;
    my $filename='need_to_create_new_region_report.txt';
    open(my $FILE3, '>>', $filename) or die "could not open file '$filename' $!";
	print $FILE3 "================================================================================\n";
    print $FILE3 "ERROR RESULTS WHERE: You need to create a new .regioninfo and region dir in hdfs to plug the hole\n";
    print $FILE3 "================================================================================\n";
	foreach $rec3(@create_new)
	{
		my @line2=split /:/,$rec3;
		print $FILE3 "$line2[1]\n";
	}
	close $FILE3;
}

if(@region_same_key!=0)
{
	print `rm -f multiple_region_same_startkey_report.txt`;
    my $filename='multiple_region_same_startkey_report.txt';
    open(my $FILE4, '>>', $filename) or die "could not open file '$filename' $!";
    print $FILE4 "================================================================================\n";
    print $FILE4 "ERROR RESULTS WHERE: Multiple regions have the same startkey\n";
    print $FILE4 "================================================================================\n";
    foreach $rec4(@region_same_key)
    {
		my @line3=split /:/,$rec4;
		print $FILE4 "$line3[1]: $line3[2]\n";
    }
	close $FILE4;
}
