#!/usr/bin/perl
use Data::Dumper;
@get_data=`cat abc.txt| grep /apps/hbase/data/data/default/|grep -v "recovered.edits"|awk '{print \$5,\$8}'`;
#print Dumper @get_data;

foreach $rec(@get_data)
{
  	@tester=split / /,$rec;
 	@test1=split /\//,@tester[1];
	chomp(@tester[0]);
	chomp(@test1[9]);
	chomp(@test1[8]);
	chomp(@test1[9]);
	chomp(@test1[7]);

	push(@register,@test1[7]);
	if(@test1[9]!=0)
	{
## Defining a hash where @test1[9]= hfile, @test1[8]=column family, @test1[6] = table name and @test1[7]=region
		$var="0057a622309b0dc0673631cc6919e95d";
		$var1="c";
#print Dumper @test1[8];
#	print Dumper @test1[8];
		if(@test1[7]=~/$var/ && @test1[8] =~/$var1/)
		{

			print "Region: @test1[7]\n";
			print "column file @test1[8]\n";
	        push(@sizeofcf,@tester[0]);
#print Dumper \@sizeofcf;
		}
	}
}
#print Dumper \@register;
print Dumper \@sizeofcf;
$sum = eval join '+', @sizeofcf;
print "total size is  : $sum\n";
