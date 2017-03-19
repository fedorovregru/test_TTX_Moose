# класс авиа техника
package Avia;

use Modern::Perl;

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

# если объект уничтожен выходим со статусом "ноль"
around 'takeoff' => sub {
    my $orig = shift;
    my $self = shift;
    
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    $self->$orig;
};

# расcчет критического попадания после получения урона
after 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( $self->is_get_critical_damage ) {
        say '[Поврежден двигатель!]';
        $self->destroy;
    }
};

# после попытки поплыть, уничтожаем единицу техники
after 'sail' => sub {
    my ( $self ) = @_;
    
    say '[утонул!]';
    $self->destroy;
};

# после попытки поехать, уничтожаем единицу техники
after 'move' => sub {
    my ( $self ) = @_;
    
    say '[разбился!]';
    $self->destroy;
};

# после уничтожения техники, уничтожаем оружие
after 'destroy' => sub {
    my ( $self ) = @_;
    
    $self->rockets->is_destroyed('1');
    $self->machine_gun->is_destroyed('1');
};

# после создания взлетаем
sub BUILD {
    my ( $self ) = @_;
    $self->takeoff;
};

sub takeoff {
    say '[взлетел]';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
