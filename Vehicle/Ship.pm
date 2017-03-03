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

# расcчет критического попадания после получения урона
after 'get_damage' => sub {
    my ( $self ) = @_;
	
    if ( $self->is_get_critical_damage ) {
        print '[Пробоина ниже ватерлинии!]';
        $self->destroy;
    }
};

# после попытки полететь, уничтожаем единицу техники
after 'fly' => sub {
    my ( $self ) = @_;
    
    print '[снесло ветром :)!]';
    $self->destroy;
};

# после попытки поехать, уничтожаем единицу техники
after 'move' => sub {
    my ( $self ) = @_;
    
    print '[сел на мель!]';
    $self->destroy;
};

# после создания выходим в море
sub BUILD {
    my ( $self ) = @_;
    $self->out_to_sea;
};

sub out_to_sea {
    print '[вышел в море]';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable;
