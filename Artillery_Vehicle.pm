package Artillery_Vehicle;

use Moose;
use Cannon;
extends 'Vehicle';
with 'Mobile';

has 'cannon' => {
	is      => 'ro',
    default => sub { return Cannon->new( ammo_type => 'Снаряд',
		                                 ammo_count => 100 ); }	
};

after 'new' => sub {
    my ( $self ) = @_;
    $self->go_to_arty_position;
};

before [qw( fly sail )] => sub {
    my ( $self ) = @_;
    
    print 'Артиллеристы не летают и не плавают!';
    $self->destroy;
};

sub go_to_arty_position {
    print 'вышел на позицию';
};

return 1;
