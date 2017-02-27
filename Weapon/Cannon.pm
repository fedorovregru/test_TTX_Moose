# класс оружие пушка
package Cannon;

use Data::Dumper;

use Moose;
extends 'Weapon';
with 'Reloadable';

# после выстрела пытаемся перезарядиться если оружие не заряжено
after 'shot' => sub {
    my ( $self ) = @_;
	
    return ( !$self->magazine_ammo && !$self->reload ) ? 0 : 1;
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
    return 1;
}

no Moose;
__PACKAGE__->meta->make_immutable;
