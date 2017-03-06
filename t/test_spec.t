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

describe 'Тест класса Artillery' => sub {
	
	use Vehicle::Artillery;
	
	my $artillery = bless {}, 'Artillery';
	
	it 'метод go_to_artillery_position, объект еще активен.' => sub {
		
		$artillery->expects('is_destroyed')->returns(0)->once;
        ok $artillery->go_to_artillery_position;
	};
	
	it 'метод go_to_artillery_position, объект уже уничтожен.' => sub {
		
		$artillery->expects('is_destroyed')->returns(1)->once;
        ok !$artillery->go_to_artillery_position;
	};
	
	it 'метод get_damage, критическое попадание.' => sub {
		
		$artillery->expects('is_destroyed')->returns(0)->once;
		$artillery->expects('durability')->returns(1)->exactly(3);
		$artillery->expects('is_get_critical_damage')->returns(1)->once;
		$artillery->expects('destroy')->returns(1)->once;
		
        ok $artillery->get_damage(1);
	};
};

describe 'Тест класса Avia' => sub {
	
	use Vehicle::Avia;
	
	my $avia = bless {}, 'Avia';
	
	it 'метод takeoff, объект еще активен.' => sub {
		
		$avia->expects('is_destroyed')->returns(0)->once;
        ok $avia->takeoff;
	};
	
	it 'метод takeoff, объект уже уничтожен.' => sub {
		
		$avia->expects('is_destroyed')->returns(1)->once;
        ok !$avia->takeoff;
	};
	
	it 'метод get_damage, критическое попадание.' => sub {
		
		$avia->expects('is_destroyed')->returns(0)->once;
		$avia->expects('durability')->returns(1)->exactly(3);
		$avia->expects('is_get_critical_damage')->returns(1)->once;
		$avia->expects('destroy')->returns(1)->once;
		
        ok $avia->get_damage(1);
	};
};

describe 'Тест класса Ship' => sub {
	
	use Vehicle::Ship;
	
	my $ship = bless {}, 'Ship';
	
	it 'метод out_to_sea, объект еще активен.' => sub {
		
		$ship->expects('is_destroyed')->returns(0)->once;
        ok $ship->out_to_sea;
	};
	
	it 'метод out_to_sea, объект уже уничтожен.' => sub {
		
		$ship->expects('is_destroyed')->returns(1)->once;
        ok !$ship->out_to_sea;
	};
	
	it 'метод get_damage, критическое попадание.' => sub {
		
		$ship->expects('is_destroyed')->returns(0)->once;
		$ship->expects('durability')->returns(1)->exactly(3);
		$ship->expects('is_get_critical_damage')->returns(1)->once;
		$ship->expects('destroy')->returns(1)->once;
		
        ok $ship->get_damage(1);
	};
};

describe 'Тест класса Tank' => sub {
	
	use Vehicle::Tank;
	
	my $tank = bless {}, 'Tank';
	
	it 'метод go_to_tanks_position, объект еще активен.' => sub {
		
		$tank->expects('is_destroyed')->returns(0)->once;
        ok $tank->go_to_tanks_position;
	};
	
	it 'метод go_to_tanks_position, объект уже уничтожен.' => sub {
		
		$tank->expects('is_destroyed')->returns(1)->once;
        ok !$tank->go_to_tanks_position;
	};
	
	it 'метод get_damage, критическое попадание.' => sub {
		
		$tank->expects('is_destroyed')->returns(0)->once;
		$tank->expects('durability')->returns(1)->exactly(3);
		$tank->expects('is_get_critical_damage')->returns(1)->once;
		$tank->expects('destroy')->returns(1)->once;
		
        ok $tank->get_damage(1);
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
