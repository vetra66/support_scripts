### Wrote the script to massage the data for the customer.

#!/usr/bin/perl

$command="ls /root/cases/case_00055296/";
@test=`$command`;

foreach $rec(@test)
{
   chomp($rec);
   $file=$rec."."."txt";
   $comm="sed -e '/#Software:/d' -e '/#Version/d' -e '/#Fields:/d' -e '/#Date:/d'  $rec > /root/cases/case_00055296/$file";
   print "$comm\n";
   $execute=`$comm`;
   print "file successfully updated and $file created\n";
}
