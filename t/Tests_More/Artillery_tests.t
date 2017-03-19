#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 31;
use Test::Exception;

use Data::Dumper;

use_ok( 'Vehicle::Artillery' );
use_ok( 'Weapon::Cannon'     );

subtest 'Тест объекта с вручную заданными параметрами' => sub {

    plan tests => 13;
    
    # создаем объект с вручную заданными параметрами
    my $artillery_unit = Artillery->new(
    
        cannon => Cannon->new(
            ammo_type     => 'Снаряд',
            ammo_count    => 50,
            magazine_size => 2,
            magazine_ammo => 0,
            is_destroyed  => 1
        ),

        model_name             => 'Artillery',
        armor_thikness         => 100,
        speed                  => 40,
        durability             => 800,
        critical_damage_chance => 50,
        is_destroyed           => 1
    );

    isa_ok( $artillery_unit,         'Artillery' );
    isa_ok( $artillery_unit->cannon, 'Cannon'    );

    # тесты полей объекта при создании с вручную заданными параметрами
    is( $artillery_unit->cannon->ammo_type,     'Снаряд', 'Проверка типа боезапаса орудия "пушка".'                  );
    is( $artillery_unit->cannon->ammo_count,    50,       'Проверка количества боезапаса орудия "пушка".'            );
    is( $artillery_unit->cannon->magazine_size, 2,        'Проверка размера магазина орудия "пушка".'                );
    is( $artillery_unit->cannon->magazine_ammo, 0,        'Проверка количества боезапаса в магазине орудия "пушка".' );
    is( $artillery_unit->cannon->is_destroyed,  1,        'Проверка флага уничтоженного орудия "пушка".'             );
    
    is( $artillery_unit->model_name,             'Artillery', 'Проверка типа техники.'                        );
    is( $artillery_unit->armor_thikness,         100,         'Проверка толщины брони техники.'               );
    is( $artillery_unit->speed,                  40,          'Проверка скорости техники.'                    );
    is( $artillery_unit->durability,             800,         'Проверка прочности техники.'                   );
    is( $artillery_unit->critical_damage_chance, 50,          'Проверка шанса критического урона по технике.' );
    is( $artillery_unit->is_destroyed,           1,           'Проверка флага уничтоженного объекта.'         );
};

subtest 'Тест объекта с параметрами по-умолчанию' => sub {

    plan tests => 13;
    
    # создаем объект с параметрами по-умолчанию
    my $artillery_unit = Artillery->new(
    
        cannon => Cannon->new(
            ammo_type     => 'Снаряд',
            ammo_count    => 50
        ),

        model_name     => 'Artillery',
        armor_thikness => 100,
        speed          => 40,
        durability     => 800
    );

    isa_ok( $artillery_unit,         'Artillery' );
    isa_ok( $artillery_unit->cannon, 'Cannon'    );

    # тесты полей объекта при создании с параметрами по-умолчанию
    is( $artillery_unit->cannon->ammo_type,     'Снаряд', 'Проверка типа боезапаса орудия "пушка".'                  );
    is( $artillery_unit->cannon->ammo_count,    49,       'Проверка количества боезапаса орудия "пушка".'            );
    is( $artillery_unit->cannon->magazine_size, 1,        'Проверка размера магазина орудия "пушка".'                );
    is( $artillery_unit->cannon->magazine_ammo, 1,        'Проверка количества боезапаса в магазине орудия "пушка".' );
    is( $artillery_unit->cannon->is_destroyed,  0,        'Проверка флага уничтоженного орудия "пушка".'             );
    
    is( $artillery_unit->model_name,             'Artillery', 'Проверка типа техники.'                        );
    is( $artillery_unit->armor_thikness,         100,         'Проверка толщины брони техники.'               );
    is( $artillery_unit->speed,                  40,          'Проверка скорости техники.'                    );
    is( $artillery_unit->durability,             800,         'Проверка прочности техники.'                   );
    is( $artillery_unit->critical_damage_chance, 10,          'Проверка шанса критического урона по технике.' );
    is( $artillery_unit->is_destroyed,           0,           'Проверка флага уничтоженного объекта.'         );
};

# создаем тестовый объект
my $artillery_unit = Artillery->new(

    cannon => Cannon->new(
        ammo_type     => 'Снаряд',
        ammo_count    => 50
    ),

    model_name     => 'Artillery',
    armor_thikness => 100,
    speed          => 40,
    durability     => 800
);

# проверки наличия методов
can_ok( $artillery_unit->cannon, 'aim'    );
can_ok( $artillery_unit->cannon, 'shot'   );
can_ok( $artillery_unit->cannon, 'reload' );
can_ok( $artillery_unit->cannon, 'BUILD'  );

can_ok( $artillery_unit, 'fire_cannon' );

can_ok( $artillery_unit, 'BUILD'                    );
can_ok( $artillery_unit, 'go_to_artillery_position' );

can_ok( $artillery_unit, 'move' );
can_ok( $artillery_unit, 'fly'  );
can_ok( $artillery_unit, 'sail' );

# проверка записи некорректных данных в поля объекта
dies_ok { $artillery_unit->model_name(             150    ) } 'Попытка записи некорректного значения в model_name.';
dies_ok { $artillery_unit->armor_thikness(         'test' ) } 'Попытка записи некорректного значения в armor_thikness.';
dies_ok { $artillery_unit->speed(                  'test' ) } 'Попытка записи некорректного значения в speed.';
dies_ok { $artillery_unit->durability(             'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $artillery_unit->critical_damage_chance( 'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $artillery_unit->is_destroyed(           'test' ) } 'Попытка записи некорректного значения в is_destroyed.';

# проверяем уничтожение артиллерийской техники при попытке поплыть
$artillery_unit->sail;
is ( $artillery_unit->is_destroyed, 1, 'Проверка попытки поплавать на артиллерийской технике.' );

# "воскрешаем" артиллерийскую технику для дальнейшей проверки
$artillery_unit->is_destroyed(0);

# проверяем уничтожение артиллерийской техники при попытке полететь
$artillery_unit->fly;
is ( $artillery_unit->is_destroyed, 1, 'Проверка попытки полететь на артиллерийской технике.' );

# уничтожаем артиллерийскую технику и проверяем невозможность выполнять действия после уничтожения
$artillery_unit->is_destroyed(1);
$artillery_unit->cannon->is_destroyed(1);

is ( $artillery_unit->fire_cannon,    0, 'Проверка попытки выстрелить для орудия "пушка" для уже уничтоженного объекта.'     );
is ( $artillery_unit->cannon->aim,    0, 'Проверка попытки прицелится для орудия "пушка" для уже уничтоженного объекта.'     );
is ( $artillery_unit->cannon->reload, 0, 'Проверка попытки перезарядиться для орудия "пушка" для уже уничтоженного объекта.' );

is ( $artillery_unit->destroy,                  0, 'Проверка попытки уничтожить уже уничтоженный объект.'             );
is ( $artillery_unit->get_damage,               0, 'Проверка попытки получить повреждения для уничтоженного объекта.' );
is ( $artillery_unit->go_to_artillery_position, 0, 'Проверка попытки взлететь для уничтоженного объекта.'             );
is ( $artillery_unit->move,                     0, 'Проверка попытки поехать для уничтоженного объекта.'              );
is ( $artillery_unit->fly,                      0, 'Проверка попытки полететь для уничтоженного объекта.'             );
is ( $artillery_unit->sail,                     0, 'Проверка попытки поплыть для уничтоженного объекта.'              );
