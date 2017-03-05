# класс корабельная техника
package Ship;

use Modern::Perl;

use Moose;
extends 'Vehicle';
with 'Mobile';

has 'main_cannon' => (
    is      => 'ro',
    isa     => 'Cannon',
    handles => { fire_cannon => 'shot' }
);

has 'torpedo' => (
    is      => 'ro',
    isa     => 'Torpedo',
    handles => { launch_torpedo => 'shot' }
);

# если объект уничтожен выходим со статусом "ноль"
around 'out_to_sea' => sub {
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
        say '[Пробоина ниже ватерлинии!]';
        $self->destroy;
    }
};

# после попытки полететь, уничтожаем единицу техники
after 'fly' => sub {
    my ( $self ) = @_;
    
    say '[снесло ветром :)!]';
    $self->destroy;
};

# после попытки поехать, уничтожаем единицу техники
after 'move' => sub {
    my ( $self ) = @_;
    
    say '[сел на мель!]';
    $self->destroy;
};

# после уничтожения техники, уничтожаем оружие
after 'destroy' => sub {
    my ( $self ) = @_;
    
    $self->main_cannon->is_destroyed('1');
    $self->torpedo->is_destroyed('1');
};

# после создания выходим в море
sub BUILD {
    my ( $self ) = @_;
    $self->out_to_sea;
};

sub out_to_sea {
    say '[вышел в море]';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
