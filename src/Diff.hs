--
-- Symbolic Differentiation
--

module Diff where


import Term
import Simp



--
-- Rules for differentiation
--

diff (Const c) x = zero
diff (Var y) x
  | x == y = one 
  | otherwise = Var y
diff ((Var y) :^ n) x
  | x == y = n :* ((Var y) :^ (n :- one))

diff (s :+ t) x = (diff s x) :+ (diff t x)
diff (s :- t) x = (diff s x) :- (diff t x)

diff (s :* t) x =  ((diff s x) :* t) :+ (s :* (diff t x))
diff (s :/ t) x = (((diff s x) :* t) :- (s :* (diff t x)) :/ (t :^ two))

{-
*Diff> simp $ diff (((Var "x") :^ (two)) :+ ((Var "x") :^ three)) "x"
2 * x + 3 * x^2
*Diff> 
-}