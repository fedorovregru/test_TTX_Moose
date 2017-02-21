package Tank_Vehicle;

use Moose;
extends 'Vehicle';
with 'Mobile';


has 'main_cannon' => (
	is  => 'ro',
    isa => 'Cannon'
);

has 'machine_gun' => (
	is  => 'ro',
	isa => 'Machine_Gun'
);


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
