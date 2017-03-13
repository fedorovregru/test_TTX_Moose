#!/usr/bin/perl

use Modern::Perl;
use Test::Spec;

use Data::Dumper;

describe 'Объект класса Vehicle' => sub {
    
    use Vehicle;
    
    my $vehicle = bless {}, 'Vehicle';
    
    describe 'метод destroy' => sub {
        
        it 'должен уничтожать объект, если тот еще активен.' => sub {
            $vehicle->expects('is_destroyed')->returns(0)->exactly(2);
            ok $vehicle->destroy;
        };
        
        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $vehicle->expects('is_destroyed')->returns(1)->once;
            ok !$vehicle->destroy;
        };
    };
    
    describe 'метод get_damage' => sub {
        
        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $vehicle->expects('is_destroyed')->returns(1)->once;
            ok !$vehicle->get_damage;
        };
        
        it 'должен только уменьшать прочность, если повреждений наносится меньше чем текущая прочность.' => sub {
            
            $vehicle->expects('is_destroyed')->returns(0)->once;
            $vehicle->expects('durability')->returns(1)->exactly(3);
            
            ok $vehicle->get_damage(1);
        };
        
        it 'должен уменьшать прочность и уничтожать объект, если повреждений наносится больше чем текущая прочность или столько-же.' => sub {
            
            $vehicle->expects('is_destroyed')->returns(0)->once;
            $vehicle->expects('durability')->returns(0)->exactly(3);
            $vehicle->expects('destroy')->returns(2)->once;
            
            ok $vehicle->get_damage(1) == 2;
        };
    };
};

describe 'Объект класса Weapon' => sub {
    
    use Weapon;
    
    my $weapon = bless {}, 'Weapon';
    
    describe 'метод aim' => sub {
        
        it 'должен выполнять прицеливание, если объект еще активен.' => sub {
            $weapon->expects('is_destroyed')->returns(0)->once;
            ok $weapon->aim;
        };
        
        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $weapon->expects('is_destroyed')->returns(1)->once;
            ok !$weapon->aim;
        };
    };
    
    describe 'метод shot' => sub {

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $weapon->expects('is_destroyed')->returns(1)->once;
            ok !$weapon->shot;
        };
        
        it 'не должен выполняться, если боезапас пуст.' => sub {
            
            $weapon->expects('is_destroyed')->returns(0)->once;
            $weapon->expects('ammo_count')->returns(0)->once;
            
            ok !$weapon->shot;
        };
        
        it 'должен уменьшать боезапас, если боезапас не пуст.' => sub {
            
            $weapon->expects('is_destroyed')->returns(0)->once;
            $weapon->expects('ammo_count')->returns(1)->exactly(3);
            
            ok $weapon->shot;
        };
    };
};

describe 'Объект класса Artillery' => sub {

    use Vehicle::Artillery;
    
    my $artillery = bless {}, 'Artillery';

    describe 'метод go_to_artillery_position' => sub {

        it 'должен выполняться, если объект еще активен.' => sub {
            $artillery->expects('is_destroyed')->returns(0)->once;
            ok $artillery->go_to_artillery_position;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $artillery->expects('is_destroyed')->returns(1)->once;
            ok !$artillery->go_to_artillery_position;
        };
    };
    
    it 'при вызове метода get_damage должно происходить уничтожение объекта при критическом попадании.' => sub {
        
        $artillery->expects('is_destroyed')->returns(0)->once;
        $artillery->expects('durability')->returns(1)->exactly(3);
        $artillery->expects('is_get_critical_damage')->returns(1)->once;
        $artillery->expects('destroy')->returns(1)->once;
        
        ok $artillery->get_damage(1);
    };
};

describe 'Объект класса Avia' => sub {
    
    use Vehicle::Avia;
    
    my $avia = bless {}, 'Avia';
    
    describe 'метод takeoff' => sub {

        it 'должен выполняться, если объект еще активен.' => sub {
            $avia->expects('is_destroyed')->returns(0)->once;
            ok $avia->takeoff;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $avia->expects('is_destroyed')->returns(1)->once;
            ok !$avia->takeoff;
        };
    };
    
    it 'при вызове метода get_damage должно происходить уничтожение объекта при критическом попадании.' => sub {
        
        $avia->expects('is_destroyed')->returns(0)->once;
        $avia->expects('durability')->returns(1)->exactly(3);
        $avia->expects('is_get_critical_damage')->returns(1)->once;
        $avia->expects('destroy')->returns(1)->once;
        
        ok $avia->get_damage(1);
    };
};

describe 'Объект класса Ship' => sub {
    
    use Vehicle::Ship;
    
    my $ship = bless {}, 'Ship';
    
    describe 'метод out_to_sea' => sub {

        it 'должен выполняться, если объект еще активен.' => sub {
            $ship->expects('is_destroyed')->returns(0)->once;
            ok $ship->out_to_sea;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $ship->expects('is_destroyed')->returns(1)->once;
            ok !$ship->out_to_sea;
        };
    };
    
    it 'при вызове метода get_damage должно происходить уничтожение объекта при критическом попадании.' => sub {
        
        $ship->expects('is_destroyed')->returns(0)->once;
        $ship->expects('durability')->returns(1)->exactly(3);
        $ship->expects('is_get_critical_damage')->returns(1)->once;
        $ship->expects('destroy')->returns(1)->once;
        
        ok $ship->get_damage(1);
    };
};

describe 'Объект класса Tank' => sub {
    
    use Vehicle::Tank;
    
    my $tank = bless {}, 'Tank';
    
    describe 'метод go_to_tanks_position' => sub {

        it 'должен выполняться, если объект еще активен.' => sub {
            $tank->expects('is_destroyed')->returns(0)->once;
            ok $tank->go_to_tanks_position;
        };

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $tank->expects('is_destroyed')->returns(1)->once;
            ok !$tank->go_to_tanks_position;
        };
    };
    
    it 'при вызове метода get_damage должно происходить уничтожение объекта при критическом попадании.' => sub {
        
        $tank->expects('is_destroyed')->returns(0)->once;
        $tank->expects('durability')->returns(1)->exactly(3);
        $tank->expects('is_get_critical_damage')->returns(1)->once;
        $tank->expects('destroy')->returns(1)->once;
        
        ok $tank->get_damage(1);
    };
};

describe 'Объект с ролью Mobile' => sub {

    use Vehicle::Artillery;
    use Vehicle::Avia;
    use Vehicle::Ship;
    
    my $mobile_move = bless {}, 'Artillery';
    my $mobile_fly  = bless {}, 'Avia';
    my $mobile_sail = bless {}, 'Ship';
    
    describe 'метод move' => sub {
        
        it 'должен выполняться, если объект еще активен.' => sub {
            $mobile_move->expects('is_destroyed')->returns(0)->once;
            ok $mobile_move->move;
        };
        
        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $mobile_move->expects('is_destroyed')->returns(1)->once;
            ok !$mobile_move->move;
        };
    };
    
    describe 'метод fly' => sub {
        
        it 'должен выполняться, если объект еще активен.' => sub {
            $mobile_fly->expects('is_destroyed')->returns(0)->once;
            ok $mobile_fly->fly;
        };
        
        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $mobile_fly->expects('is_destroyed')->returns(1)->once;
            ok !$mobile_fly->fly;
        };
    };
    
    describe 'метод sail,' => sub {
        
        it 'должен выполняться, если объект еще активен.' => sub {
            $mobile_sail->expects('is_destroyed')->returns(0)->once;
            ok $mobile_sail->sail;
        };
        
        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $mobile_sail->expects('is_destroyed')->returns(1)->once;
            ok !$mobile_sail->sail;
        };
    };
};

describe 'Оружие с ролью Reloadable' => sub {
    
    use Weapon::Cannon;
    
    my $reloadable = bless {}, 'Cannon';
    
    describe 'метод shot' => sub {

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $reloadable->expects('is_destroyed')->returns(1)->exactly(2);
            ok !$reloadable->shot;
        };
        
        it 'не должен выполняться, если оружие не заряжено и перезарядка невозможна.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('magazine_ammo')->returns(0)->exactly(2);
            $reloadable->expects('reload')->returns(0)->once;
            
            ok !$reloadable->shot;
        };
        
        it 'не должен выполняться, если оружие не заряжено и перезарядка возможна.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('magazine_ammo')->returns(0)->exactly(2);
            $reloadable->expects('reload')->returns(1)->once;
            
            ok !$reloadable->shot;
        };
        
        it 'должен уменьшать заряды в магазине, если оружие заряжено.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('magazine_ammo')->returns(1)->exactly(4);
            
            ok $reloadable->shot;
        };
    };
    
    describe 'метод reload' => sub {

        it 'не должен выполняться, если объект уже уничтожен.' => sub {
            $reloadable->expects('is_destroyed')->returns(1)->once;
            ok !$reloadable->reload;
        };
        
        it 'не должен выполняться, если боезапас пуст.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('ammo_count')->returns(0)->once;
            
            ok !$reloadable->reload;
        };
        
        it 'должен производить полный перезаряд, если боеприпасов на полный перезаряд достаточно.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('ammo_count')->returns(10)->exactly(4);
            $reloadable->expects('magazine_size')->returns(1)->exactly(3);
            $reloadable->expects('magazine_ammo')->once;
            
            ok $reloadable->reload;
        };
        
        it 'должен производить частичный перезаряд, если боеприпасов на полный перезаряд недостаточно.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('ammo_count')->returns(5)->exactly(6);
            $reloadable->expects('magazine_size')->returns(10)->exactly(2);
            $reloadable->expects('magazine_ammo')->once;
            
            ok $reloadable->reload;
        };
    };
};

runtests unless caller;
