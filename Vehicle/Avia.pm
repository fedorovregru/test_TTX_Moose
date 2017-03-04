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

# расcчет критического попадания после получения урона
after 'get_damage' => sub {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
		say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    if ( $self->is_get_critical_damage ) {
        say '[Поврежден двигатель!]';
        $self->destroy;
    }
};

# после попытки поплыть, уничтожаем единицу техники
after 'sail' => sub {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
		say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    say '[утонул!]';
    $self->destroy;
};

# после попытки поехать, уничтожаем единицу техники
after 'move' => sub {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
		say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    say '[разбился!]';
    $self->destroy;
};

# после уничтожения техники, уничтожаем оружие
after 'destroy' => sub {
    my ( $self ) = @_;
    
    $self->rockets->destroyed('1');
    $self->machine_gun->destroyed('1');
};

# после создания взлетаем
sub BUILD {
    my ( $self ) = @_;
    $self->takeoff;
};

sub takeoff {
	my ( $self ) = @_;
	
	# если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
		say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
	
    say '[взлетел]';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
