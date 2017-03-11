#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 16;
use Test::Exception;

use Data::Dumper;

use_ok( 'Vehicle' );

subtest 'Тест объекта с вручную заданными параметрами' => sub {

    plan tests => 7;
    
    # создаем объект с вручную заданными параметрами
    my $vehicle_unit = Vehicle->new(
        model_name             => 'Test_vehicle',
        armor_thikness         => 1000,
        speed                  => 90,
        durability             => 500,
        critical_damage_chance => 50
    );

    isa_ok( $vehicle_unit, 'Vehicle' );

    # тесты полей объекта при создании с вручную заданными параметрами
    is( $vehicle_unit->model_name,             'Test_vehicle', 'Проверка типа техники.'                        );
    is( $vehicle_unit->armor_thikness,         1000,           'Проверка толщины брони техники.'               );
    is( $vehicle_unit->speed,                  90,             'Проверка скорости техники.'                    );
    is( $vehicle_unit->durability,             500,            'Проверка прочности техники.'                   );
    is( $vehicle_unit->critical_damage_chance, 50,             'Проверка шанса критического урона по технике.' );
    is( $vehicle_unit->is_destroyed,           0,              'Проверка флага уничтоженного объекта.'         );
};

subtest 'Тест объекта с параметрами "по-умолчанию"' => sub {

    plan tests => 7;
    
    # создаем объект с параметрами "по-умолчанию"
    my $vehicle_unit = Vehicle->new(
        model_name     => 'Test_vehicle',
        armor_thikness => 1000,
        speed          => 90,
        durability     => 500
    );

    isa_ok( $vehicle_unit, 'Vehicle' );

    # тесты полей объекта при создании "по-умолчанию"
    is( $vehicle_unit->model_name,             'Test_vehicle', 'Проверка типа техники.'                        );
    is( $vehicle_unit->armor_thikness,         1000,           'Проверка толщины брони техники.'               );
    is( $vehicle_unit->speed,                  90,             'Проверка скорости техники.'                    );
    is( $vehicle_unit->durability,             500,            'Проверка прочности техники.'                   );
    is( $vehicle_unit->critical_damage_chance, 10,             'Проверка шанса критического урона по технике.' );
    is( $vehicle_unit->is_destroyed,           0,              'Проверка флага уничтоженного объекта.'         );
};

# создаем объект с параметрами "по-умолчанию"
my $vehicle_unit = Vehicle->new(
    model_name     => 'Test_vehicle',
    armor_thikness => 1000,
    speed          => 90,
    durability     => 500
);

# проверки наличия методов
can_ok( $vehicle_unit, 'destroy'                );
can_ok( $vehicle_unit, 'get_damage'             );
can_ok( $vehicle_unit, 'is_get_critical_damage' );

# проверка записи некорректных данных в поля объекта
dies_ok { $vehicle_unit->model_name(             150    ) } 'Попытка записи некорректного значения в model_name.';
dies_ok { $vehicle_unit->armor_thikness(         'test' ) } 'Попытка записи некорректного значения в armor_thikness.';
dies_ok { $vehicle_unit->speed(                  'test' ) } 'Попытка записи некорректного значения в speed.';
dies_ok { $vehicle_unit->durability(             'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $vehicle_unit->critical_damage_chance( 'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $vehicle_unit->is_destroyed(           'test' ) } 'Попытка записи некорректного значения в is_destroyed.';

$vehicle_unit->get_damage(1);
is ( $vehicle_unit->durability, 499, 'Проверка прочности техники после получения повреждений.' );

$vehicle_unit->get_damage(499);
is ( $vehicle_unit->is_destroyed, 1, 'Проверка уничтожения техники при получении максимального повреждения.' );

# уничтожаем технику
$vehicle_unit->is_destroyed(1);

# проверки возможности выполнять действия после уничтожения
is ( $vehicle_unit->destroy,    0, 'Проверка попытки уничтожить технику для уже уничтоженного объекта.' );
is ( $vehicle_unit->get_damage, 0, 'Проверка попытки получить повреждения для уничтоженного объекта.'   );
