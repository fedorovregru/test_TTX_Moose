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

return 1;
