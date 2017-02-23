# класс корабельная техника
package Ship;

use Moose;
extends 'Vehicle';
with 'Mobile';

has 'main_cannon' => (
	is      => 'ro',
    isa     => 'Cannon',
    handles => { cannon_fire => 'shot' }
);

has 'torpedo' => (
	is      => 'ro',
    isa     => 'Torpedo',
    handles => { launch_torpedo => 'shot' }
);

# после создания выходим в море
after 'new' => sub {
    my ( $self ) = @_;
    $self->out_to_sea;
};

# рассчет критического попадания при получении урона
after 'get_damage' => sub {
	
    my ( $self ) = @_;
	
    if ( int( rand(100) ) < 11 ) {
        print 'Пробоина ниже ватерлинии!';
        $self->destroy;
    }
};

# при попытке поехать или полететь уничтожаем корабль
before [qw( move fly )] => sub {
	
    my ( $self ) = @_;
    
    print 'Корабли не летают и не ездят по суше!';
    $self->destroy;
};

sub out_to_sea {
    print 'вышел в море';
};

return 1;
