package Weapon;

use Moose;

has 'ammo_type'  => ( is => 'ro', isa => 'Str' );
has 'ammo_count' => ( is => 'rw', isa => 'Num' );

sub aim {
	print 'прицелился';
}

sub shot {
	my ( $self ) = @_;
	
	die 'выстрел без боеприпаса!' if $self->ammo_count < 1;
	
	$self->ammo_count( $self->ammo_count - 1 );
	print 'выстрелил';
}

return 1;
