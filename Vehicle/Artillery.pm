# класс артиллерийская техника
package Artillery;

use Moose;
extends 'Vehicle';
with 'Mobile';

has 'cannon' => (
    is      => 'ro',
    isa     => 'Cannon',
    handles => { fire_cannon => 'shot' }
);

# после создания выходим на позицию
after 'new' => sub {
    my ( $self ) = @_;
    $self->go_to_artillery_position;
};

# рассчет критического попадания перед получением урона
before 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( $self->is_get_critical_damage ) {
        print 'Подрыв боекомплекта!';
        $self->durability = 0;
    }
};

# после попытки полететь или поплыть, уничтожаем единицу техники
after [qw( fly sail )] => sub {
    my ( $self ) = @_;
    
    print 'Артиллеристы не летают и не плавают!';
    $self->destroy;
};

sub go_to_artillery_position {
    print 'вышел на позицию';
    return 1;
};

no Moose;
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );
