# This file was automatically generated by SWIG
package Math::Cephes;
use strict;
use vars qw($VERSION @EXPORT_OK %EXPORT_TAGS @ISA);

require Exporter;
*import = \&Exporter::import;
require DynaLoader;
@ISA = qw( DynaLoader);
package Math::Cephesc;
bootstrap Math::Cephes;
package Math::Cephes;

my @constants = qw($PI $PIO2 $PIO4 $SQRT2 $MACHEP $MAXLOG $MINLOG $MAXNUM
		   $SQ2OPI $LOGE2 $LOGSQ2 $THPIO4 $TWOOPI $SQRTH $LOG2E );
my @trigs = qw(asin acos atan atan2 sin cos tan cot hypot
	       tandg cotdg sindg cosdg radian cosm1);
my @hypers = qw(acosh asinh atanh sinh cosh tanh);
my @explog = qw(log1p expm1 exp exp10 exp2 log log10 log2 expxx);
my @cmplx = qw(clog cexp csin ccos ctan ccot casin 
	       cacos catan cadd csub cmul cdiv cmov cneg cabs csqrt
	       csinh ccosh ctanh cpow casinh cacosh catanh);
my @utils = qw(ceil floor frexp ldexp fabs
	       round sqrt lrand pow powi drand lsqrt fac cbrt);
my @bessels = qw(i0 i0e i1 i1e iv j0 j1 jn jv k0 k1 kn yn yv k0e k1e y0 y1);
my @dists = qw(bdtr bdtrc bdtri btdtr chdtr chdtrc chdtri 
	       fdtr fdtrc fdtri gdtr gdtrc nbdtr nbdtrc nbdtri 
	       ndtr ndtri pdtr pdtrc pdtri stdtr stdtri);
my @gammas = qw(gamma igam igamc igami psi fac rgamma lgam);
my @betas = qw(beta lbeta incbet incbi lbeta);
my @elliptics = qw(ellie ellik ellpe ellpj ellpk);
my @hypergeometrics = qw(onef2 threef0 hyp2f1 hyperg hyp2f0);
my @misc = qw(zeta zetac airy dawsn fresnl sici shichi expn spence ei 
              erfc erf struve plancki simpson bernum polylog vecang);
my @fract = qw(radd rsub rmul rdiv euclid);

%EXPORT_TAGS = ('constants' => [@constants],
		'utils' => [@utils],
                'trigs' => [@trigs],
                'hypers' => [@hypers],
                'explog' => [@explog],
                'cmplx' => [@cmplx],
                'bessels' => [@bessels],
                'gammas' => [@gammas],
		'dists' => [@dists],
                'betas' => [@betas],
                'elliptics' => [@elliptics],
		'hypergeometrics' => [@hypergeometrics],
		'fract' => [@fract],
                'misc' => [@misc],
                'all' => [@constants, @utils, @trigs, @hypers, 
			  @explog, @bessels, @gammas, @betas, @elliptics, 
			  @hypergeometrics, @misc, @dists],
	       );
  
@EXPORT_OK = (@constants, @utils, @trigs, @hypers, 
	      @explog, @bessels, @gammas, @betas, @elliptics, 
	      @hypergeometrics, @misc, @dists, @fract, @cmplx);
		
$VERSION = '0.52';
#Math::Cephes->bootstrap($VERSION);
#var_Math__Cephes_init();

sub simpson {
  my ($r, $a, $b, $abs, $rel, $nmax) = @_;
  die "Must supply a CODE reference" unless ref($r) eq 'CODE';
  die "Must supply start and end points($a and $b)" 
    unless (defined $a and defined $b);
  $abs ||= 1e-06;
  $rel ||= 1e-06;
  $nmax ||= 256;
  $nmax = 2 if $nmax < 2;
  my $sumold = 0;
  for (my $n=2; $n<=$nmax; $n++) {
    my $count = 0;
    my $x = $a;
    my $sum = 0;
    my $h = ($b - $a) / $n / 8;
    my $f = [];
    for($count=0; $count <= 8*$n; $count++, $x+=$h) {
      $f->[$count] = &$r($x);
    }
    $sum = Math::Cephes::simpsn_wrap($f, $count-1, $h);
    my $test = abs($sum - $sumold);
    return $sum if ($test < $abs or abs($test/$sum) < $rel);
    $sumold = $sum;
  }
  warn("Math::Cephes::simpson: Maximum number $nmax of iterations reached");
  return undef;
}

sub bernum {
  my $i = shift;
  die "Cannot exceed i=30" if (defined $i and $i > 30);
  my $num = [split //, 0 x 30 ];
  my $den = [split //, 0 x 30 ];
  Math::Cephes::bernum_wrap($num, $den);
  return defined $i ? (int($num->[$i]), int($den->[$i])) : ($num, $den);
}

sub expxx {
  my $x = shift;
  my $n = shift || 1;
  return Math::Cephes::expx2($x, $n);
}

sub vecang {
  my ($a, $b) = @_;
  die "Must supply array references" 
    unless (ref($a) eq 'ARRAY' and ref($b) eq 'ARRAY');
  die "Vectors must be of dimension 3"
    unless (scalar @$a == 3 and scalar @$b == 3);
  return Math::Cephes::arcdot($a, $b);
}

# ---------- BASE METHODS -------------

package Math::Cephes;

sub TIEHASH {
    my ($classname,$obj) = @_;
    return bless $obj, $classname;
}

sub CLEAR { }

sub FIRSTKEY { }

sub NEXTKEY { }

sub FETCH {
    my ($self,$field) = @_;
    my $member_func = "swig_${field}_get";
    $self->$member_func();
}

sub STORE {
    my ($self,$field,$newval) = @_;
    my $member_func = "swig_${field}_set";
    $self->$member_func($newval);
}

sub this {
    my $ptr = shift;
    return tied(%$ptr);
}


# ------- FUNCTION WRAPPERS --------

package Math::Cephes;

*acosh = *Math::Cephesc::md_acosh;
*airy = *Math::Cephesc::airy;
*asin = *Math::Cephesc::md_asin;
*acos = *Math::Cephesc::md_acos;
*asinh = *Math::Cephesc::md_asinh;
*atan = *Math::Cephesc::md_atan;
*atan2 = *Math::Cephesc::md_atan2;
*atanh = *Math::Cephesc::md_atanh;
*bdtrc = *Math::Cephesc::bdtrc;
*bdtr = *Math::Cephesc::bdtr;
*bdtri = *Math::Cephesc::bdtri;
*beta = *Math::Cephesc::beta;
*lbeta = *Math::Cephesc::lbeta;
*btdtr = *Math::Cephesc::btdtr;
*cbrt = *Math::Cephesc::md_cbrt;
*chbevl = *Math::Cephesc::chbevl;
*chdtrc = *Math::Cephesc::chdtrc;
*chdtr = *Math::Cephesc::chdtr;
*chdtri = *Math::Cephesc::chdtri;
*clog = *Math::Cephesc::md_clog;
*cexp = *Math::Cephesc::md_cexp;
*csin = *Math::Cephesc::md_csin;
*ccos = *Math::Cephesc::md_ccos;
*ctan = *Math::Cephesc::md_ctan;
*ccot = *Math::Cephesc::ccot;
*casin = *Math::Cephesc::md_casin;
*cacos = *Math::Cephesc::md_cacos;
*catan = *Math::Cephesc::md_catan;
*csinh = *Math::Cephesc::md_csinh;
*casinh = *Math::Cephesc::md_casinh;
*ccosh = *Math::Cephesc::md_ccosh;
*cacosh = *Math::Cephesc::md_cacosh;
*ctanh = *Math::Cephesc::md_ctanh;
*catanh = *Math::Cephesc::md_catanh;
*cpow = *Math::Cephesc::md_cpow;
*radd = *Math::Cephesc::radd;
*rsub = *Math::Cephesc::rsub;
*rmul = *Math::Cephesc::rmul;
*rdiv = *Math::Cephesc::rdiv;
*euclid = *Math::Cephesc::euclid;
*cadd = *Math::Cephesc::cadd;
*csub = *Math::Cephesc::csub;
*cmul = *Math::Cephesc::cmul;
*cdiv = *Math::Cephesc::cdiv;
*cmov = *Math::Cephesc::cmov;
*cneg = *Math::Cephesc::cneg;
*cabs = *Math::Cephesc::md_cabs;
*csqrt = *Math::Cephesc::md_csqrt;
*hypot = *Math::Cephesc::md_hypot;
*cosh = *Math::Cephesc::md_cosh;
*dawsn = *Math::Cephesc::dawsn;
*ellie = *Math::Cephesc::ellie;
*ellik = *Math::Cephesc::ellik;
*ellpe = *Math::Cephesc::ellpe;
*ellpj = *Math::Cephesc::ellpj;
*ellpk = *Math::Cephesc::ellpk;
*exp = *Math::Cephesc::md_exp;
*exp10 = *Math::Cephesc::md_exp10;
*exp2 = *Math::Cephesc::md_exp2;
*expn = *Math::Cephesc::md_expn;
*ei = *Math::Cephesc::ei;
*fabs = *Math::Cephesc::md_fabs;
*fac = *Math::Cephesc::fac;
*fdtrc = *Math::Cephesc::fdtrc;
*fdtr = *Math::Cephesc::fdtr;
*fdtri = *Math::Cephesc::fdtri;
*ceil = *Math::Cephesc::md_ceil;
*floor = *Math::Cephesc::md_floor;
*frexp = *Math::Cephesc::md_frexp;
*ldexp = *Math::Cephesc::md_ldexp;
*fresnl = *Math::Cephesc::fresnl;
*gamma = *Math::Cephesc::md_gamma;
*lgam = *Math::Cephesc::lgam;
*gdtr = *Math::Cephesc::gdtr;
*gdtrc = *Math::Cephesc::gdtrc;
*hyp2f1 = *Math::Cephesc::hyp2f1;
*hyperg = *Math::Cephesc::hyperg;
*hyp2f0 = *Math::Cephesc::hyp2f0;
*i0 = *Math::Cephesc::i0;
*i0e = *Math::Cephesc::i0e;
*i1 = *Math::Cephesc::i1;
*i1e = *Math::Cephesc::i1e;
*igamc = *Math::Cephesc::igamc;
*igam = *Math::Cephesc::igam;
*igami = *Math::Cephesc::igami;
*incbet = *Math::Cephesc::incbet;
*incbi = *Math::Cephesc::incbi;
*iv = *Math::Cephesc::iv;
*j0 = *Math::Cephesc::md_j0;
*y0 = *Math::Cephesc::md_y0;
*j1 = *Math::Cephesc::md_j1;
*y1 = *Math::Cephesc::md_y1;
*jn = *Math::Cephesc::md_jn;
*jv = *Math::Cephesc::jv;
*k0 = *Math::Cephesc::k0;
*k0e = *Math::Cephesc::k0e;
*k1 = *Math::Cephesc::k1;
*k1e = *Math::Cephesc::k1e;
*kn = *Math::Cephesc::kn;
*log = *Math::Cephesc::md_log;
*log10 = *Math::Cephesc::md_log10;
*log2 = *Math::Cephesc::md_log2;
*lrand = *Math::Cephesc::lrand;
*lsqrt = *Math::Cephesc::lsqrt;
*mtherr = *Math::Cephesc::mtherr;
*polevl = *Math::Cephesc::polevl;
*p1evl = *Math::Cephesc::p1evl;
*nbdtrc = *Math::Cephesc::nbdtrc;
*nbdtr = *Math::Cephesc::nbdtr;
*nbdtri = *Math::Cephesc::nbdtri;
*ndtr = *Math::Cephesc::ndtr;
*erfc = *Math::Cephesc::md_erfc;
*erf = *Math::Cephesc::md_erf;
*ndtri = *Math::Cephesc::ndtri;
*pdtrc = *Math::Cephesc::pdtrc;
*pdtr = *Math::Cephesc::pdtr;
*pdtri = *Math::Cephesc::pdtri;
*pow = *Math::Cephesc::md_pow;
*powi = *Math::Cephesc::md_powi;
*psi = *Math::Cephesc::psi;
*rgamma = *Math::Cephesc::rgamma;
*round = *Math::Cephesc::md_round;
*shichi = *Math::Cephesc::shichi;
*sici = *Math::Cephesc::sici;
*sin = *Math::Cephesc::md_sin;
*cos = *Math::Cephesc::md_cos;
*radian = *Math::Cephesc::radian;
*sindg = *Math::Cephesc::md_sindg;
*cosdg = *Math::Cephesc::cosdg;
*sinh = *Math::Cephesc::md_sinh;
*spence = *Math::Cephesc::spence;
*sqrt = *Math::Cephesc::sqrt;
*stdtr = *Math::Cephesc::stdtr;
*stdtri = *Math::Cephesc::stdtri;
*onef2 = *Math::Cephesc::onef2;
*threef0 = *Math::Cephesc::threef0;
*struve = *Math::Cephesc::struve;
*tan = *Math::Cephesc::md_tan;
*cot = *Math::Cephesc::cot;
*tandg = *Math::Cephesc::tandg;
*cotdg = *Math::Cephesc::cotdg;
*tanh = *Math::Cephesc::md_tanh;
*log1p = *Math::Cephesc::md_log1p;
*expm1 = *Math::Cephesc::expm1;
*cosm1 = *Math::Cephesc::cosm1;
*yn = *Math::Cephesc::md_yn;
*yv = *Math::Cephesc::yv;
*zeta = *Math::Cephesc::zeta;
*zetac = *Math::Cephesc::zetac;
*drand = *Math::Cephesc::drand;
*plancki = *Math::Cephesc::plancki;
*polini = *Math::Cephesc::polini;
*polmul = *Math::Cephesc::polmul;
*poldiv = *Math::Cephesc::poldiv;
*poladd = *Math::Cephesc::poladd;
*polsub = *Math::Cephesc::polsub;
*polsbt = *Math::Cephesc::polsbt;
*poleva = *Math::Cephesc::poleva;
*polatn = *Math::Cephesc::polatn;
*polsqt = *Math::Cephesc::polsqt;
*polsin = *Math::Cephesc::polsin;
*polcos = *Math::Cephesc::polcos;
*polrt_wrap = *Math::Cephesc::polrt_wrap;
*cpmul_wrap = *Math::Cephesc::cpmul_wrap;
*fpolini = *Math::Cephesc::fpolini;
*fpolmul_wrap = *Math::Cephesc::fpolmul_wrap;
*fpoldiv_wrap = *Math::Cephesc::fpoldiv_wrap;
*fpoladd_wrap = *Math::Cephesc::fpoladd_wrap;
*fpolsub_wrap = *Math::Cephesc::fpolsub_wrap;
*fpolsbt_wrap = *Math::Cephesc::fpolsbt_wrap;
*fpoleva_wrap = *Math::Cephesc::fpoleva_wrap;
*bernum_wrap = *Math::Cephesc::bernum_wrap;
*simpsn_wrap = *Math::Cephesc::simpsn_wrap;
*minv = *Math::Cephesc::minv;
*mtransp = *Math::Cephesc::mtransp;
*eigens = *Math::Cephesc::eigens;
*simq = *Math::Cephesc::simq;
*polylog = *Math::Cephesc::polylog;
*arcdot = *Math::Cephesc::arcdot;
*expx2 = *Math::Cephesc::expx2;


# ------- VARIABLE STUBS --------

package Math::Cephes;

*MACHEP = *Math::Cephesc::MACHEP;
*MAXLOG = *Math::Cephesc::MAXLOG;
*MINLOG = *Math::Cephesc::MINLOG;
*MAXNUM = *Math::Cephesc::MAXNUM;
*PI = *Math::Cephesc::PI;
*PIO2 = *Math::Cephesc::PIO2;
*PIO4 = *Math::Cephesc::PIO4;
*SQRT2 = *Math::Cephesc::SQRT2;
*SQRTH = *Math::Cephesc::SQRTH;
*LOG2E = *Math::Cephesc::LOG2E;
*SQ2OPI = *Math::Cephesc::SQ2OPI;
*LOGE2 = *Math::Cephesc::LOGE2;
*LOGSQ2 = *Math::Cephesc::LOGSQ2;
*THPIO4 = *Math::Cephesc::THPIO4;
*TWOOPI = *Math::Cephesc::TWOOPI;

1;

__END__
