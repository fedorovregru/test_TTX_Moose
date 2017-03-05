# логика перезарядки магазина
package Reloadable;

use Modern::Perl;
use Moose::Role;

has 'magazine_size' => (
    is      => 'ro',
    isa     => 'Num',
    default => 1
);

has 'magazine_ammo' => (
    is      => 'rw',
    isa     => 'Num',
    default => 0
);

# после создания перезаряжаемся
sub BUILD {
    my ( $self ) = @_;
    $self->reload;
};

# переопределяем метод выстрела
sub shot {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    # если оружие не заряжено, выходим с ошибкой
    if ( $self->magazine_ammo == 0 ) {
        say '[оружие не заряжено!]';
        return 0;
    }
    
    $self->magazine_ammo( $self->magazine_ammo - 1 );
    say '[выстрелил]';
    return 1;
}

sub reload {
    my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    # возвращаем ноль если боезапас пуст
    if ( $self->ammo_count == 0 ) {
        say '[кончился боезапас!]';
        return 0;
    }
    
    # заряжаем полный магазин если боеприпасов на перезаряд оказалось достаточно
    if ( $self->ammo_count >= $self->magazine_size ) {
        $self->ammo_count( $self->ammo_count - $self->magazine_size );
        $self->magazine_ammo( $self->magazine_size );
        say '[перезарядил полный]';
        return 1;
    }
    
    # заряжаем неполный магазин если боеприпасов меньше чем размер магазина
    elsif ( $self->ammo_count < $self->magazine_size ) {
        $self->magazine_ammo( $self->ammo_count );
        say '[перезарядил только ' . $self->ammo_count . ' ]';
        $self->ammo_count(0);
        return 1;
    }
}

return 1;
