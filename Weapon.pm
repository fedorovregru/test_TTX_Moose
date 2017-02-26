# класс оружие
package Weapon;

use Moose;

has 'ammo_type'  => ( is => 'ro', isa => 'Str' );
has 'ammo_count' => ( is => 'rw', isa => 'Num' );

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

after 'new' => sub {
	my ( $self ) = @_;
    #$self->reload;
};

# после выстрела пытаемся перезарядиться если оружие не заряжено
after 'shot' => sub {
	my ( $self ) = @_;
	
    if ( $self->magazine_ammo == 0 ) {

		# если перезарядиться не вышло, выходим с ошибкой
		print 'кончился боезапас!' unless $self->reload;
	}
};

# прицеливаемся
sub aim {
	print 'прицелился';
	return 1;
}

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

no Moose;
__PACKAGE__->meta->make_immutable;
