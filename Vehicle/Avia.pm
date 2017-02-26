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
	handles => { fire_machinegun => 'shot' }
);

# после создания взлетаем
after 'new' => sub {
    my ( $self ) = @_;
    $self->takeoff;
};

# рассчет критического попадания перед получением урона
before 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( $self->is_get_critical_damage ) {
        print 'Поврежден двигатель!';
        $self->durability = 0;
    }
};

# после попытки поплыть или поехать - уничтожаемся
after [qw( move sail )] => sub {
    my ( $self ) = @_;
    
    print 'Самолет разбился!';
    $self->destroy;
};

sub takeoff {
    print 'взлетел';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
