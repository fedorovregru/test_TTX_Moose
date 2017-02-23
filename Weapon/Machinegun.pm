# класс оружие пулемет
package Machinegun;

use Moose;
extends 'Weapon';

has 'magazine'         => ( is => 'ro', isa => 'Num' );
has 'bullets_counter'  => ( is => 'rw', isa => 'Num' );

# после выстрела перезаряжаемся если магазин пуст, уменьшаем патроны в магазине
after 'shot' => sub {
	
    my ( $self ) = @_;
    
    $self->reload if $self->bullets_counter == 0;
    
    $self->bullets_counter( $self->bullets_counter - 1 );
};

sub reload {
	
	my ( $self ) = @_;
	
	$self->bullets_counter( $self->magazine );
	print 'перезарядился';
}

return 1;
