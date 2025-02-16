(*  Title:      HOL/List.thy
    ID:         $Id: List.thy,v 1.61 2002/02/14 10:50:52 nipkow Exp $
    Author:     Tobias Nipkow
    Copyright   1994 TU Muenchen

The datatype of finite lists.
*)

List = PreList +

datatype 'a list = Nil ("[]") | Cons 'a ('a list) (infixr "#" 65)

consts
  "@"         :: ['a list, 'a list] => 'a list            (infixr 65)
  filter      :: ['a => bool, 'a list] => 'a list
  concat      :: 'a list list => 'a list
  foldl       :: [['b,'a] => 'b, 'b, 'a list] => 'b
  foldr       :: [['a,'b] => 'b, 'a list, 'b] => 'b
  hd, last    :: 'a list => 'a
  set         :: 'a list => 'a set
  list_all    :: ('a => bool) => ('a list => bool)
  list_all2   :: ('a => 'b => bool) => 'a list => 'b list => bool
  map         :: ('a=>'b) => ('a list => 'b list)
  mem         :: ['a, 'a list] => bool                    (infixl 55)
  nth         :: ['a list, nat] => 'a			  (infixl "!" 100)
  list_update :: 'a list => nat => 'a => 'a list
  take, drop  :: [nat, 'a list] => 'a list
  takeWhile,
  dropWhile   :: ('a => bool) => 'a list => 'a list
  tl, butlast :: 'a list => 'a list
  rev         :: 'a list => 'a list
  zip	      :: "'a list => 'b list => ('a * 'b) list"
  upt         :: nat => nat => nat list                   ("(1[_../_'(])")
  remdups     :: "'a list => 'a list"
  null, "distinct" :: "'a list => bool"
  replicate   :: nat => 'a => 'a list

nonterminals
  lupdbinds  lupdbind

syntax
  (* list Enumeration *)
  "@list"     :: args => 'a list                          ("[(_)]")

  (* Special syntax for filter *)
  "@filter"   :: [pttrn, 'a list, bool] => 'a list        ("(1[_:_./ _])")

  (* list update *)
  "_lupdbind"      :: ['a, 'a] => lupdbind            ("(2_ :=/ _)")
  ""               :: lupdbind => lupdbinds           ("_")
  "_lupdbinds"     :: [lupdbind, lupdbinds] => lupdbinds ("_,/ _")
  "_LUpdate"       :: ['a, lupdbinds] => 'a           ("_/[(_)]" [900,0] 900)

  upto        :: nat => nat => nat list                   ("(1[_../_])")

translations
  "[x, xs]"     == "x#[xs]"
  "[x]"         == "x#[]"
  "[x:xs . P]"  == "filter (%x. P) xs"

  "_LUpdate xs (_lupdbinds b bs)"  == "_LUpdate (_LUpdate xs b) bs"
  "xs[i:=x]"                       == "list_update xs i x"

  "[i..j]" == "[i..(Suc j)(]"


syntax (xsymbols)
  "@filter"   :: [pttrn, 'a list, bool] => 'a list        ("(1[_\\<in>_ ./ _])")


consts
  lists        :: 'a set => 'a list set

  inductive "lists A"
  intrs
    Nil  "[]: lists A"
    Cons "[| a: A;  l: lists A |] ==> a#l : lists A"


(*Function "size" is overloaded for all datatypes.  Users may refer to the
  list version as "length".*)
syntax   length :: 'a list => nat
translations  "length"  =>  "size:: _ list => nat"

primrec
  "hd(x#xs) = x"
primrec
  "tl([])   = []"
  "tl(x#xs) = xs"
primrec
  "null([])   = True"
  "null(x#xs) = False"
primrec
  "last(x#xs) = (if xs=[] then x else last xs)"
primrec
  "butlast []    = []"
  "butlast(x#xs) = (if xs=[] then [] else x#butlast xs)"
primrec
  "x mem []     = False"
  "x mem (y#ys) = (if y=x then True else x mem ys)"
primrec
  "set [] = {}"
  "set (x#xs) = insert x (set xs)"
primrec
  list_all_Nil  "list_all P [] = True"
  list_all_Cons "list_all P (x#xs) = (P(x) & list_all P xs)"
primrec
  "map f []     = []"
  "map f (x#xs) = f(x)#map f xs"
primrec
  append_Nil  "[]    @ys = ys"
  append_Cons "(x#xs)@ys = x#(xs@ys)"
primrec
  "rev([])   = []"
  "rev(x#xs) = rev(xs) @ [x]"
primrec
  "filter P []     = []"
  "filter P (x#xs) = (if P x then x#filter P xs else filter P xs)"
primrec
  foldl_Nil  "foldl f a [] = a"
  foldl_Cons "foldl f a (x#xs) = foldl f (f a x) xs"
primrec
  "foldr f [] a     = a"
  "foldr f (x#xs) a = f x (foldr f xs a)"
primrec
  "concat([])   = []"
  "concat(x#xs) = x @ concat(xs)"
primrec
  drop_Nil  "drop n [] = []"
  drop_Cons "drop n (x#xs) = (case n of 0 => x#xs | Suc(m) => drop m xs)"
  (* Warning: simpset does not contain this definition but separate theorems 
     for n=0 / n=Suc k*)
primrec
  take_Nil  "take n [] = []"
  take_Cons "take n (x#xs) = (case n of 0 => [] | Suc(m) => x # take m xs)"
  (* Warning: simpset does not contain this definition but separate theorems 
     for n=0 / n=Suc k*)
primrec 
  nth_Cons  "(x#xs)!n = (case n of 0 => x | (Suc k) => xs!k)"
  (* Warning: simpset does not contain this definition but separate theorems 
     for n=0 / n=Suc k*)
primrec
 "    [][i:=v] = []"
 "(x#xs)[i:=v] = (case i of 0     => v # xs 
			  | Suc j => x # xs[j:=v])"
primrec
  "takeWhile P []     = []"
  "takeWhile P (x#xs) = (if P x then x#takeWhile P xs else [])"
primrec
  "dropWhile P []     = []"
  "dropWhile P (x#xs) = (if P x then dropWhile P xs else x#xs)"
primrec
  "zip xs []     = []"
  "zip xs (y#ys) = (case xs of [] => [] | z#zs => (z,y)#zip zs ys)"
  (* Warning: simpset does not contain this definition but separate theorems 
     for xs=[] / xs=z#zs *)
primrec
  upt_0   "[i..0(] = []"
  upt_Suc "[i..(Suc j)(] = (if i <= j then [i..j(] @ [j] else [])"
primrec
  "distinct []     = True"
  "distinct (x#xs) = (x ~: set xs & distinct xs)"
primrec
  "remdups [] = []"
  "remdups (x#xs) = (if x : set xs then remdups xs else x # remdups xs)"
primrec
  replicate_0   "replicate  0      x = []"
  replicate_Suc "replicate (Suc n) x = x # replicate n x"
defs
 list_all2_def
 "list_all2 P xs ys == length xs = length ys & (!(x,y):set(zip xs ys). P x y)"


(** Lexicographic orderings on lists **)

consts
 lexn :: "('a * 'a)set => nat => ('a list * 'a list)set"
primrec
"lexn r 0       = {}"
"lexn r (Suc n) = (prod_fun (%(x,xs). x#xs) (%(x,xs). x#xs) ` (r <*lex*> lexn r n)) Int
                  {(xs,ys). length xs = Suc n & length ys = Suc n}"

constdefs
  lex :: "('a * 'a)set => ('a list * 'a list)set"
    "lex r == UN n. lexn r n"

  lexico :: "('a * 'a)set => ('a list * 'a list)set"
    "lexico r == inv_image (less_than <*lex*> lex r) (%xs. (length xs, xs))"

  sublist :: "['a list, nat set] => 'a list"
    "sublist xs A == map fst (filter (%p. snd p : A) (zip xs [0..size xs(]))"

end

ML

local

(* translating size::list -> length *)

fun size_tr' _ (Type ("fun", (Type ("list", _) :: _))) [t] =
      Syntax.const "length" $ t
  | size_tr' _ _ _ = raise Match;

in

val typed_print_translation = [("size", size_tr')];

end;
