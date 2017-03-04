# роль передвижения для техники
package Mobile;

use Modern::Perl;
use Moose::Role;

sub move {
	my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
		say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
	
    say '[передвинулся]';
    return 1;
};

sub fly {
	my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
		say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
	
    say '[прилетел]';
    return 1;
};

sub sail {
	my ( $self ) = @_;
    
    # если объект уничтожен выходим со статусом "ноль"
    if ( $self->is_destroyed ) {
		say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
	
    say '[приплыл]';
    return 1;
};

return 1;
