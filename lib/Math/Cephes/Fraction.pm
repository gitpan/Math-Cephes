############# Class : fract ##############
package Math::Cephes::Fraction;
use strict;
use vars qw(%OWNER %BLESSEDMEMBERS %ITERATORS 
	    @EXPORT_OK %EXPORT_TAGS $VERSION);

require Exporter;
*import = \&Exporter::import;
#my @fract = qw(radd rsub rmul rdiv euclid fract mixed_fract);
my @fract = qw(euclid fract mixed_fract);
@EXPORT_OK = (@fract);
%EXPORT_TAGS = ('fract' => [@fract]);

%OWNER = ();
%BLESSEDMEMBERS = ();
%ITERATORS = ();
$VERSION = '0.25';

#use Math::Cephes qw(new_fract euclid);
require Math::Cephes;

sub new {
    my $self = shift;
    my @args = @_;
    $self = Math::Cephes::new_fract(@args);
    return undef if (!defined($self));
    bless $self, "Math::Cephes::Fraction";
    $OWNER{$self} = 1;
    my %retval;
    tie %retval, "Math::Cephes::Fraction", $self;
    return bless \%retval,"Math::Cephes::Fraction";
}

sub fract {
  return Math::Cephes::Fraction->new(@_);
}

sub euclid {
  return Math::Cephes::euclid($_[0], $_[1]);
}

sub TIEHASH {
    my ($classname,$obj) = @_;
    return bless $obj, $classname;
}
  
sub DESTROY {
  return undef if ref($_[0]) ne 'HASH';
    my $self = tied(%{$_[0]});
    delete $ITERATORS{$self};
    if (exists $OWNER{$self}) {
        Math::Cephes::delete_fract($self);
        delete $OWNER{$self};
    }
}

sub DISOWN {
    my $self = shift;
    my $ptr = tied(%$self);
    delete $OWNER{$ptr};
    };

sub ACQUIRE {
    my $self = shift;
    my $ptr = tied(%$self);
    $OWNER{$ptr} = 1;
    };

sub FETCH {
    my ($self,$field) = @_;
    no strict 'refs';
    my $member_func = "Math::Cephes::fract_${field}_get";
    my $val = &$member_func($self);
    if (exists $BLESSEDMEMBERS{$field}) {
        return undef if (!defined($val));
        my %retval;
        tie %retval,$BLESSEDMEMBERS{$field},$val;
        return bless \%retval, $BLESSEDMEMBERS{$field};
    }
    return $val;
}

sub STORE {
    my ($self,$field,$newval) = @_;
    no strict 'refs';
    my $member_func = "Math::Cephes::fract_${field}_set";
    if (exists $BLESSEDMEMBERS{$field}) {
        &$member_func($self,tied(%{$newval}));
    } else {
        &$member_func($self,$newval);
    }
}

sub FIRSTKEY {
    my $self = shift;
    $ITERATORS{$self} = ['n', 'd', ];
    my $first = shift @{$ITERATORS{$self}};
    return $first;
}

sub NEXTKEY {
    my $self = shift;
    my $nelem = scalar @{$ITERATORS{$self}};
    if ($nelem > 0) {
        my $member = shift @{$ITERATORS{$self}};
        return $member;
    } else {
        $ITERATORS{$self} = ['n', 'd', ];
        return ();
    }
}


sub mixed_fract {
  my $f = shift;
  my $nin = int($f->{n});
  my $din = int($f->{d});
  my $gcd;
   if ($din < 0) {
     $din *= -1;
     $nin *= -1;
   }
   if (abs($nin) < abs($din)) {
     if ( $nin == 0 ) {
       return (0, 0, 0);
     }
     else {
       ($gcd, $nin, $din) = euclid($nin, $din);
       return (0, $nin, $din);
     }
   }
   else {
     my $n = abs($nin) % $din;
     my $w = int($nin / $din);
     if ($n == 0) {
       return ($w, 0, 1);
     }
     else {
       ($gcd, $n, $din)  = euclid($n, $din);
       return ($w, $n, $din);
     }
   }
}

sub as_string {
  my $f = shift;
  my ($gcd, $string);
  my $num = int($f->{n});
  my $den = int($f->{d});
  if ( abs($num % $den) == 0) {
    my $w = $num / $den;
    $string = "$w";
  }
  elsif ($num == 0) {
    $string = '0';
  }
  else {
    if ($den < 0) {
      $num *= -1;
      $den *= -1;
    }
    ($gcd, $num, $den) = euclid($num, $den);
    $string = "$num/$den";
  }
  return $string;
}

sub as_mixed_string {
  my $f = shift;
  my ($gcd, $string);
  my $num = int($f->{n});
  my $den = int($f->{d});
  if ($den < 0) {
    $den *= -1;
    $num *= -1;
  }
  if (abs($num) < abs($den)) {
    if ( $num == 0 ) {
      $string = '0';
     }
     else {
       ($gcd, $num, $den) = euclid($num, $den);
       $string = "$num/$den";
     }
   }
   else {
     my $n = abs($num) % $den;
     my $w = int($num / $den);
     if ($n == 0) {
       $string = "$w";
     }
     else {
       ($gcd, $num, $den) = euclid($num, $den);
       $string = "$w $n/$den";
     }
   }
  return $string;
}

  
sub radd {
  my ($f1, $f2) = @_;
  my $f = Math::Cephes::Fraction->new();
  Math::Cephes::radd($f1, $f2, $f);
  return $f;
}

sub rsub {
  my ($f1, $f2) = @_;
  my $f = Math::Cephes::Fraction->new();
  Math::Cephes::rsub($f2, $f1, $f);
  return $f;
}

sub rmul {
  my ($f1, $f2) = @_;
  my $f = Math::Cephes::Fraction->new();
  Math::Cephes::rmul($f1, $f2, $f);
  return $f;
}

sub rdiv {
  my ($f1, $f2) = @_;
  my $f = Math::Cephes::Fraction->new();
  Math::Cephes::rdiv($f2, $f1, $f);
  return $f;
}

1;

__END__

=head1 NAME

  Math::Cephes::Fraction - Perl interface to the cephes math fraction routines

=head1 SYNOPSIS

  use Math::Cephes::Fraction qw(fract);
  my $f1 = fract(2,3);          # $f1 = 2/3
  my $f2 = fract(3,4);          # $f2 = 3/4
  my $f3 = $f1->radd($f2);      # $f3 = $f1 + $f2

=head1 DESCRIPTION

 This module is a layer on top of the basic routines in the
 cephes math library to handle fractions. A fraction object
 is created via any of the following syntaxes:

  my $f = Math::Cephes::Fraction->new(3, 2);  # $f = 3/2
  my $g = new Math::Cephes::Fraction(5, 3);   # $g = 5/3
  my $h = fract(7, 5);                        # $h = 7/5

 the last one being available by importing I<:fract>. If no arguments
 are specified, as in

 my $h = fract();

 then the defaults $z = 0/1 are assumed. The numerator and 
 denominator of a fraction are represented respectively by

   $f->{n}; $f->{d}

 and can be set according to

  $f->{n} = 4; $f->{d} = 9;

 The fraction can be printed out as

  print $f->as_string;

 or as a mixed fraction as

  print $f->as_mixed_string;

 These routines reduce the fraction to its basic form before printing. 
 This uses the I<euclid> routine which finds the greatest common
 divisor of two numbers, as follows:

 ($gcd, $m_reduced, $n_reduced) = euclid($m, $n); 

 which returns the greatest common divisor of $m and $n, as well as
 the result of reducing $m and $n by $gcd

 A summary of the basic routines is as follows.

 $x = fract(3, 4);	 #  x = 3 / 4
 $y = fract(2, 3);       #  y = 2 / 3
 $z = $x->radd( $y );    #  z = x + y
 $z = $x->rsub( $y );    #  z = x - y 
 $z = $x->rmul( $y );    #  z = x * y
 $z = $x->rdiv( $y );    #  z = x / y
 print $z->{n}, ' ', $z->{d};  # prints numerator and denominator of $z
 print $z->as_string;         # prints the fraction $z
 print $z->as_mixed_string;   # converts $z to a mixed fraction, then prints it
 
 $m = 60;
 $n = 144;
 ($gcd, $m_reduced, $n_reduced) = euclid($m, $n); 

=head1 TODO

=over 4

=item * Integrate the C routines with the C<Math::Fraction> module.

=back

=head1 BUGS

 Please report any to Randy Kobes <randy@theoryx5.uwinnipeg.ca>


=head1 SEE ALSO

For the basic interface to the cephes fraction routines, see
L<Math::Cephes>. See also L<Math::Fraction>
for a more extensive interface to fraction routines.

=head1 COPYRIGHT

The C code for the Cephes Math Library is
Copyright 1984, 1987, 1989 by Stephen L. Moshier, 
and is available at http://www.netlib.org/cephes/.
Direct inquiries to 30 Frost Street, Cambridge, MA 02140.

The perl interface is copyright 2000 by Randy Kobes.
This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
