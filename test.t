#!/usr/bin/perl

use Modern::Perl;
use Test::Spec;

use Data::Dumper;

describe 'Тест класса Vehicle,' => sub {
    
    use Vehicle;
    
    my $vehicle = bless {}, 'Vehicle';
    
    describe 'метод destroy,' => sub {
        
        it 'объект еще активен.' => sub {
            $vehicle->expects('is_destroyed')->returns(0)->once;
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

describe 'Тест роли Mobile,' => sub {
	
	use Mobile;
	
	my $mobile = bless {}, 'Mobile';
	
	describe 'метод move,' => sub {
		
		it 'объект еще активен.' => sub {
            $mobile->expects('is_destroyed')->returns(0)->once;
            ok $mobile->move;
        };
        
        it 'объект уже уничтожен.' => sub {
            $mobile->expects('is_destroyed')->returns(1)->once;
            ok !$mobile->move;
        };
	};
	
	describe 'метод fly,' => sub {
		
		it 'объект еще активен.' => sub {
            $mobile->expects('is_destroyed')->returns(0)->once;
            ok $mobile->fly;
        };
        
        it 'объект уже уничтожен.' => sub {
            $mobile->expects('is_destroyed')->returns(1)->once;
            ok !$mobile->fly;
        };
	};
	
	describe 'метод sail,' => sub {
		
		it 'объект еще активен.' => sub {
            $mobile->expects('is_destroyed')->returns(0)->once;
            ok $mobile->sail;
        };
        
        it 'объект уже уничтожен.' => sub {
            $mobile->expects('is_destroyed')->returns(1)->once;
            ok !$mobile->sail;
        };
	};
};

describe 'Тест роли Reloadable,' => sub {
	
	use Reloadable;
	
	my $reloadable = bless {}, 'Reloadable';
	
	describe 'метод shot,' => sub {

        it 'объект уже уничтожен.' => sub {
            $reloadable->expects('is_destroyed')->returns(1)->once;
            ok !$reloadable->shot;
        };
        
        it 'объект еще активен, оружие не заряжено.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('magazine_ammo')->returns(0)->once;
            
            ok !$reloadable->shot;
        };
        
        it 'объект еще активен, оружие заряжено.' => sub {
            
            $reloadable->expects('is_destroyed')->returns(0)->once;
            $reloadable->expects('magazine_ammo')->returns(1)->exactly(3);
            
            ok $reloadable->shot;
        };
	};
};

runtests unless caller;
