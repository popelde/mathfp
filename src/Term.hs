module Term where

--
-- A term defined as usual, over:
--   a: a type representing numbers
--   b: a type representing names (of variables, functions etc.)
--


infixl 6 :+
infixl 6 :-
infixl 7 :*
infixl 7 :/
infixl 8 :^

data Term a b = Const a
            | Var b
            | Neg (Term a b)
            | (Term a b) :+ (Term a b)
            | (Term a b) :- (Term a b)
            | (Term a b) :* (Term a b)
            | (Term a b) :/ (Term a b)
            | (Term a b) :^ (Term a b) deriving (Eq)


--
-- Print Term's prettily
--

instance (Show a, Show b) => Show (Term a b) where
  showsPrec p e0 =
    case e0 of
     Const n -> showParen (p > 10) $ showsPrec p n
     Var   x -> showParen (p > 10) $ showsPrec p x
     Neg   x -> showParen (p > 10) $ showString "-" . showsPrec p x
     x :+ y  -> showParen (p >  6) $ showsPrec 6 x . showString " + " . showsPrec 7 y
     x :- y  -> showParen (p >  6) $ showsPrec 6 x . showString " - " . showsPrec 7 y
     x :* y  -> showParen (p >  7) $ showsPrec 7 x . showString " * " . showsPrec 8 y
     x :/ y  -> showParen (p >  7) $ showsPrec 7 x . showString " / " . showsPrec 8 y
     x :^ y  -> showParen (p >  8) $ showsPrec 8 x . showString  "^"  . showsPrec 9 y


--
-- Does the variable x occur in a term (freely)?
--

--freeFrom :: Eq b => b -> Term a b -> Bool
freeFrom x (Const c) = True
freeFrom x (Var  y)  = x /= y
freeFrom x (Neg  t)  = freeFrom x t
freeFrom x (s :+ t)  = freeFrom x s && freeFrom x t
freeFrom x (s :- t)  = freeFrom x s && freeFrom x t
freeFrom x (s :* t)  = freeFrom x s && freeFrom x t
freeFrom x (s :/ t)  = freeFrom x s && freeFrom x t
freeFrom x (s :^ t)  = freeFrom x s && freeFrom x t

--
-- Some numbers (Haskell peculiarity for arbitrary numerical type)
--

zero :: Num a => Term a b
zero =  Const 0

one  :: Num a => Term a b
one  =  Const 1

two  :: Num a => Term a b
two  =  Const 2

three  :: Num a => Term a b
three  =  Const 3
