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

isa_ok( $artillery_unit, 'Artillery' );

is_deeply( $artillery_unit->cannon, { ammo_type     => 'Снаряд',
                                      ammo_count    => 29,
                                      magazine_size => 1,
                                      magazine_ammo => 1 },
                                    'Орудие "пушка" присутствует' );

is( $artillery_unit->model_name,     'AR-19-75', 'Проверка названия модели'             );
is( $artillery_unit->armor_thikness, 120,        'Проверка толщины брони'               );
is( $artillery_unit->speed,          30,         'Проверка скорости'                    );
is( $artillery_unit->durability,     800,        'Проверка прочности'                   );
is( $artillery_unit->destroyed,      undef,      'Проверка флага уничтоженного объекта' );

# проверки наличия методов
can_ok( $artillery_unit, 'BUILD'                    );
can_ok( $artillery_unit, 'destroy'                  );
can_ok( $artillery_unit, 'fire_cannon'              );
can_ok( $artillery_unit, 'fly'                      );
can_ok( $artillery_unit, 'get_damage'               );
can_ok( $artillery_unit, 'go_to_artillery_position' );
can_ok( $artillery_unit, 'is_get_critical_damage'   );
can_ok( $artillery_unit, 'move'                     );
can_ok( $artillery_unit, 'sail'                     );
can_ok( $artillery_unit->cannon, 'aim'  );
can_ok( $artillery_unit->cannon, 'shot' );

$artillery_unit->fire_cannon;
is ( $artillery_unit->cannon->magazine_ammo, 1,  'Проверка магазина после одного выстрела'  );
is ( $artillery_unit->cannon->ammo_count,    28, 'Проверка боезапаса после одного выстрела' );

# опустошаем боезапас
$artillery_unit->cannon->ammo_count( $artillery_unit->cannon->ammo_count - 28 );
is ( $artillery_unit->cannon->reload, 0, 'Проверка перезаряжания при отсутствующем боезапасе' );

# опустошаем магазин
$artillery_unit->cannon->magazine_ammo( $artillery_unit->cannon->magazine_ammo - 1 );
is ( $artillery_unit->fire_cannon, 0, 'Проверка выстрела при незаряженном магазине' );

# возвращаем заряд в магазин, для дальнейшей проверки
$artillery_unit->cannon->magazine_ammo(1);

$artillery_unit->fly;
is ( $artillery_unit->is_destroyed, 1, 'Проверка попытки взлететь' );

# "воскрешаем" объект для дальнейшей проверки
$artillery_unit->revive;
$artillery_unit->cannon->revive;

$artillery_unit->sail;
is ( $artillery_unit->is_destroyed, 1, 'Проверка попытки поплыть' );

# "воскрешаем" объект для дальнейшей проверки
$artillery_unit->revive;
$artillery_unit->cannon->revive;

is ( $artillery_unit->get_damage(800), 1, 'Получение максимального урона' );
is ( $artillery_unit->get_damage(1),   0, 'Получение урона сверх максимального' );

# проверки возможности выполнять действия после уничтожения
is ( $artillery_unit->destroy,                  0, 'Проверка попытки уничтожить уже уничтоженный объект'         );
is ( $artillery_unit->fire_cannon,              0, 'Проверка попытки выстрелить для уничтоженного объекта'       );
is ( $artillery_unit->fly,                      0, 'Проверка попытки полететь для уничтоженного объекта'         );
is ( $artillery_unit->get_damage,               0, 'Проверка попытки нанести урон уже уничтоженному объекту'     );
is ( $artillery_unit->go_to_artillery_position, 0, 'Проверка попытки выйти на позицию для уничтоженного объекта' );
is ( $artillery_unit->move,                     0, 'Проверка попытки поехать для уничтоженного объекта'          );
is ( $artillery_unit->sail,                     0, 'Проверка попытки поплыть для уничтоженного объекта'          );

