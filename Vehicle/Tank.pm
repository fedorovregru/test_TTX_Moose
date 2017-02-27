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

# расcчет критического попадания после получения урона
after 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( $self->is_get_critical_damage ) {  
        print 'Сдетонировал боекомплект!';
        $self->destroy;
    }
};

# после попытки полететь, уничтожаем единицу техники
after 'fly' => sub {
    my ( $self ) = @_;
    
    print 'снесло ветром :)!';
    $self->destroy;
};

# после попытки поплыть, уничтожаем единицу техники
after 'sail' => sub {
    my ( $self ) = @_;
    
    print 'утонул!';
    $self->destroy;
};

# после создания выходим на позицию
sub BUILD {
    my ( $self ) = @_;
    $self->go_to_tanks_position;
};

sub go_to_tanks_position {
    print 'вышел на позицию';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
