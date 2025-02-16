(*  Title:      HOL/ROOT.ML
    ID:         $Id: ROOT.ML,v 1.78 2001/10/22 09:54:23 paulson Exp $
    Author:     Tobias Nipkow
    Copyright   1993  University of Cambridge

Classical Higher-order Logic.
*)

val banner = "Higher-Order Logic";
writeln banner;

print_depth 1;

(*old-style theory syntax*)
use "thy_syntax.ML";

use "hologic.ML";

use "~~/src/Provers/simplifier.ML";
use "~~/src/Provers/splitter.ML";
use "~~/src/Provers/hypsubst.ML";
use "~~/src/Provers/induct_method.ML";
use "~~/src/Provers/make_elim.ML";
use "~~/src/Provers/classical.ML";
use "~~/src/Provers/blast.ML";
use "~~/src/Provers/clasimp.ML";
use "~~/src/Provers/Arith/fast_lin_arith.ML";
use "~~/src/Provers/Arith/cancel_sums.ML";
use "~~/src/Provers/Arith/abel_cancel.ML";
use "~~/src/Provers/Arith/assoc_fold.ML";
use "~~/src/Provers/quantifier1.ML";
use "~~/src/Provers/Arith/abstract_numerals.ML";
use "~~/src/Provers/Arith/cancel_numerals.ML";
use "~~/src/Provers/Arith/combine_numerals.ML";
use "~~/src/Provers/Arith/cancel_numeral_factor.ML";
use "~~/src/Provers/Arith/extract_common_term.ML";

with_path "Integ" use_thy "Main";

path_add "~~/src/HOL/Library";

print_depth 8;

Goal "True";  (*leave subgoal package empty*)
