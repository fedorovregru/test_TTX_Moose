#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 37;
use Test::Exception;

use Data::Dumper;

use_ok( 'Vehicle::Ship'   );
use_ok( 'Weapon::Cannon'  );
use_ok( 'Weapon::Torpedo' );

subtest 'Тест объекта с вручную заданными параметрами' => sub {

    plan tests => 17;
    
    # создаем объект с вручную заданными параметрами
    my $ship_unit = Ship->new(
    
        main_cannon => Cannon->new(
            ammo_type     => 'Снаряд',
            ammo_count    => 30,
            magazine_size => 2,
            magazine_ammo => 0,
            is_destroyed  => 1
        ),

        torpedo => Torpedo->new(
            ammo_type     => 'Торпеда',
            ammo_count    => 8,
            is_destroyed  => 1
        ),

        model_name             => 'Ship',
        armor_thikness         => 500,
        speed                  => 60,
        durability             => 8000,
        critical_damage_chance => 50,
        is_destroyed           => 1
    );

    isa_ok( $ship_unit,              'Ship'    );
    isa_ok( $ship_unit->main_cannon, 'Cannon'  );
    isa_ok( $ship_unit->torpedo,     'Torpedo' );

    # тесты полей объекта при создании с вручную заданными параметрами
    is( $ship_unit->main_cannon->ammo_type,     'Снаряд', 'Проверка типа боезапаса орудия "пушка".'                  );
    is( $ship_unit->main_cannon->ammo_count,    30,       'Проверка количества боезапаса орудия "пушка".'            );
    is( $ship_unit->main_cannon->magazine_size, 2,        'Проверка размера магазина орудия "пушка".'                );
    is( $ship_unit->main_cannon->magazine_ammo, 0,        'Проверка количества боезапаса в магазине орудия "пушка".' );
    is( $ship_unit->main_cannon->is_destroyed,  1,        'Проверка флага уничтоженного орудия "пушка".'             );
    
    is( $ship_unit->torpedo->ammo_type,    'Торпеда', 'Проверка типа боезапаса орудия "торпеда".'       );
    is( $ship_unit->torpedo->ammo_count,   8,         'Проверка количества боезапаса орудия "торпеда".' );
    is( $ship_unit->torpedo->is_destroyed, 1,         'Проверка флага уничтоженного орудия "торпеда".'  );
    
    is( $ship_unit->model_name,             'Ship', 'Проверка типа техники.'                        );
    is( $ship_unit->armor_thikness,         500,    'Проверка толщины брони техники.'               );
    is( $ship_unit->speed,                  60,     'Проверка скорости техники.'                    );
    is( $ship_unit->durability,             8000,   'Проверка прочности техники.'                   );
    is( $ship_unit->critical_damage_chance, 50,     'Проверка шанса критического урона по технике.' );
    is( $ship_unit->is_destroyed,           1,      'Проверка флага уничтоженного объекта.'         );
};

subtest 'Тест объекта с параметрами по-умолчанию' => sub {

    plan tests => 17;
    
    # создаем объект с параметрами по-умолчанию
    my $ship_unit = Ship->new(
    
        main_cannon => Cannon->new(
            ammo_type  => 'Снаряд',
            ammo_count => 30
        ),

        torpedo => Torpedo->new(
            ammo_type  => 'Торпеда',
            ammo_count => 8
        ),

        model_name     => 'Ship',
        armor_thikness => 500,
        speed          => 60,
        durability     => 8000
    );

    isa_ok( $ship_unit,              'Ship'    );
    isa_ok( $ship_unit->main_cannon, 'Cannon'  );
    isa_ok( $ship_unit->torpedo,     'Torpedo' );

    # тесты полей объекта при создании с параметрами по-умолчанию
    is( $ship_unit->main_cannon->ammo_type,     'Снаряд', 'Проверка типа боезапаса орудия "пушка".'                  );
    is( $ship_unit->main_cannon->ammo_count,    29,       'Проверка количества боезапаса орудия "пушка".'            );
    is( $ship_unit->main_cannon->magazine_size, 1,        'Проверка размера магазина орудия "пушка".'                );
    is( $ship_unit->main_cannon->magazine_ammo, 1,        'Проверка количества боезапаса в магазине орудия "пушка".' );
    is( $ship_unit->main_cannon->is_destroyed,  0,        'Проверка флага уничтоженного орудия "пушка".'             );
    
    is( $ship_unit->torpedo->ammo_type,     'Торпеда', 'Проверка типа боезапаса орудия "торпеда".'       );
    is( $ship_unit->torpedo->ammo_count,    8,         'Проверка количества боезапаса орудия "торпеда".' );
    is( $ship_unit->torpedo->is_destroyed,  0,         'Проверка флага уничтоженного орудия "торпеда".'  );
    
    is( $ship_unit->model_name,             'Ship', 'Проверка типа техники.'                        );
    is( $ship_unit->armor_thikness,         500,    'Проверка толщины брони техники.'               );
    is( $ship_unit->speed,                  60,     'Проверка скорости техники.'                    );
    is( $ship_unit->durability,             8000,   'Проверка прочности техники.'                   );
    is( $ship_unit->critical_damage_chance, 10,     'Проверка шанса критического урона по технике.' );
    is( $ship_unit->is_destroyed,           0,      'Проверка флага уничтоженного объекта.'         );
};

# создаем тестовый объект
my $ship_unit = Ship->new(

    main_cannon => Cannon->new(
        ammo_type  => 'Снаряд',
        ammo_count => 30
    ),

    torpedo => Torpedo->new(
        ammo_type     => 'Торпеда',
        ammo_count    => 8
    ),

    model_name     => 'Ship',
    armor_thikness => 500,
    speed          => 60,
    durability     => 8000
);

# проверки наличия методов
can_ok( $ship_unit->main_cannon, 'aim'    );
can_ok( $ship_unit->main_cannon, 'shot'   );
can_ok( $ship_unit->main_cannon, 'reload' );
can_ok( $ship_unit->main_cannon, 'BUILD'  );

can_ok( $ship_unit->torpedo, 'aim'    );
can_ok( $ship_unit->torpedo, 'shot'   );

can_ok( $ship_unit, 'fire_cannon'    );
can_ok( $ship_unit, 'launch_torpedo' );

can_ok( $ship_unit, 'BUILD'      );
can_ok( $ship_unit, 'out_to_sea' );

can_ok( $ship_unit, 'move' );
can_ok( $ship_unit, 'fly'  );
can_ok( $ship_unit, 'sail' );

# проверка записи некорректных данных в поля объекта
dies_ok { $ship_unit->model_name(             150    ) } 'Попытка записи некорректного значения в model_name.';
dies_ok { $ship_unit->armor_thikness(         'test' ) } 'Попытка записи некорректного значения в armor_thikness.';
dies_ok { $ship_unit->speed(                  'test' ) } 'Попытка записи некорректного значения в speed.';
dies_ok { $ship_unit->durability(             'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $ship_unit->critical_damage_chance( 'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $ship_unit->is_destroyed(           'test' ) } 'Попытка записи некорректного значения в is_destroyed.';

# проверяем уничтожение корабля при попытке полететь
$ship_unit->fly;
is ( $ship_unit->is_destroyed, 1, 'Проверка попытки полета на корабле.' );

# "воскрешаем" корабль для дальнейшей проверки
$ship_unit->is_destroyed(0);

# проверяем уничтожение корабля при попытке поехать
$ship_unit->move;
is ( $ship_unit->is_destroyed, 1, 'Проверка попытки поехать на корабле.' );

# уничтожаем корабль и проверяем невозможность выполнять действия после уничтожения
$ship_unit->is_destroyed(1);
$ship_unit->main_cannon->is_destroyed(1);
$ship_unit->torpedo->is_destroyed(1);

is ( $ship_unit->fire_cannon,         0, 'Проверка попытки выстрелить для орудия "пушка" для уже уничтоженного объекта.'     );
is ( $ship_unit->main_cannon->aim,    0, 'Проверка попытки прицелится для орудия "пушка" для уже уничтоженного объекта.'     );
is ( $ship_unit->main_cannon->reload, 0, 'Проверка попытки перезарядиться для орудия "пушка" для уже уничтоженного объекта.' );

is ( $ship_unit->launch_torpedo, 0, 'Проверка попытки выстрелить для орудия "торпеда" для уже уничтоженного объекта.' );
is ( $ship_unit->torpedo->aim,   0, 'Проверка попытки прицелится для орудия "торпеда" для уже уничтоженного объекта.' );

is ( $ship_unit->destroy,    0, 'Проверка попытки уничтожить уже уничтоженный объект.'             );
is ( $ship_unit->get_damage, 0, 'Проверка попытки получить повреждения для уничтоженного объекта.' );
is ( $ship_unit->out_to_sea, 0, 'Проверка попытки выйти в море для уничтоженного объекта.'         );
is ( $ship_unit->move,       0, 'Проверка попытки поехать для уничтоженного объекта.'              );
is ( $ship_unit->fly,        0, 'Проверка попытки полететь для уничтоженного объекта.'             );
is ( $ship_unit->sail,       0, 'Проверка попытки поплыть для уничтоженного объекта.'              );
