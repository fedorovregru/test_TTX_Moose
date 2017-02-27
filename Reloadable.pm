# логика перезарядки магазина
package Reloadable;

use Moose::Role;

sub reload {
    my ( $self ) = @_;
    
    # возвращаем ноль если боезапас пуст
    return 0 if $self->ammo_count == 0;
    
    # заряжаем полный магазин если боеприпасов на перезаряд оказалось достаточно
    if ( $self->ammo_count >= $self->magazine_size ) {
        $self->ammo_count( $self->ammo_count - $self->magazine_size );
        $self->magazine_ammo( $self->magazine_size );
        return 1;
    }
    
    # заряжаем неполный магазин если боеприпасов меньше чем размер магазина
    elsif ( $self->ammo_count < $self->magazine_size ) {
        $self->magazine_ammo( $self->ammo_count );
        $self->ammo_count(0);
        return 1;
    }
}

return 1;
