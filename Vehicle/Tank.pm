# класс танковая техника
package Tank;

use Modern::Perl;

use Moose;
extends 'Vehicle';
with 'Mobile';


has 'main_cannon' => (
    is      => 'ro',
    isa     => 'Cannon',
    handles => { fire_cannon => 'shot' }
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
        say '[Сдетонировал боекомплект!]';
        $self->destroy;
    }
};

# после попытки полететь, уничтожаем единицу техники
after 'fly' => sub {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    say '[снесло ветром :)!]';
    $self->destroy;
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

# после уничтожения техники, уничтожаем оружие
after 'destroy' => sub {
    my ( $self ) = @_;
    
    $self->main_cannon->destroyed('1');
    $self->machine_gun->destroyed('1');
};

# после создания выходим на позицию
sub BUILD {
    my ( $self ) = @_;
    $self->go_to_tanks_position;
};

sub go_to_tanks_position {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    say '[вышел на позицию]';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
