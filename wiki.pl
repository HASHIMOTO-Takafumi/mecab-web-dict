use strict;
use warnings;
use utf8;

use Encode;

my $input = $ARGV[0];
my $output = $ARGV[1];
my $score = 1;

open(my $I, '<', $input)
	or die "Cannot open $input";
open(my $O, '>', $output)
	or die "Cannot open $output";

# Skip header
<$I>;

while (my $raw = <$I>)
{
	chomp($raw);
	$_ = decode('utf-8', $raw);

	next if length() <= 3;
	next if $_ =~ /[_,]/;
	next if $_ =~ /^\d+$/;
	next if $_ =~ /^[!.]/;
	next if $_ =~ /^日本[のにとで]/;
	next if $_ =~ /^(?:中国|アメリカ|ヨーロッパ)[にの]/;
	next if $_ =~ /(?:一覧|の登場人物)$/;
	next if $_ =~ /^\d+年代?(?:の|$)/;

	print $O encode('utf-8', "$_,0,0,$score,名詞,固有名詞,*,*,*,*,$_,*,*,wikipedia_word\n");
}

close($O);
close($I);

