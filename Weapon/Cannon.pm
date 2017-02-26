# класс оружие пушка
package Cannon;

use Moose;
extends 'Weapon';

no Moose;
__PACKAGE__->meta->make_immutable;
