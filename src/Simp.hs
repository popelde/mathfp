module Simp where

import Term

--
-- Rules for simplification
--


simplify  (Const c)               = Const c
simplify ((Const c) :+ (Const d)) = Const (c + d)
simplify ((Const c) :- (Const d)) = Const (c - d)
simplify ((Const c) :* (Const d)) = Const (c * d)
simplify ((Const c) :/ (Const d)) = Const (c / d)

simplify (Var y) = Var y

simplify (Neg (Const c)) = Const (-c)
simplify (Neg (Neg s))   = simplify s
simplify (Neg (s :- t))  = t :- s

simplify (s :+ Neg t) = simplify s :- simplify t
simplify (Neg s :+ t) = simplify t :- simplify s
simplify (s :+ t)     = simplify s :+ simplify t

simplify (s :- Neg t) = simplify s :+ simplify t
simplify (s :- t) = simplify s :- simplify t

simplify ((Neg s) :* (Neg t)) = simplify s :* simplify t
simplify (s :* t) = simplify s :* simplify t

simplify ((Neg s) :/ (Neg t)) = simplify s :/ simplify t
simplify (s :/ t) = simplify s :/ simplify t

simplify (s :^ t)
  | simp_t == zero = one
  | simp_t == one  = s
  | otherwise      = simplify s :^ simp_t
  where
    simp_t = simplify t
-- ...


simp :: (Eq a, Eq b, Fractional a) => Term a b -> Term a b
simp = until (\x -> x == simplify x) simplify

{-
*Simp> simplify  (Neg (Const 3)) :* (Neg (Const 2))
(-3.0) * -2.0
*Simp> simplify ((Neg (Const 5)) :+ (Neg (Const 3)) :* (Neg (Const 2)))
3.0 * 2.0 - 5.0
*Simp> simplify $ simplify ((Neg (Const 5)) :+ (Neg (Const 3)) :* (Neg (Const 2)))
6.0 - 5.0
*Simp> simp ((Neg (Const 5)) :+ (Neg (Const 3)) :* (Neg (Const 2)))
1.0
*Simp> 
-}