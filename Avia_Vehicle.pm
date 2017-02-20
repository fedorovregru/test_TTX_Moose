package Avia_Vehicle;

use Moose;
use Rocket;
use Machine_Gun;
extends 'Vehicle';
with 'Mobile';

has 'rockets'     => {
	is      => 'ro',
	default => sub { return Rocket->new( ammo_type => 'Ракета',
		                                 ammo_count => 5 ); }
};

has 'machine_gun' => {
	is      => 'ro',
	default => sub { return Machine_Gun->new( ammo_type => 'Патрон',
		                                      ammo_count => 1000 ); }
};

after 'new' => sub {
    my ( $self ) = @_;
    $self->takeoff;
};

after 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( int( rand(100) ) < 11 ) {
        print 'Поврежден двигатель!';
        $self->destroy;
    }
};

before 'sail' => sub {
    my ( $self ) = @_;
    
    print 'Самолет утонул!';
    $self->destroy;
};

sub takeoff {
    print 'взлетел';
};

return 1;
