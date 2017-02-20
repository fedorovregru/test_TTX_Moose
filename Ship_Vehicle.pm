package Ship_Vehicle;

use Moose;
use Cannon;
use Torpedo;
extends 'Vehicle';
with 'Mobile';

has 'main_cannon' => {
	is      => 'ro',
    default => sub { return Cannon->new( ammo_type => 'Снаряд',
		                                 ammo_count => 100 ); }	
};

has 'torpedo' => {
	is      => 'ro',
    default => sub { return Torpedo->new( ammo_type => 'Торпеда',
		                                  ammo_count => 8 ); }	
};

after 'new' => sub {
    my ( $self ) = @_;
    $self->out_to_sea;
};

after 'get_damage' => sub {
    my ( $self ) = @_;
	
    if ( int( rand(100) ) < 11 ) {
        print 'Пробоина ниже ватерлинии!';
        $self->destroy;
    }
};

before [qw( move fly )] => sub {
    my ( $self ) = @_;
    
    print 'Корабли не летают и ездят по суше!';
    $self->destroy;
};

sub out_to_sea {
    print 'вышел в море';
};

return 1;
