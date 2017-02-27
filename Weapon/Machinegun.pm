# класс оружие пулемет
package Machinegun;

use Moose;
extends 'Weapon';
with 'Reloadable';

has 'magazine_size' => (
    is      => 'ro',
    isa     => 'Num',
    default => 30
);

has 'magazine_ammo' => (
    is      => 'rw',
    isa     => 'Num',
    default => 0
);

# после выстрела пытаемся перезарядиться если оружие не заряжено
after 'shot' => sub {
    my ( $self ) = @_;
	
    if ( $self->magazine_ammo == 0 ) {
        
        # если перезарядиться не вышло, выходим с ошибкой
        print 'кончился боезапас!' unless $self->reload;
    }
};

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
    return 1;
}

no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );
