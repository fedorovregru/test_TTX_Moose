# класс оружие пушка
package Cannon;

use Modern::Perl;

use Moose;
extends 'Weapon';
with 'Reloadable';

no Moose;
__PACKAGE__->meta->make_immutable;
