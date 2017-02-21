#!/usr/bin/perl

use Modern::Perl;
use Data::Dumper;

use Tank_Vehicle;
use Cannon;
use Machine_Gun;

my $tank_01 = Tank_Vehicle->new(
    
    main_cannon    => Cannon->new( ammo_type =>  'Снаряд',
                                   ammo_count => 25 ),
    
    machine_gun    => Machine_Gun->new( ammo_type       =>  'Патрон',
                                        ammo_count      => 2000,
                                        magazine        => 30,
                                        bullets_counter => 30 ),
    
    model_name     => 'Т-110',
    armor_thikness => 280,
    speed          => 45,
    durability     => 1000
);

print Dumper $tank_01;

for my $i (0..21) {
    $tank_01->main_cannon->shot;
}

for my $i (0..1554) {
    $tank_01->machine_gun->shot;
}

print Dumper $tank_01;
