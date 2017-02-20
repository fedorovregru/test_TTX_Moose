# Пушка
package Cannon;

use Moose;
extends 'Weapon';

after 'shot' => sub {
    my ( $self ) = @_;
    $self->reload;
};

sub reload {
	print 'перезарядился';
}

no Moose;
__PACKAGE__->meta->make_immutable;


# Пулемет
package Machine_Gun;

use Moose;
extends 'Weapon';

has 'magazine'         => ( is => 'ro', isa => 'Num' );
has 'bullets_counter'  => ( is => 'rw', isa => 'Num' );

after 'shot' => sub {
    my ( $self ) = @_;
    
    $self->reload if $self->bullets_counter == 0;
    
    $self->bullets_counter( $self->bullets_counter - 1 );
    
};

sub reload {
	$self->bullets_counter( $self->magazine );
	print 'перезарядился';
}

no Moose;
__PACKAGE__->meta->make_immutable;


# Ракета
package Rocket;

use Moose;
extends 'Weapon';

no Moose;
__PACKAGE__->meta->make_immutable;


# Торпеда
package Torpedo;

use Moose;
extends 'Weapon';

no Moose;
__PACKAGE__->meta->make_immutable;
