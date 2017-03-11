#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 12;
use Test::Exception;

use Data::Dumper;

use_ok( 'Weapon' );

subtest 'Тест объекта с вручную заданными параметрами' => sub {

    plan tests => 4;
    
    # создаем объект с вручную заданными параметрами
    my $weapon_unit = Weapon->new(
        ammo_type    => 'Снаряд',
        ammo_count   => 30,
        is_destroyed => 1
    );

    isa_ok( $weapon_unit, 'Weapon' );

    is( $weapon_unit->ammo_type,    'Снаряд', 'Проверка типа боезапаса.'              );
    is( $weapon_unit->ammo_count,   30,       'Проверка количества боезапаса.'        );
    is( $weapon_unit->is_destroyed, 1,        'Проверка флага уничтоженного объекта.' );
};

subtest 'Тест объекта с параметрами по-умолчанию' => sub {

    plan tests => 4;
    
    # создаем объект с параметрами по-умолчанию
    my $weapon_unit = Weapon->new(
        ammo_type  => 'Снаряд',
        ammo_count => 30
    );

    isa_ok( $weapon_unit, 'Weapon' );

    is( $weapon_unit->ammo_type,    'Снаряд', 'Проверка типа боезапаса.'              );
    is( $weapon_unit->ammo_count,   30,       'Проверка количества боезапаса.'        );
    is( $weapon_unit->is_destroyed, 0,        'Проверка флага уничтоженного объекта.' );
};

# создаем объект с параметрами по-умолчанию
my $weapon_unit = Weapon->new(
    ammo_type  => 'Снаряд',
    ammo_count => 30
);

# проверки наличия методов
can_ok( $weapon_unit, 'aim'  );
can_ok( $weapon_unit, 'shot' );

# проверка записи некорректных данных в поля объекта
dies_ok { $weapon_unit->ammo_type(    150    ) } 'Попытка записи некорректного значения в ammo_type.';
dies_ok { $weapon_unit->ammo_count(   'test' ) } 'Попытка записи некорректного значения в ammo_count.';
dies_ok { $weapon_unit->is_destroyed( 'test' ) } 'Попытка записи некорректного значения в is_destroyed.';

$weapon_unit->shot;
is ( $weapon_unit->ammo_count, 29, 'Проверка боезапаса орудия после одного выстрела.' );

# опустошаем боезапас
$weapon_unit->ammo_count(0);
is ( $weapon_unit->shot, 0, 'Проверка выстрела при отсутствующем боезапасе.' );

# возвращаем заряд в магазин, для дальнейшей проверки
$weapon_unit->ammo_count(1);

# уничтожаем орудие
$weapon_unit->is_destroyed(1);

# проверки возможности выполнять действия после уничтожения
is ( $weapon_unit->aim,  0, 'Проверка попытки прицелиться для уже уничтоженного объекта.' );
is ( $weapon_unit->shot, 0, 'Проверка попытки выстрелить для уничтоженного объекта.'      );
