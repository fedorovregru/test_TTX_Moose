# логика перезарядки магазина
package Reloadable;

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
    
    # если оружие не заряжено, выходим с ошибкой
    if ( $self->magazine_ammo == 0 ) {
        print 'оружие не заряжено!';
        return 0;
    }
    
    $self->magazine_ammo( $self->magazine_ammo - 1 );
    print 'выстрелил';
    return 1;
}

sub reload {
    my ( $self ) = @_;
    
    # возвращаем ноль если боезапас пуст
    if ( $self->ammo_count == 0 ) {
        print 'кончился боезапас!';
        return 0;
    }
    
    # заряжаем полный магазин если боеприпасов на перезаряд оказалось достаточно
    if ( $self->ammo_count >= $self->magazine_size ) {
        $self->ammo_count( $self->ammo_count - $self->magazine_size );
        $self->magazine_ammo( $self->magazine_size );
        print 'перезарядил полный';
        return 1;
    }
    
    # заряжаем неполный магазин если боеприпасов меньше чем размер магазина
    elsif ( $self->ammo_count < $self->magazine_size ) {
        $self->magazine_ammo( $self->ammo_count );
        print 'перезарядил только ' . $self->ammo_count;
        $self->ammo_count(0);
        return 1;
    }
}

return 1;
