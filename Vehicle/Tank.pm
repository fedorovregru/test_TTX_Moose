# класс танковая техника
package Tank;

use Moose;
extends 'Vehicle';
with 'Mobile';


has 'main_cannon' => (
    is      => 'ro',
    isa     => 'Cannon',
    handles => { fire_cannon => 'shot' }
);

has 'machine_gun' => (
    is      => 'ro',
    isa     => 'Machinegun',
    handles => { fire_machinegun => 'shot' }
);

# после создания выходим на позицию
after 'new' => sub {
    my ( $self ) = @_;
    $self->go_to_tanks_position;
};

# рассчет критического попадания перед получением урона
before 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( $self->is_get_critical_damage ) {  
        print 'Сдетонировал боекомплект!';
        $self->durability = 0;
    }
};

# после попытки полететь или поплыть уничтожаем танк
after [qw( fly sail )] => sub {
    my ( $self ) = @_;
    
    print 'Танки не летают и не плавают!';
    $self->destroy;
};

sub go_to_tanks_position {
    print 'вышел на позицию';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );
