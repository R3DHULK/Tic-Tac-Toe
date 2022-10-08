use strict; use warnings;

my @cells;

my %valid_input = map { $_ => undef } (1..9);

my $who_has_turn = 1;  # 1 or 2, for player 1 or 2, respectively

my %str = (
	prompt => sub { "              Player $_[0]'s turn: " },
	win => sub { "           Player $_[0] is the winner!\n" },
	tie => "           Tie! No player has won!\n",
	header => "        Player 1 (O) v/s Player 2 (X)\n\n",
        head => "             modified by R3DHULK \n",
	# drawing the board
	cover => " ___ ___ ___ \n",
	walls => "|   |   |   |\n",
	floor => "|___|___|___|\n",
	cells => sub { "| $_[0] | $_[1] | $_[2] |\n" },
	leading_space => "                ",
	1 => "\e[1;34mO\e[m",
	2 => "\e[1;33mX\e[m",
);

while(1) { print_board(); prompt(); check_winner(); }

sub print_board
{
	clear_screen();
	print $str{header};
        print $str{head};
	local *val = sub {
		my $c = $cells[$_[0]];
		return (defined $c) ? $str{$c} : $_[0] + 1;
	};
	print
		$str{leading_space}, $str{cover},
		$str{leading_space}, $str{walls},
		$str{leading_space}, $str{cells}(val(6), val(7), val(8)),
		$str{leading_space}, $str{floor},
		$str{leading_space}, $str{walls},
		$str{leading_space}, $str{cells}(val(3), val(4), val(5)),
		$str{leading_space}, $str{floor},
		$str{leading_space}, $str{walls},
		$str{leading_space}, $str{cells}(val(0), val(1), val(2)),
		$str{leading_space}, $str{floor}, "\n";
}

sub prompt
{
	my $res;
	do {
		print $str{prompt}($who_has_turn);
		$res = scalar(<>);  chomp($res);
	} until (exists $valid_input{$res});
	delete $valid_input{$res};
	$cells[$res - 1] = $who_has_turn;
	$who_has_turn = 2 - $who_has_turn + 1;  # swap 1 and 2
}

sub check_winner
{
	my $w;
	# rows:
	if    ($w = check_cells(0, 1, 2)) { finish($str{win}($w)) }
	elsif ($w = check_cells(3, 4, 5)) { finish($str{win}($w)) }
	elsif ($w = check_cells(6, 7, 8)) { finish($str{win}($w)) }
	# columns:
	elsif ($w = check_cells(0, 3, 6)) { finish($str{win}($w)) }
	elsif ($w = check_cells(1, 4, 7)) { finish($str{win}($w)) }
	elsif ($w = check_cells(2, 5, 8)) { finish($str{win}($w)) }
	# diagonals:
	elsif ($w = check_cells(0, 4, 8)) { finish($str{win}($w)) }
	elsif ($w = check_cells(2, 4, 6)) { finish($str{win}($w)) }
	# if no winner and board is full:
	else { if (is_board_full()) { finish($str{tie}) } }
}

sub check_cells
{
	my ($a, $b, $c) = ($cells[$_[0]], $cells[$_[1]], $cells[$_[2]]);
	return 0 unless (defined $a && defined $b && defined $c);
	return ($a == $b && $b == $c)? $a : 0;
}

sub finish { print_board(); printf $_[0]; exit(); } #prompt_new_game() #TODO
sub is_board_full { scalar(grep { defined $_ } @cells) == 9 }
sub clear_screen { print "\e[2J\e[H" }
