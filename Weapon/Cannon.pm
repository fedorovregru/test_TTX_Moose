# класс оружие пушка
package Cannon;

use Moose;
extends 'Weapon';

# перезаряжаемся после выстрела
after 'shot' => sub {
    my ( $self ) = @_;
    $self->reload;
};

sub reload {
	print 'перезарядился';
}

return 1;
