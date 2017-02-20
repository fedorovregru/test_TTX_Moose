package Tank_Vehicle;

use Moose;
use Cannon;
use Machine_Gun;
extends 'Vehicle';
with 'Mobile';


has 'main_cannon' => {
	is      => 'ro',
	default => sub { return Cannon->new( ammo_type => 'Снаряд',
		                                 ammo_count => 30 ); }	
};

has 'machine_gun' => {
	is      => 'ro',
	default => sub { return Machine_Gun->new( ammo_type => 'Патрон',
		                                      ammo_count => 1000 ); }
};


after 'new' => sub {
    my ( $self ) = @_;
    $self->go_to_tanks_position;
};

after 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( int( rand(100) ) < 11 ) {  
        print 'Сдетонировал боекомплект!';
        $self->destroy;
    }
};

before [qw( fly sail )] => sub {
    my ( $self ) = @_;
    
    print 'Танки не летают и не плавают!';
    $self->destroy;
};

sub go_to_tanks_position {
    print 'вышел на позицию';
};

return 1;
