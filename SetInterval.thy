(*  Title:      HOL/SetInterval.thy
    ID:         $Id: SetInterval.thy,v 1.5 2001/09/27 20:28:16 wenzelm Exp $
    Author:     Tobias Nipkow
    Copyright   2000  TU Muenchen

lessThan, greaterThan, atLeast, atMost
*)

SetInterval = NatArith + 

constdefs
  lessThan    :: "('a::ord) => 'a set"	("(1{.._'(})")
  "{..u(} == {x. x<u}"

  atMost      :: "('a::ord) => 'a set"	("(1{.._})")
  "{..u} == {x. x<=u}"

  greaterThan :: "('a::ord) => 'a set"	("(1{')_..})")
  "{)l..} == {x. l<x}"

  atLeast     :: "('a::ord) => 'a set"	("(1{_..})")
  "{l..} == {x. l<=x}"

end
