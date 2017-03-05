#!/usr/bin/perl

use Modern::Perl;
use Test::More qw( no_plan );

use Data::Dumper;

use_ok( 'Weapon::Cannon'     );
use_ok( 'Weapon::Machinegun' );
use_ok( 'Vehicle::Tank'      );

my $tank_unit = Tank->new(

    main_cannon    => Cannon->new( ammo_type  => 'Снаряд',
                                   ammo_count => 25 ),
    
    machine_gun    => Machinegun->new( ammo_type     => 'Патрон',
                                       ammo_count    => 2000,
                                       magazine_size => 100 ),
    
    model_name     => 'T-1000',
    armor_thikness => 800,
    speed          => 60,
    durability     => 2000
);

isa_ok( $tank_unit, 'Tank' );

is_deeply( $tank_unit->main_cannon, { ammo_type     => 'Снаряд',
                                      ammo_count    => 24,
                                      magazine_size => 1,
                                      magazine_ammo => 1 },
                                    'Оружие "пушка" присутствует' );

is_deeply( $tank_unit->machine_gun, { ammo_type     => 'Патрон',
                                      ammo_count    => 1900,
                                      magazine_size => 100,
                                      magazine_ammo => 100 },
                                    'Оружие "пулемет" присутствует' );

is( $tank_unit->model_name,     'T-1000', 'Проверка названия модели'             );
is( $tank_unit->armor_thikness, 800,      'Проверка толщины брони'               );
is( $tank_unit->speed,          60,       'Проверка скорости'                    );
is( $tank_unit->durability,     2000,     'Проверка прочности'                   );
is( $tank_unit->destroyed,      undef,    'Проверка флага уничтоженного объекта' );

# проверки наличия методов
can_ok( $tank_unit, 'BUILD'                  );
can_ok( $tank_unit, 'destroy'                );
can_ok( $tank_unit, 'fire_cannon'            );
can_ok( $tank_unit, 'fire_machinegun'        );
can_ok( $tank_unit, 'fly'                    );
can_ok( $tank_unit, 'get_damage'             );
can_ok( $tank_unit, 'go_to_tanks_position'   );
can_ok( $tank_unit, 'is_get_critical_damage' );
can_ok( $tank_unit, 'move'                   );
can_ok( $tank_unit, 'sail'                   );
can_ok( $tank_unit->main_cannon, 'aim'  );
can_ok( $tank_unit->main_cannon, 'shot' );
can_ok( $tank_unit->machine_gun, 'aim'  );
can_ok( $tank_unit->machine_gun, 'shot' );

$tank_unit->fire_cannon;
is ( $tank_unit->main_cannon->magazine_ammo, 1,  'Проверка магазина пушки после одного выстрела'  );
is ( $tank_unit->main_cannon->ammo_count,    23, 'Проверка боезапаса пушки после одного выстрела' );

$tank_unit->fire_machinegun;
is ( $tank_unit->machine_gun->magazine_ammo, 99,   'Проверка магазина пулемета после одного выстрела'  );
is ( $tank_unit->machine_gun->ammo_count,    1900, 'Проверка боезапаса пулемета после одного выстрела' );

# опустошаем боезапас
$tank_unit->main_cannon->ammo_count( $tank_unit->main_cannon->ammo_count - 23   );
$tank_unit->machine_gun->ammo_count( $tank_unit->machine_gun->ammo_count - 1900 );

is ( $tank_unit->main_cannon->reload, 0, 'Проверка перезаряжания пушки при отсутствующем боезапасе'    );
is ( $tank_unit->machine_gun->reload, 0, 'Проверка перезаряжания пулемета при отсутствующем боезапасе' );

# опустошаем магазин пушки и пулемета
$tank_unit->main_cannon->magazine_ammo( $tank_unit->main_cannon->magazine_ammo - 1  );
$tank_unit->machine_gun->magazine_ammo( $tank_unit->machine_gun->magazine_ammo - 99 );

is ( $tank_unit->fire_cannon,     0, 'Проверка выстрела из пушки при незаряженном магазине'    );
is ( $tank_unit->fire_machinegun, 0, 'Проверка выстрела из пулемета при незаряженном магазине' );

# возвращаем заряд в магазин пушки и патрон в магазин пулемета, для дальнейшей проверки
$tank_unit->main_cannon->magazine_ammo(1);
$tank_unit->machine_gun->magazine_ammo(1);

$tank_unit->sail;
is ( $tank_unit->is_destroyed, 1, 'Проверка попытки поплыть' );

# "воскрешаем" объект для дальнейшей проверки
$tank_unit->revive;

$tank_unit->fly;
is ( $tank_unit->is_destroyed, 1, 'Проверка попытки полететь' );

# "воскрешаем" объект для дальнейшей проверки
$tank_unit->revive;

is ( $tank_unit->get_damage(2000), 1, 'Получение максимального урона' );
is ( $tank_unit->get_damage(1),    0, 'Получение урона сверх максимального' );

# проверки возможности выполнять действия после уничтожения
is ( $tank_unit->destroy,              0, 'Проверка попытки уничтожить уже уничтоженный объект'               );
is ( $tank_unit->fire_cannon,          0, 'Проверка попытки выстрелить из пушки для уничтоженного объекта'    );
is ( $tank_unit->fire_machinegun,      0, 'Проверка попытки выстрелить из пулемета для уничтоженного объекта' );
is ( $tank_unit->fly,                  0, 'Проверка попытки полететь для уничтоженного объекта'               );
is ( $tank_unit->get_damage,           0, 'Проверка попытки нанести урон уже уничтоженному объекту'           );
is ( $tank_unit->go_to_tanks_position, 0, 'Проверка попытки занять позицию для уничтоженного объекта'         );
is ( $tank_unit->move,                 0, 'Проверка попытки поехать для уничтоженного объекта'                );
is ( $tank_unit->sail,                 0, 'Проверка попытки поплыть для уничтоженного объекта'                );
