# класс авиа техника
package Avia;

use Moose;
extends 'Vehicle';
with 'Mobile';

has 'rockets'     => (
	is      => 'ro',
	isa     => 'Rocket',
	handles => { launch_rocket => 'shot' }
);

has 'machine_gun' => (
	is      => 'ro',
	isa     => 'Machinegun',
	handles => { mg_fire => 'shot' }
);

# после создания взлетаем
after 'new' => sub {
    my ( $self ) = @_;
    $self->takeoff;
};

# рассчет критического попадания после получения урона
after 'get_damage' => sub {
	
    my ( $self ) = @_;
    
    if ( int( rand(100) ) < 11 ) {
        print 'Поврежден двигатель!';
        $self->destroy;
    }
};

# перед попыткой поплыть или поехать - уничтожаемся
before [qw( move sail )] => sub {
	
    my ( $self ) = @_;
    
    print 'Самолет утонул!';
    $self->destroy;
};

sub takeoff {
    print 'взлетел';
};

return 1;
