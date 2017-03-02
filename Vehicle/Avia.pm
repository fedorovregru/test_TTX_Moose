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

# расcчет критического попадания после получения урона
after 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( $self->is_get_critical_damage ) {
        print 'Поврежден двигатель!';
        $self->destroy;
    }
};

# после попытки поплыть, уничтожаем единицу техники
after 'sail' => sub {
    my ( $self ) = @_;
    
    print 'утонул!';
    $self->destroy;
};

# после попытки поехать, уничтожаем единицу техники
after 'move' => sub {
    my ( $self ) = @_;
    
    print 'разбился!';
    $self->destroy;
};

# после создания взлетаем
sub BUILD {
    my ( $self ) = @_;
    $self->takeoff;
};

sub takeoff {
    print 'взлетел';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
