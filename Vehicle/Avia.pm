# класс авиа техника
package Avia;

use Moose;
extends 'Vehicle';
with 'Mobile';

has 'rockets'     => (
	is  => 'ro',
	isa => 'Rocket'
);

has 'machine_gun' => (
	is  => 'ro',
	isa => 'Machinegun'
);

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
