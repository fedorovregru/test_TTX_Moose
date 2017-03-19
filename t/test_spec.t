#!/usr/bin/perl

use Modern::Perl;
use Test::Spec;

use Data::Dumper;

describe 'Объект класса Vehicle' => sub {

    use Vehicle;

    my $vehicle = bless { durability => 100 }, 'Vehicle';

    before each => sub {
        $vehicle->stubs( 'is_destroyed' => 0 );
    };

    describe 'метод destroy' => sub {

        it 'должен уничтожать объект, если тот еще активен.' => sub {
            ok $vehicle->destroy;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $vehicle->stubs( 'is_destroyed' => 1 );
            ok !$vehicle->destroy;
        };
    };

    describe 'метод get_damage' => sub {

        before each => sub {
            $vehicle->stubs( 'is_destroyed' => 0 );
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $vehicle->stubs( 'is_destroyed' => 1 );
            ok !$vehicle->get_damage;
        };

        it 'должен только уменьшать прочность, если повреждений наносится меньше чем текущая прочность.' => sub {

            my $required_durability = $vehicle->{durability} - 1;

            $vehicle->get_damage(1);
            ok $vehicle->{durability} == $required_durability;
        };

        it 'должен уменьшать прочность и уничтожать объект, если повреждений наносится больше чем текущая прочность или столько-же.' => sub {

            my $current_durability = $vehicle->{durability};

            $vehicle->expects('destroy')->returns(1)->once;
            ok $vehicle->get_damage($current_durability);
        };
    };
};

describe 'Объект класса Weapon' => sub {

    use Weapon;

    my $weapon = bless { ammo_count => 100 }, 'Weapon';

    before each => sub {
        $weapon->stubs( 'is_destroyed' => 0 );
    };

    describe 'метод aim' => sub {

        it 'должен выполнять прицеливание, если объект еще активен.' => sub {
            ok $weapon->aim;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $weapon->stubs( 'is_destroyed' => 1 );
            ok !$weapon->aim;
        };
    };

    describe 'метод shot' => sub {

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $weapon->stubs( 'is_destroyed' => 1 );
            ok !$weapon->shot;
        };

        it 'не должен выполняться, если боезапас пуст.' => sub {
            $weapon->stubs( 'ammo_count' => 0 );
            ok !$weapon->shot;
        };
        
        it 'должен уменьшать боезапас, если боезапас не пуст.' => sub {

            my $required_ammo_count = $weapon->{ammo_count} - 1;

            $weapon->shot;
            ok $weapon->{ammo_count} == $required_ammo_count;
        };
    };
};

describe 'Объект класса Artillery' => sub {

    use Vehicle::Artillery;

    my $artillery = bless { durability => 100 }, 'Artillery';

    before each => sub {
        $artillery->stubs( 'is_destroyed' => 0 );
    };

    describe 'метод go_to_artillery_position' => sub {

        it 'должен выполняться, если объект еще активен.' => sub {
            ok $artillery->go_to_artillery_position;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $artillery->stubs( 'is_destroyed' => 1 );
            ok !$artillery->go_to_artillery_position;
        };
    };

    it 'при вызове метода get_damage должно происходить уничтожение объекта при критическом попадании.' => sub {

        my $required_durability = $artillery->{durability} - 1;

        $artillery->expects('is_get_critical_damage')->returns(1)->once;
        $artillery->expects('destroy')->returns(1)->once;

        ok $artillery->get_damage(1);

        ok $artillery->{durability} == $required_durability;
    };
};

describe 'Объект класса Avia' => sub {

    use Vehicle::Avia;

    my $avia = bless { durability => 100 }, 'Avia';

    before each => sub {
        $avia->stubs( 'is_destroyed' => 0 );
    };

    describe 'метод takeoff' => sub {

        it 'должен выполняться, если объект еще активен.' => sub {
            ok $avia->takeoff;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $avia->stubs( 'is_destroyed' => 1 );
            ok !$avia->takeoff;
        };
    };

    it 'при вызове метода get_damage должно происходить уничтожение объекта при критическом попадании.' => sub {

        my $required_durability = $avia->{durability} - 1;

        $avia->expects('is_get_critical_damage')->returns(1)->once;
        $avia->expects('destroy')->returns(1)->once;

        ok $avia->get_damage(1);

        ok $avia->{durability} = $required_durability;
    };
};

describe 'Объект класса Ship' => sub {

    use Vehicle::Ship;

    my $ship = bless { durability => 100 }, 'Ship';

    before each => sub {
        $ship->stubs( 'is_destroyed' => 0 );
    };

    describe 'метод out_to_sea' => sub {

        it 'должен выполняться, если объект еще активен.' => sub {
            ok $ship->out_to_sea;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $ship->stubs( 'is_destroyed' => 1 );
            ok !$ship->out_to_sea;
        };
    };

    it 'при вызове метода get_damage должно происходить уничтожение объекта при критическом попадании.' => sub {

        my $required_durability = $ship->{durability} - 1;

        $ship->expects('is_get_critical_damage')->returns(1)->once;
        $ship->expects('destroy')->returns(1)->once;

        ok $ship->get_damage(1);

        ok $ship->{durability} == $required_durability;
    };
};

describe 'Объект класса Tank' => sub {

    use Vehicle::Tank;

    my $tank = bless { durability => 100 }, 'Tank';

    before each => sub {
        $tank->stubs( 'is_destroyed' => 0 );
    };

    describe 'метод go_to_tanks_position' => sub {

        it 'должен выполняться, если объект еще активен.' => sub {
            ok $tank->go_to_tanks_position;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $tank->stubs( 'is_destroyed' => 1 );
            ok !$tank->go_to_tanks_position;
        };
    };

    it 'при вызове метода get_damage должно происходить уничтожение объекта при критическом попадании.' => sub {

        my $required_durability = $tank->{durability} - 1;

        $tank->expects('is_get_critical_damage')->returns(1)->once;
        $tank->expects('destroy')->returns(1)->once;

        ok $tank->get_damage(1);

        ok $tank->{durability} == $required_durability;
    };
};

describe 'Объект с ролью Mobile' => sub {

    use Vehicle::Artillery;
    use Vehicle::Avia;
    use Vehicle::Ship;

    my $mobile_move = bless {}, 'Artillery';
    my $mobile_fly  = bless {}, 'Avia';
    my $mobile_sail = bless {}, 'Ship';

    before each => sub {
        $mobile_move->stubs( 'is_destroyed' => 0 );
        $mobile_fly->stubs(  'is_destroyed' => 0 );
        $mobile_sail->stubs( 'is_destroyed' => 0 );
    };

    describe 'метод move' => sub {

        it 'должен выполняться, если объект еще активен.' => sub {
            ok $mobile_move->move;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $mobile_move->stubs( 'is_destroyed' => 1 );
            ok !$mobile_move->move;
        };
    };

    describe 'метод fly' => sub {
        
        it 'должен выполняться, если объект еще активен.' => sub {
            ok $mobile_fly->fly;
        };
        
        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $mobile_fly->stubs( 'is_destroyed' => 1 );
            ok !$mobile_fly->fly;
        };
    };
    
    describe 'метод sail,' => sub {
        
        it 'должен выполняться, если объект еще активен.' => sub {
            ok $mobile_sail->sail;
        };
        
        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $mobile_sail->stubs( 'is_destroyed' => 1 );
            ok !$mobile_sail->sail;
        };
    };
};

describe 'Оружие с ролью Reloadable' => sub {

    use Weapon::Cannon;

    my $reloadable = bless {
        magazine_ammo => 50,
        magazine_size => 50,
        ammo_count    => 55
    }, 'Cannon';

    before each => sub {
        $reloadable->stubs( 'is_destroyed' => 0 );
    };

    describe 'метод shot' => sub {

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $reloadable->stubs( 'is_destroyed' => 1 );
            ok !$reloadable->shot;
        };

        it 'не должен выполняться, если оружие не заряжено и перезарядка невозможна.' => sub {

            $reloadable->stubs( 'magazine_ammo' => 0 );
            $reloadable->expects('reload')->returns(0)->once;

            ok !$reloadable->shot;
        };

        it 'не должен выполняться, если оружие не заряжено и перезарядка возможна.' => sub {

            $reloadable->stubs( 'magazine_ammo' => 0 );            
            $reloadable->expects('reload')->returns(1)->once;

            ok !$reloadable->shot;
        };

        it 'должен уменьшать заряды в магазине, если оружие заряжено.' => sub {

            my $required_magazine_ammo_after_shot = $reloadable->{magazine_ammo} - 1;

            ok $reloadable->shot;
            ok $reloadable->{magazine_ammo} == $required_magazine_ammo_after_shot;
        };
    };

    describe 'метод reload' => sub {

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $reloadable->stubs( 'is_destroyed' => 1 );
            ok !$reloadable->reload;
        };

        it 'не должен выполняться, если боезапас пуст.' => sub {
            $reloadable->stubs( 'ammo_count' => 0 );
            ok !$reloadable->reload;
        };

        it 'должен производить полный перезаряд, если боеприпасов на полный перезаряд достаточно.' => sub {

            my $required_ammo_count_after_reload = $reloadable->{ammo_count} - $reloadable->{magazine_size};

            ok $reloadable->reload;
            ok ( $reloadable->{magazine_ammo} == $reloadable->{magazine_size} && $reloadable->{ammo_count} == $required_ammo_count_after_reload );
        };

        it 'должен производить частичный перезаряд, если боеприпасов на полный перезаряд недостаточно.' => sub {

            my $required_magazine_size_after_reload = $reloadable->{ammo_count};

            ok $reloadable->reload;
            ok ( $reloadable->{magazine_ammo} == $required_magazine_size_after_reload && $reloadable->{ammo_count} == 0 );
        };
    };
};

runtests unless caller;
