# класс корабельная техника
package Ship;

use Moose;
extends 'Vehicle';
with 'Mobile';

has 'main_cannon' => (
	is      => 'ro',
    isa     => 'Cannon',
    handles => { fire_cannon => 'shot' }
);

has 'torpedo' => (
	is      => 'ro',
    isa     => 'Torpedo',
    handles => { launch_torpedo => 'shot' }
);

# после создания выходим в море
after 'new' => sub {
    my ( $self ) = @_;
    $self->out_to_sea;
};

# рассчет критического попадания перед получением урона
before 'get_damage' => sub {
    my ( $self ) = @_;
	
    if ( $self->is_get_critical_damage ) {
        print 'Пробоина ниже ватерлинии!';
        $self->durability = 0;
    }
};

# после попытки поехать или полететь уничтожаем корабль
after [qw( move fly )] => sub {
    my ( $self ) = @_;
    
    print 'Корабли не летают и не ездят по суше!';
    $self->destroy;
};

sub out_to_sea {
    print 'вышел в море';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
