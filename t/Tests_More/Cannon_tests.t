#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 23;
use Test::Exception;

use Data::Dumper;

use_ok( 'Weapon::Cannon' );

subtest 'Тест объекта с вручную заданными параметрами' => sub {

    plan tests => 6;
    
    # создаем объект с вручную заданными параметрами
    my $cannon_unit = Cannon->new(
        ammo_type     => 'Снаряд',
        ammo_count    => 30,
        magazine_size => 2,
        magazine_ammo => 0,
        is_destroyed  => 1
    );

    isa_ok( $cannon_unit, 'Cannon' );

    # тесты полей объекта при создании с вручную заданными параметрами
    is( $cannon_unit->ammo_type,     'Снаряд', 'Проверка типа боезапаса орудия "пушка".'                  );
    is( $cannon_unit->ammo_count,    30,       'Проверка количества боезапаса орудия "пушка".'            );
    is( $cannon_unit->magazine_size, 2,        'Проверка размера магазина орудия "пушка".'                );
    is( $cannon_unit->magazine_ammo, 0,        'Проверка количества боезапаса в магазине орудия "пушка".' );
    is( $cannon_unit->is_destroyed,  1,        'Проверка флага уничтоженного орудия "пушка".'             );
};

subtest 'Тест объекта с параметрами по-умолчанию' => sub {

    plan tests => 6;
    
    # создаем объект с параметрами по-умолчанию
    my $cannon_unit = Cannon->new(
        ammo_type  => 'Снаряд',
        ammo_count => 30
    );

    isa_ok( $cannon_unit, 'Cannon' );

    # тесты полей объекта при создании с параметрами по-умолчанию
    is( $cannon_unit->ammo_type,     'Снаряд', 'Проверка типа боезапаса орудия "пушка".'                  );
    is( $cannon_unit->ammo_count,    29,       'Проверка количества боезапаса орудия "пушка".'            );
    is( $cannon_unit->magazine_size, 1,        'Проверка размера магазина орудия "пушка".'                );
    is( $cannon_unit->magazine_ammo, 1,        'Проверка количества боезапаса в магазине орудия "пушка".' );
    is( $cannon_unit->is_destroyed,  0,        'Проверка флага уничтоженного орудия "пушка".'             );
};

# создаем тестовый объект
my $cannon_unit = Cannon->new(
    ammo_type     => 'Снаряд',
    ammo_count    => 100,
    magazine_size => 10
);

# проверки наличия методов
can_ok( $cannon_unit, 'BUILD'  );
can_ok( $cannon_unit, 'aim'    );
can_ok( $cannon_unit, 'shot'   );
can_ok( $cannon_unit, 'reload' );

# проверка записи некорректных данных в поля объекта
dies_ok { $cannon_unit->ammo_type(     10     ) } 'Попытка записи некорректного значения в ammo_type.';
dies_ok { $cannon_unit->ammo_count(    'test' ) } 'Попытка записи некорректного значения в ammo_count.';
dies_ok { $cannon_unit->magazine_size( 'test' ) } 'Попытка записи некорректного значения в magazine_size.';
dies_ok { $cannon_unit->magazine_ammo( 'test' ) } 'Попытка записи некорректного значения в magazine_ammo.';
dies_ok { $cannon_unit->is_destroyed(  'test' ) } 'Попытка записи некорректного значения в is_destroyed.';

# производим выстрел из пушки, проверяем уменьшение зарядов в магазине и сохранение боезапаса
$cannon_unit->shot;
is ( $cannon_unit->magazine_ammo, 9,  'Проверка магазина орудия "пушка" после выстрела.'  );
is ( $cannon_unit->ammo_count,    90, 'Проверка боезапаса орудия "пушка" после выстрела.' );

# уменьшаем патроны в магазине пушки до одного
$cannon_unit->magazine_ammo(1);
# производим выстрел из пушки, проверяем произошла ли перезарядка
$cannon_unit->shot;
is ( $cannon_unit->magazine_ammo, 10, 'Проверка магазина орудия "пушка" после выстрела с последующей перезарядкой.'  );
is ( $cannon_unit->ammo_count,    80, 'Проверка боезапаса орудия "пушка" после выстрела с последующей перезарядкой.' );

# уменьшаем боезапас до одного заряда для проверки неполной перезарядки орудия "пушка"
$cannon_unit->ammo_count(1);
is ( $cannon_unit->reload,        1, 'Проверка перезарядки орудия "пушка" при недостатке боезапаса до полного перезаряда.'                );
is ( $cannon_unit->magazine_ammo, 1, 'Проверка магазина орудия "пушка" после перезарядки при недостатке боезапаса до полного перезаряда.' );

# обнуляем боезапас у пушки, проверяем невозможность перезарядки
$cannon_unit->ammo_count(0);
is ( $cannon_unit->reload, 0, 'Проверка перезарядки орудия "пушка" при отсутствующем боезапасе.' );

# обнуляем магазин у пушки, проверяем невозможность выстрела
$cannon_unit->magazine_ammo(0);
is ( $cannon_unit->shot, 0, 'Проверка выстрела из орудия "пушка" при пустом магазине.'   );

# возвращаем один заряд в магазин для последующей проверки
$cannon_unit->magazine_ammo(1);

# уничтожаем пушку и проверяем невозможность выполнять действия после уничтожения
$cannon_unit->is_destroyed(1);

is ( $cannon_unit->aim,    0, 'Проверка попытки выстрелить из орудия "пушка" для уже уничтоженного объекта.' );
is ( $cannon_unit->shot,   0, 'Проверка попытки прицелится из орудия "пушка" для уже уничтоженного объекта.' );
is ( $cannon_unit->reload, 0, 'Проверка попытки перезарядить орудие "пушка" для уже уничтоженного объекта.'  );
