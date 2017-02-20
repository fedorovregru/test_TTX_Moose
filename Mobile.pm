package Mobile;

use Moose::Role;

sub move {
    print 'передвинулся';
};

sub fly {
    print 'прилетел';
};

sub sail {
    print 'приплыл';
};
