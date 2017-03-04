#!/usr/bin/perl

use Modern::Perl;
use Test::More qw( no_plan );

use Data::Dumper;

use_ok( 'Weapon::Rocket'     );
use_ok( 'Weapon::Machinegun' );
use_ok( 'Vehicle::Avia'      );

my $avia_unit = Avia->new(

    rockets        => Rocket->new( ammo_type  => 'Ракета',
                                   ammo_count => 5 ),
    
    machine_gun    => Machinegun->new( ammo_type     => 'Патрон',
                                       ammo_count    => 2000,
                                       magazine_size => 100 ),
    
    model_name     => 'AV-99-3',
    armor_thikness => 10,
    speed          => 5000,
    durability     => 600
);

isa_ok( $avia_unit, 'Avia' );

is_deeply( $avia_unit->rockets, { ammo_type  => 'Ракета',
                                  ammo_count => 5 },
                                'Оружие "ракеты" присутствует' );

is_deeply( $avia_unit->machine_gun, { ammo_type     => 'Патрон',
                                      ammo_count    => 1900,
                                      magazine_size => 100,
                                      magazine_ammo => 100 },
                                    'Оружие "пулемет" присутствует' );

is( $avia_unit->model_name,     'AV-99-3', 'Проверка названия модели'             );
is( $avia_unit->armor_thikness, 10,        'Проверка толщины брони'               );
is( $avia_unit->speed,          5000,      'Проверка скорости'                    );
is( $avia_unit->durability,     600,       'Проверка прочности'                   );
is( $avia_unit->destroyed,      undef,     'Проверка флага уничтоженного объекта' );

# проверки наличия методов
can_ok( $avia_unit, 'BUILD'                  );
can_ok( $avia_unit, 'destroy'                );
can_ok( $avia_unit, 'launch_rocket'          );
can_ok( $avia_unit, 'fire_machinegun'        );
can_ok( $avia_unit, 'fly'                    );
can_ok( $avia_unit, 'get_damage'             );
can_ok( $avia_unit, 'takeoff'                );
can_ok( $avia_unit, 'is_get_critical_damage' );
can_ok( $avia_unit, 'move'                   );
can_ok( $avia_unit, 'sail'                   );
can_ok( $avia_unit->rockets, 'aim'  );
can_ok( $avia_unit->rockets, 'shot' );
can_ok( $avia_unit->machine_gun, 'aim'  );
can_ok( $avia_unit->machine_gun, 'shot' );

$avia_unit->launch_rocket;
is ( $avia_unit->rockets->ammo_count, 4, 'Проверка боезапаса ракет после одного выстрела' );

# оставляем в магазине пулемета один патрон
$avia_unit->machine_gun->magazine_ammo(1);

$avia_unit->fire_machinegun;
is ( $avia_unit->machine_gun->magazine_ammo, 100,  'Проверка магазина пулемета после выстрела последнего патрона в магазине'  );
is ( $avia_unit->machine_gun->ammo_count,    1800, 'Проверка боезапаса пулемета после выстрела последнего патрона в магазине' );

# опустошаем боезапас
$avia_unit->rockets->ammo_count( $avia_unit->rockets->ammo_count - 4 );
$avia_unit->machine_gun->ammo_count( $avia_unit->machine_gun->ammo_count - 1800 );

is ( $avia_unit->machine_gun->reload, 0, 'Проверка перезаряжания пулемета при отсутствующем боезапасе' );

# опустошаем магазин пулемета
$avia_unit->machine_gun->magazine_ammo( $avia_unit->machine_gun->magazine_ammo - 100 );
is ( $avia_unit->fire_machinegun, 0, 'Проверка выстрела из пулемета при незаряженном магазине' );

# возвращаем заряд в магазин пулемета и ракету в боезапас, для дальнейшей проверки
$avia_unit->machine_gun->magazine_ammo(1);
$avia_unit->rockets->ammo_count(1);

$avia_unit->move;
is ( $avia_unit->is_destroyed, 1, 'Проверка попытки поехать' );

# "воскрешаем" объект для дальнейшей проверки
$avia_unit->revive;

$avia_unit->sail;
is ( $avia_unit->is_destroyed, 1, 'Проверка попытки поплыть' );

# "воскрешаем" объект для дальнейшей проверки
$avia_unit->revive;

is ( $avia_unit->get_damage(600), 1, 'Получение максимального урона' );
is ( $avia_unit->get_damage(1),   0, 'Получение урона сверх максимального' );

# проверки возможности выполнять действия после уничтожения
is ( $avia_unit->destroy,         0, 'Проверка попытки уничтожить уже уничтоженный объект'               );
is ( $avia_unit->launch_rocket,   0, 'Проверка попытки запустить ракету с уничтоженного объекта'         );
is ( $avia_unit->fire_machinegun, 0, 'Проверка попытки выстрелить из пулемета для уничтоженного объекта' );
is ( $avia_unit->fly,             0, 'Проверка попытки полететь для уничтоженного объекта'               );
is ( $avia_unit->get_damage,      0, 'Проверка попытки нанести урон уже уничтоженному объекту'           );
is ( $avia_unit->takeoff,         0, 'Проверка попытки выйти на позицию для уничтоженного объекта'       );
is ( $avia_unit->move,            0, 'Проверка попытки поехать для уничтоженного объекта'                );
is ( $avia_unit->sail,            0, 'Проверка попытки поплыть для уничтоженного объекта'                );

