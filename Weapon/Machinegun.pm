# класс оружие пулемет
package Machinegun;

use Modern::Perl;

use Moose;
extends 'Weapon';
with 'Reloadable';

no Moose;
__PACKAGE__->meta->make_immutable;
