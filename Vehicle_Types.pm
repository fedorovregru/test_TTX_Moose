# Танковая техника
package Tank_Vehicle;

use Moose;
extends 'Vehicle';
with 'Mobile';

after 'new' => sub {
    my ( $self ) = @_;
    $self->go_to_tanks_position;
};

after 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( int( rand(100) ) < 11 ) {  
        print 'Сдетонировал боекомплект!';
        $self->destroy;
    }
};

before [qw( fly sail )] => sub {
    my ( $self ) = @_;
    
    print 'Танки не летают и не плавают!';
    $self->destroy;
}

sub go_to_tanks_position {
    print 'вышел на позицию';
};

no Moose;
__PACKAGE__->meta->make_immutable;


# Артиллерийская техника
package Artillery_Vehicle;

use Moose;
extends 'Vehicle';
with 'Mobile';

after 'new' => sub {
    my ( $self ) = @_;
    $self->go_to_arty_position;
};

before [qw( fly sail )] => sub {
    my ( $self ) = @_;
    
    print 'Артиллеристы не летают и не плавают!';
    $self->destroy;
}

sub go_to_arty_position {
    print 'вышел на позицию';
};

no Moose;
__PACKAGE__->meta->make_immutable;


# Авиационная техника
package Avia_Vehicle;

use Moose;
extends 'Vehicle';
with 'Mobile';

after 'new' => sub {
    my ( $self ) = @_;
    $self->takeoff;
};

after 'get_damage' => sub {
    my ( $self ) = @_;
    
    if ( int( rand(100) ) < 11 ) {
        print 'Поврежден двигатель!';
        $self->destroy;
    }
};

before 'sail' => sub {
    my ( $self ) = @_;
    
    print 'Самолет утонул!';
    $self->destroy;
}

sub takeoff {
    print 'взлетел';
};

no Moose;
__PACKAGE__->meta->make_immutable;


# Корабельная техника
package Ship_Vehicle;

use Moose;
extends 'Vehicle';
with 'Mobile';

after 'new' => sub {
    my ( $self ) = @_;
    $self->out_to_sea;
};

after 'get_damage' => sub {
    my ( $self ) = @_;
	
    if ( int( rand(100) ) < 11 ) {
        print 'Пробоина ниже ватерлинии!';
        $self->destroy;
    }
};

before [qw( move fly )] => sub {
    my ( $self ) = @_;
    
    print 'Корабли не летают и ездят по суше!';
    $self->destroy;
}

sub out_to_sea {
    print 'вышел в море';
};

no Moose;
__PACKAGE__->meta->make_immutable;
