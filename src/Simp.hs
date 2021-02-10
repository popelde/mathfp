module Simp where

import Term

--
-- Rules for simplification
--

simplify (Neg (Neg s))  = s
simplify ((Const c) :- (Const a)) = Const (c - a)
simplify (Const c) = Const c 
simplify (Var y) = Var y

simplify (s :+ t) = (simplify s) :+ (simplify t)
simplify (s :- t) = (simplify s) :- (simplify t)
simplify (s :* t) = (simplify s) :* (simplify t)
simplify (s :/ t) = (simplify s) :/ (simplify t)
simplify (s :^ t) 
  | t == zero = one
  | t == one  = s
  | otherwise = (simplify s) :^ (simplify t)
-- ...


simp t = (until (\x -> x == simplify x) simplify t)


