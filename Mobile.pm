# роль передвижения для техники
package Mobile;

use Modern::Perl;
use Moose::Role;

# если объект уничтожен выходим со статусом "ноль"
around [qw( move fly sail )] => sub {
    my $orig = shift;
    my $self = shift;
    
    if ( $self->is_destroyed ) {
        say '[действие невозможно, объект уничтожен!]';
        return 0;
    }
    
    $self->$orig;
};

sub move {
    say '[передвинулся]';
    return 1;
};

sub fly {
    say '[прилетел]';
    return 1;
};

sub sail {
    say '[приплыл]';
    return 1;
};

return 1;
