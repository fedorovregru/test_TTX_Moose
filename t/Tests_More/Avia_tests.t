#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 37;
use Test::Exception;

use Data::Dumper;

use_ok( 'Vehicle::Avia'      );
use_ok( 'Weapon::Machinegun' );
use_ok( 'Weapon::Rocket'     );

subtest 'Тест объекта с вручную заданными параметрами' => sub {

    plan tests => 17;
    
    # создаем объект с вручную заданными параметрами
    my $avia_unit = Avia->new(
    
        machine_gun => Machinegun->new(
            ammo_type     => 'Патрон',
            ammo_count    => 2000,
            magazine_size => 50,
            magazine_ammo => 0,
            is_destroyed  => 1
        ),

        rockets => Rocket->new(
            ammo_type     => 'Ракета',
            ammo_count    => 5,
            is_destroyed  => 1
        ),

        model_name             => 'Avia',
        armor_thikness         => 200,
        speed                  => 2000,
        durability             => 500,
        critical_damage_chance => 50,
        is_destroyed           => 1
    );

    isa_ok( $avia_unit,              'Avia'       );
    isa_ok( $avia_unit->machine_gun, 'Machinegun' );
    isa_ok( $avia_unit->rockets,     'Rocket'     );

    # тесты полей объекта при создании с вручную заданными параметрами
    is( $avia_unit->machine_gun->ammo_type,     'Патрон', 'Проверка типа боезапаса орудия "пулемет".'                  );
    is( $avia_unit->machine_gun->ammo_count,    2000,     'Проверка количества боезапаса орудия "пулемет".'            );
    is( $avia_unit->machine_gun->magazine_size, 50,       'Проверка размера магазина орудия "пулемет".'                );
    is( $avia_unit->machine_gun->magazine_ammo, 0,        'Проверка количества боезапаса в магазине орудия "пулемет".' );
    is( $avia_unit->machine_gun->is_destroyed,  1,        'Проверка флага уничтоженного орудия "пулемет".'             );
    
    is( $avia_unit->rockets->ammo_type,    'Ракета', 'Проверка типа боезапаса орудия "Ракета".'       );
    is( $avia_unit->rockets->ammo_count,   5,        'Проверка количества боезапаса орудия "Ракета".' );
    is( $avia_unit->rockets->is_destroyed, 1,        'Проверка флага уничтоженного орудия "Ракета".'  );
    
    is( $avia_unit->model_name,             'Avia', 'Проверка типа техники.'                        );
    is( $avia_unit->armor_thikness,         200,    'Проверка толщины брони техники.'               );
    is( $avia_unit->speed,                  2000,   'Проверка скорости техники.'                    );
    is( $avia_unit->durability,             500,    'Проверка прочности техники.'                   );
    is( $avia_unit->critical_damage_chance, 50,     'Проверка шанса критического урона по технике.' );
    is( $avia_unit->is_destroyed,           1,      'Проверка флага уничтоженного объекта.'         );
};

subtest 'Тест объекта с параметрами по-умолчанию' => sub {

    plan tests => 17;
    
    # создаем объект с параметрами по-умолчанию
    my $avia_unit = Avia->new(
    
        machine_gun => Machinegun->new(
            ammo_type     => 'Патрон',
            ammo_count    => 2000,
            magazine_size => 50
        ),

        rockets => Rocket->new(
            ammo_type  => 'Ракета',
            ammo_count => 5
        ),

        model_name     => 'Avia',
        armor_thikness => 200,
        speed          => 2000,
        durability     => 500
    );

    isa_ok( $avia_unit,              'Avia'       );
    isa_ok( $avia_unit->machine_gun, 'Machinegun' );
    isa_ok( $avia_unit->rockets,     'Rocket'     );

    # тесты полей объекта при создании с параметрами по-умолчанию
    is( $avia_unit->machine_gun->ammo_type,     'Патрон', 'Проверка типа боезапаса орудия "пулемет".'                  );
    is( $avia_unit->machine_gun->ammo_count,    1950,     'Проверка количества боезапаса орудия "пулемет".'            );
    is( $avia_unit->machine_gun->magazine_size, 50,       'Проверка размера магазина орудия "пулемет".'                );
    is( $avia_unit->machine_gun->magazine_ammo, 50,       'Проверка количества боезапаса в магазине орудия "пулемет".' );
    is( $avia_unit->machine_gun->is_destroyed,  0,        'Проверка флага уничтоженного орудия "пулемет".'             );
    
    is( $avia_unit->rockets->ammo_type,    'Ракета', 'Проверка типа боезапаса орудия "Ракета".'       );
    is( $avia_unit->rockets->ammo_count,   5,        'Проверка количества боезапаса орудия "Ракета".' );
    is( $avia_unit->rockets->is_destroyed, 0,        'Проверка флага уничтоженного орудия "Ракета".'  );
    
    is( $avia_unit->model_name,             'Avia', 'Проверка типа техники.'                        );
    is( $avia_unit->armor_thikness,         200,    'Проверка толщины брони техники.'               );
    is( $avia_unit->speed,                  2000,   'Проверка скорости техники.'                    );
    is( $avia_unit->durability,             500,    'Проверка прочности техники.'                   );
    is( $avia_unit->critical_damage_chance, 10,     'Проверка шанса критического урона по технике.' );
    is( $avia_unit->is_destroyed,           0,      'Проверка флага уничтоженного объекта.'         );
};

# создаем тестовый объект
my $avia_unit = Avia->new(

    machine_gun => Machinegun->new(
        ammo_type     => 'Патрон',
        ammo_count    => 30,
        magazine_size => 50
    ),

    rockets => Rocket->new(
        ammo_type     => 'Ракета',
        ammo_count    => 5
    ),

    model_name     => 'Avia',
    armor_thikness => 200,
    speed          => 2000,
    durability     => 500
);

# проверки наличия методов
can_ok( $avia_unit->machine_gun, 'aim'    );
can_ok( $avia_unit->machine_gun, 'shot'   );
can_ok( $avia_unit->machine_gun, 'reload' );
can_ok( $avia_unit->machine_gun, 'BUILD'  );

can_ok( $avia_unit->rockets, 'aim'  );
can_ok( $avia_unit->rockets, 'shot' );

can_ok( $avia_unit, 'fire_machinegun'    );
can_ok( $avia_unit, 'launch_rocket' );

can_ok( $avia_unit, 'BUILD'    );
can_ok( $avia_unit, 'takeoff' );

can_ok( $avia_unit, 'move' );
can_ok( $avia_unit, 'fly'  );
can_ok( $avia_unit, 'sail' );

# проверка записи некорректных данных в поля объекта
dies_ok { $avia_unit->model_name(             150    ) } 'Попытка записи некорректного значения в model_name.';
dies_ok { $avia_unit->armor_thikness(         'test' ) } 'Попытка записи некорректного значения в armor_thikness.';
dies_ok { $avia_unit->speed(                  'test' ) } 'Попытка записи некорректного значения в speed.';
dies_ok { $avia_unit->durability(             'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $avia_unit->critical_damage_chance( 'test' ) } 'Попытка записи некорректного значения в durability.';
dies_ok { $avia_unit->is_destroyed(           'test' ) } 'Попытка записи некорректного значения в is_destroyed.';

# проверяем уничтожение самолета при попытке поплыть
$avia_unit->sail;
is ( $avia_unit->is_destroyed, 1, 'Проверка попытки поплавать на самолете.' );

# "воскрешаем" самолет для дальнейшей проверки
$avia_unit->is_destroyed(0);

# проверяем уничтожение самолета при попытке поехать
$avia_unit->move;
is ( $avia_unit->is_destroyed, 1, 'Проверка попытки поехать на самолете.' );

# уничтожаем самолет и проверяем невозможность выполнять действия после уничтожения
$avia_unit->is_destroyed(1);
$avia_unit->machine_gun->is_destroyed(1);
$avia_unit->rockets->is_destroyed(1);

is ( $avia_unit->fire_machinegun,     0, 'Проверка попытки выстрелить для орудия "пулемет" для уже уничтоженного объекта.'     );
is ( $avia_unit->machine_gun->aim,    0, 'Проверка попытки прицелится для орудия "пулемет" для уже уничтоженного объекта.'     );
is ( $avia_unit->machine_gun->reload, 0, 'Проверка попытки перезарядиться для орудия "пулемет" для уже уничтоженного объекта.' );

is ( $avia_unit->launch_rocket, 0, 'Проверка попытки выстрелить для орудия "Ракета" для уже уничтоженного объекта.' );
is ( $avia_unit->rockets->aim,  0, 'Проверка попытки прицелится для орудия "Ракета" для уже уничтоженного объекта.' );

is ( $avia_unit->destroy,    0, 'Проверка попытки уничтожить уже уничтоженный объект.'             );
is ( $avia_unit->get_damage, 0, 'Проверка попытки получить повреждения для уничтоженного объекта.' );
is ( $avia_unit->takeoff,    0, 'Проверка попытки взлететь для уничтоженного объекта.'             );
is ( $avia_unit->move,       0, 'Проверка попытки поехать для уничтоженного объекта.'              );
is ( $avia_unit->fly,        0, 'Проверка попытки полететь для уничтоженного объекта.'             );
is ( $avia_unit->sail,       0, 'Проверка попытки поплыть для уничтоженного объекта.'              );
