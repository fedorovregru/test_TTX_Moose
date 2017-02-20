package Tank_Vehicle;

use Moose;

extends 'Vehicle';

after 'new' => sub {
    
    my ( $self ) = @_;
    
    $self->go_to_tanks_position;
};

after 'get_damage' => sub {
    
    my ( $self ) = @_;
    
    if ( int( rand(100) ) < 11 ) {
        
        print "Сдетонировал боекомплект!";
        $self->destroy;
    }
};

sub go_to_tanks_position {
    return 1;
};

