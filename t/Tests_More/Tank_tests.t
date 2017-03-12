#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 40;
use Test::Exception;

use Data::Dumper;

use_ok( 'Vehicle::Tank'      );
use_ok( 'Weapon::Cannon'     );
use_ok( 'Weapon::Machinegun' );

subtest 'Тест объекта с вручную заданными параметрами' => sub {

    plan tests => 19;
    
    # создаем объект с вручную заданными параметрами
    my $tank_unit = Tank->new(
    
        main_cannon => Cannon->new(
            ammo_type     => 'Снаряд',
            ammo_count    => 30,
            magazine_size => 2,
            magazine_ammo => 0,
            is_destroyed  => 1
        ),

        machine_gun => Machinegun->new(
            ammo_type     => 'Патрон',
            ammo_count    => 2000,
            magazine_size => 12,
            magazine_ammo => 0,
            is_destroyed  => 1
        ),

        model_name             => 'Tank',
        armor_thikness         => 1000,
        speed                  => 40,
        durability             => 2000,
        critical_damage_chance => 50,
        is_destroyed           => 1
    );

    isa_ok( $tank_unit,              'Tank'       );
    isa_ok( $tank_unit->main_cannon, 'Cannon'     );
    isa_ok( $tank_unit->machine_gun, 'Machinegun' );

    # тесты полей объекта при создании с вручную заданными параметрами
    is( $tank_unit->main_cannon->ammo_type,     'Снаряд', 'Проверка типа боезапаса орудия "пушка".'                  );
    is( $tank_unit->main_cannon->ammo_count,    30,       'Проверка количества боезапаса орудия "пушка".'            );
    is( $tank_unit->main_cannon->magazine_size, 2,        'Проверка размера магазина орудия "пушка".'                );
    is( $tank_unit->main_cannon->magazine_ammo, 0,        'Проверка количества боезапаса в магазине орудия "пушка".' );
    is( $tank_unit->main_cannon->is_destroyed,  1,        'Проверка флага уничтоженного орудия "пушка".'             );
    
    is( $tank_unit->machine_gun->ammo_type,     'Патрон', 'Проверка типа боезапаса орудия "пулемет".'                  );
    is( $tank_unit->machine_gun->ammo_count,    2000,     'Проверка количества боезапаса орудия "пулемет".'            );
    is( $tank_unit->machine_gun->magazine_size, 12,       'Проверка размера магазина орудия "пулемет".'                );
    is( $tank_unit->machine_gun->magazine_ammo, 0,        'Проверка количества боезапаса в магазине орудия "пулемет".' );
    is( $tank_unit->machine_gun->is_destroyed,  1,        'Проверка флага уничтоженного орудия "пулемет".'             );
    
    is( $tank_unit->model_name,             'Tank', 'Проверка типа техники.'                        );
    is( $tank_unit->armor_thikness,         1000,   'Проверка толщины брони техники.'               );
    is( $tank_unit->speed,                  40,     'Проверка скорости техники.'                    );
    is( $tank_unit->durability,             2000,   'Проверка прочности техники.'                   );
    is( $tank_unit->critical_damage_chance, 50,     'Проверка шанса критического урона по технике.' );
    is( $tank_unit->is_destroyed,           1,      'Проверка флага уничтоженного объекта.'         );
};

subtest 'Тест объекта с параметрами по-умолчанию' => sub {

    plan tests => 19;
    
    # создаем объект с параметрами по-умолчанию
    my $tank_unit = Tank->new(
    
        main_cannon => Cannon->new(
            ammo_type  => 'Снаряд',
            ammo_count => 30
        ),

        machine_gun => Machinegun->new(
            ammo_type  => 'Патрон',
            ammo_count => 2000
        ),

        model_name     => 'Tank',
        armor_thikness => 1000,
        speed          => 40,
        durability     => 2000
    );

    isa_ok( $tank_unit,              'Tank'       );
    isa_ok( $tank_unit->main_cannon, 'Cannon'     );
    isa_ok( $tank_unit->machine_gun, 'Machinegun' );

    # тесты полей объекта при создании с параметрами по-умолчанию
    is( $tank_unit->main_cannon->ammo_type,     'Снаряд', 'Проверка типа боезапаса орудия "пушка".'                  );
    is( $tank_unit->main_cannon->ammo_count,    29,       'Проверка количества боезапаса орудия "пушка".'            );
    is( $tank_unit->main_cannon->magazine_size, 1,        'Проверка размера магазина орудия "пушка".'                );
    is( $tank_unit->main_cannon->magazine_ammo, 1,        'Проверка количества боезапаса в магазине орудия "пушка".' );
    is( $tank_unit->main_cannon->is_destroyed,  0,        'Проверка флага уничтоженного орудия "пушка".'             );
    
    is( $tank_unit->machine_gun->ammo_type,     'Патрон', 'Проверка типа боезапаса орудия "пулемет".'                 );
    is( $tank_unit->machine_gun->ammo_count,    1999,     'Проверка количества боезапаса орудия "пулемет".'           );
    is( $tank_unit->machine_gun->magazine_size, 1,       'Проверка размера магазина орудия "пулемет".'                );
    is( $tank_unit->machine_gun->magazine_ammo, 1,       'Проверка количества боезапаса в магазине орудия "пулемет".' );
    is( $tank_unit->machine_gun->is_destroyed,  0,        'Проверка флага уничтоженного орудия "пулемет".'            );
    
    is( $tank_unit->model_name,             'Tank', 'Проверка типа техники.'                        );
    is( $tank_unit->armor_thikness,         1000,   'Проверка толщины брони техники.'               );
    is( $tank_unit->speed,                  40,     'Проверка скорости техники.'                    );
    is( $tank_unit->durability,             2000,   'Проверка прочности техники.'                   );
    is( $tank_unit->critical_damage_chance, 10,     'Проверка шанса критического урона по технике.' );
    is( $tank_unit->is_destroyed,           0,      'Проверка флага уничтоженного объекта.'         );
};

# создаем тестовый объект
my $tank_unit = Tank->new(

    main_cannon => Cannon->new(
        ammo_type  => 'Снаряд',
        ammo_count => 30
    ),

    machine_gun => Machinegun->new(
        ammo_type     => 'Патрон',
        ammo_count    => 2000,
        magazine_size => 50
    ),

    model_name     => 'Tank',
    armor_thikness => 1000,
    speed          => 40,
    durability     => 1000
);

# проверки наличия методов
can_ok( $tank_unit->main_cannon, 'aim'    );
can_ok( $tank_unit->main_cannon, 'shot'   );
can_ok( $tank_unit->main_cannon, 'reload' );
can_ok( $tank_unit->main_cannon, 'BUILD'  );

can_ok( $tank_unit->machine_gun, 'aim'    );
can_ok( $tank_unit->machine_gun, 'shot'   );
can_ok( $tank_unit->machine_gun, 'reload' );
can_ok( $tank_unit->machine_gun, 'BUILD'  );

can_ok( $tank_unit, 'fire_cannon'     );
can_ok( $tank_unit, 'fire_machinegun' );

can_ok( $tank_unit, 'BUILD'                );
can_ok( $tank_unit, 'go_to_tanks_position' );

can_ok( $tank_unit, 'move' );
can_ok( $tank_unit, 'fly'  );
can_ok( $tank_unit, 'sail' );

# проверка записи некорректных данных в поля объекта
dies_ok { $tank_unit->model_name(             150    ) } 'Попытка записи некорректного значения в model_name.';
dies_ok { $tank_unit->armor_thikness(         'test' ) } 'Попытка записи некорректного значения в armor_thikness.';
dies_ok { $tank_unit->speed(                  'test' ) } 'Попытка записи некорректного значения в speed.';
dies_ok { $tank_unit->durability(             'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $tank_unit->critical_damage_chance( 'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $tank_unit->is_destroyed(           'test' ) } 'Попытка записи некорректного значения в is_destroyed.';

# проверяем уничтожение танка при попытке полететь
$tank_unit->fly;
is ( $tank_unit->is_destroyed, 1, 'Проверка попытки полета на танке.' );

# "воскрешаем" танк для дальнейшей проверки
$tank_unit->is_destroyed(0);

# проверяем уничтожение танка при попытке поплыть
$tank_unit->sail;
is ( $tank_unit->is_destroyed, 1, 'Проверка попытки поплавать на танке.' );

# уничтожаем танк и проверяем невозможность выполнять действия после уничтожения
$tank_unit->is_destroyed(1);
$tank_unit->main_cannon->is_destroyed(1);
$tank_unit->machine_gun->is_destroyed(1);

is ( $tank_unit->fire_cannon,         0, 'Проверка попытки выстрелить для орудия "пушка" для уже уничтоженного объекта.'     );
is ( $tank_unit->main_cannon->aim,    0, 'Проверка попытки прицелится для орудия "пушка" для уже уничтоженного объекта.'     );
is ( $tank_unit->main_cannon->reload, 0, 'Проверка попытки перезарядиться для орудия "пушка" для уже уничтоженного объекта.' );

is ( $tank_unit->fire_machinegun,     0, 'Проверка попытки выстрелить для орудия "пулемет" для уже уничтоженного объекта.'     );
is ( $tank_unit->machine_gun->aim,    0, 'Проверка попытки прицелится для орудия "пулемет" для уже уничтоженного объекта.'     );
is ( $tank_unit->machine_gun->reload, 0, 'Проверка попытки перезарядиться для орудия "пулемет" для уже уничтоженного объекта.' );

is ( $tank_unit->destroy,              0, 'Проверка попытки уничтожить уже уничтоженный объект.'             );
is ( $tank_unit->get_damage,           0, 'Проверка попытки получить повреждения для уничтоженного объекта.' );
is ( $tank_unit->go_to_tanks_position, 0, 'Проверка попытки выйти на позицию для уничтоженного объекта.'     );
is ( $tank_unit->move,                 0, 'Проверка попытки поехать для уничтоженного объекта.'              );
is ( $tank_unit->fly,                  0, 'Проверка попытки полететь для уничтоженного объекта.'             );
is ( $tank_unit->sail,                 0, 'Проверка попытки поплыть для уничтоженного объекта.'              );
