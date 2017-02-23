# класс танковая техника
package Tank;

use Moose;
extends 'Vehicle';
with 'Mobile';


has 'main_cannon' => (
	is      => 'ro',
    isa     => 'Cannon',
    handles => { cannon_fire => 'shot' }
);

has 'machine_gun' => (
	is      => 'ro',
	isa     => 'Machinegun',
	handles => { mg_fire => 'shot' }
);

# после создания выходим на позицию
after 'new' => sub {
    my ( $self ) = @_;
    $self->go_to_tanks_position;
};

# рассчет критического попадания при получении урона
after 'get_damage' => sub {
	
    my ( $self ) = @_;
    
    if ( int( rand(100) ) < 11 ) {  
        print 'Сдетонировал боекомплект!';
        $self->destroy;
    }
};

# перед попыткой полететь или поплыть уничтожаем танк
before [qw( fly sail )] => sub {
	
    my ( $self ) = @_;
    
    print 'Танки не летают и не плавают!';
    $self->destroy;
};

sub go_to_tanks_position {
    print 'вышел на позицию';
};

return 1;
