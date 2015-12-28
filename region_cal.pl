use Data::Dumper;
use Math::Round;

my $f = 'abc.txt';
open (F, "<", $f);

open (R, ">temp");

my  %data_hash;

while (<F>) {
    my $line = $_;
    chomp $line;
#print "$line";
    if($line =~ m/(\/[\w]*){8,}/)
    {
        @line_arr = split ('\s+', $line);
        @curr_keys = split ('/', $line_arr[7]);
        $data_hash{$curr_keys[8]} += $line_arr[4];
    }

}


foreach my $key (keys(%data_hash))
{
$val_in_mb=$data_hash{$key};
$val=$val_in_mb/1024;
my $rounded = round( $val );
#   print R  "$key : $data_hash{$key} \n";
print   "$key : $rounded \n";
}
