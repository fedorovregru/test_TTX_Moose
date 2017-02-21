package Ship_Vehicle;

use Moose;
extends 'Vehicle';
with 'Mobile';

has 'main_cannon' => (
	is  => 'ro',
    isa => 'Cannon'
);

has 'torpedo' => (
	is  => 'ro',
    isa => 'Torpedo'
);

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
