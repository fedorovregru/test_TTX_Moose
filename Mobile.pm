# роль передвижения для техники
package Mobile;

use Moose::Role;

sub move {
    print 'передвинулся';
    return 1;
};

sub fly {
    print 'прилетел';
    return 1;
};

sub sail {
    print 'приплыл';
    return 1;
};

return 1;
