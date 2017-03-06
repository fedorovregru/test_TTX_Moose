#!/usr/bin/perl

use Modern::Perl;
use Test::Spec;

use Data::Dumper;

describe 'Тест класса Vehicle,' => sub {
    
    use Vehicle;
    
    my $vehicle = bless {}, 'Vehicle';
    
    describe 'метод destroy,' => sub {
        
        it 'объект еще активен.' => sub {
            $vehicle->expects('is_destroyed')->returns(0)->exactly(2);
            ok $vehicle->destroy;
        };
        
        it 'объект уже уничтожен.' => sub {
            $vehicle->expects('is_destroyed')->returns(1)->once;
            ok !$vehicle->destroy;
        };
    };
    
    describe 'метод get_damage,' => sub {
        
        it 'объект уже уничтожен.' => sub {
            $vehicle->expects('is_destroyed')->returns(1)->once;
            ok !$vehicle->get_damage;
        };
        
        it 'объект еще активен, получение повреждений меньше чем текущая прочность.' => sub {
            
            $vehicle->expects('is_destroyed')->returns(0)->once;
            $vehicle->expects('durability')->returns(1)->exactly(3);
            
            ok $vehicle->get_damage(1);
        };
        
        it 'объект еще активен, получение повреждений больше чем текущая прочность.' => sub {
            
            $vehicle->expects('is_destroyed')->returns(0)->once;
            $vehicle->expects('durability')->returns(0)->exactly(3);
            $vehicle->expects('destroy')->returns(2)->once;
            
            ok $vehicle->get_damage(1) == 2;
        };
    };
};

describe 'Тест класса Weapon,' => sub {
    
    use Weapon;
    
    my $weapon = bless {}, 'Weapon';
    
    describe 'метод aim,' => sub {
        
        it 'объект еще активен.' => sub {
            $weapon->expects('is_destroyed')->returns(0)->once;
            ok $weapon->aim;
        };
        
        it 'объект уже уничтожен.' => sub {
            $weapon->expects('is_destroyed')->returns(1)->once;
            ok !$weapon->aim;
        };
    };
    
    describe 'метод shot,' => sub {

        it 'объект уже уничтожен.' => sub {
            $weapon->expects('is_destroyed')->returns(1)->once;
            ok !$weapon->shot;
        };
        
        it 'объект еще активен, боезапас пуст.' => sub {
            
            $weapon->expects('is_destroyed')->returns(0)->once;
            $weapon->expects('ammo_count')->returns(0)->once;
            
            ok !$weapon->shot;
        };
        
        it 'объект еще активен, боезапас не пуст.' => sub {
            
            $weapon->expects('is_destroyed')->returns(0)->once;
            $weapon->expects('ammo_count')->returns(1)->exactly(3);
            
            ok $weapon->shot;
        };
    };
};



describe 'Тест роли Mobile,' => sub {

    use Vehicle::Artillery;
    use Vehicle::Avia;
    use Vehicle::Ship;
    
    my $mobile_move = bless {}, 'Artillery';
    my $mobile_fly  = bless {}, 'Avia';
    my $mobile_sail = bless {}, 'Ship';
    
    describe 'метод move,' => sub {
        
        it 'объект еще активен.' => sub {
            $mobile_move->expects('is_destroyed')->returns(0)->once;
            ok $mobile_move->move;
        };
        
        it 'объект уже уничтожен.' => sub {
            $mobile_move->expects('is_destroyed')->returns(1)->once;
            ok !$mobile_move->move;
        };
    };
    
    describe 'метод fly,' => sub {
        
        it 'объект еще активен.' => sub {
            $mobile_fly->expects('is_destroyed')->returns(0)->once;
            ok $mobile_fly->fly;
        };
        
        it 'объект уже уничтожен.' => sub {
            $mobile_fly->expects('is_destroyed')->returns(1)->once;
            ok !$mobile_fly->fly;
        };
    };
    
    describe 'метод sail,' => sub {
        
        it 'объект еще активен.' => sub {
            $mobile_sail->expects('is_destroyed')->returns(0)->once;
            ok $mobile_sail->sail;
        };
        
        it 'объект уже уничтожен.' => sub {
            $mobile_sail->expects('is_destroyed')->returns(1)->once;
            ok !$mobile_sail->sail;
        };
    };
};

describe 'Тест роли Reloadable,' => sub {
    
    use Weapon::Cannon;
    
    my $reloadable = bless {}, 'Cannon';
    
    describe 'метод shot,' => sub {

        it 'объект уже уничтожен.' => sub {
            $reloadable->expects('is_destroyed')->returns(1)->exactly(2);
            ok !$reloadable->shot;
        };
        
        it 'объект еще активен, оружие не заряжено, перезарядка невозможна.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('magazine_ammo')->returns(0)->exactly(2);
            $reloadable->expects('reload')->returns(0)->once;
            
            ok !$reloadable->shot;
        };
        
        it 'объект еще активен, оружие не заряжено, перезарядка возможна.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('magazine_ammo')->returns(0)->exactly(2);
            $reloadable->expects('reload')->returns(1)->once;
            
            ok !$reloadable->shot;
        };
        
        it 'объект еще активен, оружие заряжено.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('magazine_ammo')->returns(1)->exactly(4);
            
            ok $reloadable->shot;
        };
    };
    
    describe 'метод reload,' => sub {

        it 'объект уже уничтожен.' => sub {
            $reloadable->expects('is_destroyed')->returns(1)->once;
            ok !$reloadable->reload;
        };
        
        it 'объект еще активен, боезапас пуст.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('ammo_count')->returns(0)->once;
            
            ok !$reloadable->reload;
        };
        
        it 'объект еще активен, боеприпасов на полный перезаряд достаточно.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('ammo_count')->returns(10)->exactly(4);
            $reloadable->expects('magazine_size')->returns(1)->exactly(3);
            $reloadable->expects('magazine_ammo')->once;
            
            ok $reloadable->reload;
        };
        
        it 'объект еще активен, боеприпасов на полный перезаряд недостаточно.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('ammo_count')->returns(5)->exactly(6);
            $reloadable->expects('magazine_size')->returns(10)->exactly(2);
            $reloadable->expects('magazine_ammo')->once;
            
            ok $reloadable->reload;
        };
    };
};

runtests unless caller;
