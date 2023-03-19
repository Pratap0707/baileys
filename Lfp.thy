(*  Title:      HOL/Lfp.thy
    ID:         $Id: Lfp.thy,v 1.10 2001/09/27 20:28:16 wenzelm Exp $
    Author:     Lawrence C Paulson, Cambridge University Computer Laboratory
    Copyright   1992  University of Cambridge

The Knaster-Tarski Theorem
*)

Lfp = Product_Type +

constdefs
  lfp :: ['a set=>'a set] => 'a set
  "lfp(f) == Inter({u. f(u) <= u})"    (*least fixed point*)

end
