# класс оружие ракета
package Rocket;

use Moose;
extends 'Weapon';

no Moose;
__PACKAGE__->meta->make_immutable;
