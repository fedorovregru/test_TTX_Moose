#!/usr/bin/perl

use Modern::Perl;
use Test::More qw( no_plan );

use Data::Dumper;

use_ok( 'Weapon::Cannon'  );
use_ok( 'Weapon::Torpedo' );
use_ok( 'Vehicle::Ship'   );

my $ship_unit = Ship->new(

    main_cannon    => Cannon->new( ammo_type  => 'Снаряд',
                                   ammo_count => 200 ),
    
    torpedo        => Torpedo->new( ammo_type     => 'Торпеда',
                                    ammo_count    => 8 ),
    
    model_name     => 'SH-02-N',
    armor_thikness => 50,
    speed          => 20,
    durability     => 5000
);

isa_ok( $ship_unit, 'Ship' );

is_deeply( $ship_unit->main_cannon, { ammo_type     => 'Снаряд',
                                      ammo_count    => 199,
                                      magazine_size => 1,
                                      magazine_ammo => 1 },
                                    'Оружие "пушка" присутствует' );

is_deeply( $ship_unit->torpedo, { ammo_type     => 'Торпеда',
                                  ammo_count    => 8 },
                                'Оружие "торпеды" присутствует' );

is( $ship_unit->model_name,     'SH-02-N', 'Проверка названия модели'             );
is( $ship_unit->armor_thikness, 50,        'Проверка толщины брони'               );
is( $ship_unit->speed,          20,        'Проверка скорости'                    );
is( $ship_unit->durability,     5000,      'Проверка прочности'                   );
is( $ship_unit->destroyed,      undef,     'Проверка флага уничтоженного объекта' );

# проверки наличия методов
can_ok( $ship_unit, 'BUILD'                  );
can_ok( $ship_unit, 'destroy'                );
can_ok( $ship_unit, 'fire_cannon'            );
can_ok( $ship_unit, 'launch_torpedo'         );
can_ok( $ship_unit, 'fly'                    );
can_ok( $ship_unit, 'get_damage'             );
can_ok( $ship_unit, 'out_to_sea'             );
can_ok( $ship_unit, 'is_get_critical_damage' );
can_ok( $ship_unit, 'move'                   );
can_ok( $ship_unit, 'sail'                   );
can_ok( $ship_unit->main_cannon, 'aim'  );
can_ok( $ship_unit->main_cannon, 'shot' );
can_ok( $ship_unit->torpedo, 'aim'  );
can_ok( $ship_unit->torpedo, 'shot' );

$ship_unit->launch_torpedo;
is ( $ship_unit->torpedo->ammo_count, 7, 'Проверка боезапаса торпед после одного выстрела' );

$ship_unit->fire_cannon;
is ( $ship_unit->main_cannon->magazine_ammo, 1,   'Проверка магазина пушки после одного выстрела'  );
is ( $ship_unit->main_cannon->ammo_count,    198, 'Проверка боезапаса пушки после одного выстрела' );

# опустошаем боезапас
$ship_unit->torpedo->ammo_count( $ship_unit->torpedo->ammo_count - 7 );
$ship_unit->main_cannon->ammo_count( $ship_unit->main_cannon->ammo_count - 198 );

is ( $ship_unit->main_cannon->reload, 0, 'Проверка перезаряжания пушки при отсутствующем боезапасе'   );

# опустошаем магазин пушки
$ship_unit->main_cannon->magazine_ammo( $ship_unit->main_cannon->magazine_ammo - 1 );

is ( $ship_unit->fire_cannon,    0, 'Проверка выстрела из пушки при незаряженном магазине' );
is ( $ship_unit->launch_torpedo, 0, 'Проверка запуска торпеды при отсутствующем боезапасе' );

# возвращаем заряд в магазин пушки и торпеду в боезапас, для дальнейшей проверки
$ship_unit->main_cannon->magazine_ammo(1);
$ship_unit->torpedo->ammo_count(1);

$ship_unit->move;
is ( $ship_unit->is_destroyed, 1, 'Проверка попытки поехать' );

# "воскрешаем" объект для дальнейшей проверки
$ship_unit->revive;

$ship_unit->fly;
is ( $ship_unit->is_destroyed, 1, 'Проверка попытки полететь' );

# "воскрешаем" объект для дальнейшей проверки
$ship_unit->revive;

is ( $ship_unit->get_damage(5000), 1, 'Получение максимального урона' );
is ( $ship_unit->get_damage(1),    0, 'Получение урона сверх максимального' );

# проверки возможности выполнять действия после уничтожения
is ( $ship_unit->destroy,        0, 'Проверка попытки уничтожить уже уничтоженный объект'            );
is ( $ship_unit->fire_cannon,    0, 'Проверка попытки выстрелить из пушки для уничтоженного объекта' );
is ( $ship_unit->launch_torpedo, 0, 'Проверка попытки запустить торпеду с уничтоженного объекта'     );
is ( $ship_unit->fly,            0, 'Проверка попытки полететь для уничтоженного объекта'            );
is ( $ship_unit->get_damage,     0, 'Проверка попытки нанести урон уже уничтоженному объекту'        );
is ( $ship_unit->out_to_sea,     0, 'Проверка попытки выйти в море для уничтоженного объекта'        );
is ( $ship_unit->move,           0, 'Проверка попытки поехать для уничтоженного объекта'             );
is ( $ship_unit->sail,           0, 'Проверка попытки поплыть для уничтоженного объекта'             );
