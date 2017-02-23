# класс артиллерийская техника
package Artillery;

use Moose;
extends 'Vehicle';
with 'Mobile';

has 'cannon' => (
	is      => 'ro',
    isa     => 'Cannon',
    handles => { fire => 'shot' }
);

# после создания выходим на позицию
after 'new' => sub {
    my ( $self ) = @_;
    $self->go_to_arty_position;
};

# рассчет критического попадания после получения урона
after 'get_damage' => sub {
	
    my ( $self ) = @_;
    
    if ( int( rand(100) ) < 11 ) {
        print 'Подрыв боекомплекта!';
        $self->destroy;
    }
};

# перед попыткой полететь или поплыть, уничтожаем единицу техники
before [qw( fly sail )] => sub {
	
    my ( $self ) = @_;
    
    print 'Артиллеристы не летают и не плавают!';
    $self->destroy;
};

sub go_to_arty_position {
    print 'вышел на позицию';
};

return 1;
