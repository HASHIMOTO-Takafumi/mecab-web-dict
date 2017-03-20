use strict;
use warnings;
use utf8;

use Encode;
use PerlIO::encoding;

my $input = $ARGV[0];
my $output = $ARGV[1];
my $score = 1;

open(my $I, '<:encoding(eucjp)', $input)
	or die "Cannot open $input";
open(my $O, '>', $output)
	or die "Cannot open $output";

while (<$I>)
{
	chomp;

	s/^\s+//;

	my $yomi = "*";
	$yomi = $1 if s/^([^\t]+)\t(.+)$/$2/;

	next if length() <= 3;
	next if $_ =~ /,/;
	next if $_ =~ /^[\d\-]+$/;
	next if $_ =~ /^[!.]/;
	next if $_ =~ /^\d+年代?(?:の|$)/;

	print $O encode('utf-8', "$_,0,0,$score,名詞,固有名詞,*,*,*,*,$_,$yomi,$yomi,hatena_word\n");
}

close($O);
close($I);

