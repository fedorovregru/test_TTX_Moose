#!/usr/bin/perl

use Modern::Perl;
use Test::More qw( no_plan );

use Data::Dumper;

use_ok( 'Weapon::Cannon'     );
use_ok( 'Weapon::Machinegun' );
use_ok( 'Vehicle::Artillery' );

my $artillery_unit = Artillery->new(

    cannon         => Cannon->new( ammo_type  => 'Снаряд',
                                   ammo_count => 30 ),
    
    model_name     => 'AR-19-75',
    armor_thikness => 120,
    speed          => 30,
    durability     => 800
);
say '';

isa_ok( $artillery_unit, 'Artillery' );

is_deeply( $artillery_unit->cannon, { ammo_type     => 'Снаряд',
                                      ammo_count    => 29,
                                      magazine_size => 1,
                                      magazine_ammo => 1 },
                                    'Орудие "пушка" присутствует' );

is( $artillery_unit->model_name,     'AR-19-75', 'Проверка названия модели' );
is( $artillery_unit->armor_thikness, 120,        'Проверка толщины брони'   );
is( $artillery_unit->speed,          30,         'Проверка скорости'        );
is( $artillery_unit->durability,     800,        'Проверка прочности'       );

can_ok( $artillery_unit, 'BUILD' );
can_ok( $artillery_unit, 'destroy' );
can_ok( $artillery_unit, 'fire_cannon' );
can_ok( $artillery_unit, 'fly' );
can_ok( $artillery_unit, 'get_damage' );
can_ok( $artillery_unit, 'go_to_artillery_position' );
can_ok( $artillery_unit, 'is_get_critical_damage' );
can_ok( $artillery_unit, 'move' );
can_ok( $artillery_unit, 'sail' );
