# класс оружие торпеда
package Torpedo;

use Moose;
extends 'Weapon';

no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );
