#!/usr/bin/perl

use Modern::Perl;
use Data::Dumper;

use Vehicle::Tank;
use Weapon::Cannon;
use Weapon::Machinegun;

# тестовый прогон танка

my $tank_01 = Tank->new(
    
    main_cannon    => Cannon->new( ammo_type  => 'Снаряд',
                                   ammo_count => 25 ),
    
    machine_gun    => Machinegun->new( ammo_type     => 'Патрон',
                                       ammo_count    => 2000,
                                       magazine_size => 30 ),
    
    model_name     => 'Т-110',
    armor_thikness => 280,
    speed          => 45,
    durability     => 1000
);

print Dumper $tank_01;

for my $i (0..21) {
    $tank_01->fire_cannon;
}

for my $i (0..1554) {
    $tank_01->fire_machinegun;
}

print Dumper $tank_01;
