# класс артиллерийская техника
package Artillery;

use Modern::Perl;

use Moose;
extends 'Vehicle';
with 'Mobile';

has 'cannon' => (
    is      => 'ro',
    isa     => 'Cannon',
    handles => { fire_cannon => 'shot' }
);

# если объект уничтожен выходим со статусом "ноль"
around 'go_to_artillery_position' => sub {
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
        say '[Подрыв боекомплекта!]';
        $self->destroy;
    }
};

# после попытки полететь, уничтожаем единицу техники
after 'fly' => sub {
    my ( $self ) = @_;
    
    say '[снесло ветром :)!]';
    $self->destroy;
};

# после попытки поплыть, уничтожаем единицу техники
after 'sail' => sub {
    my ( $self ) = @_;
    
    say '[утонул!]';
    $self->destroy;
};

# после уничтожения техники, уничтожаем оружие
after 'destroy' => sub {
    my ( $self ) = @_;
    
    $self->cannon->is_destroyed(1);
};

# после создания выходим на позицию
sub BUILD {
    my ( $self ) = @_;
    $self->go_to_artillery_position;
};

sub go_to_artillery_position {
    say '[вышел на позицию]';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
