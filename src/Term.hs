module Term where

--
-- A term defined as usual
--

data Term a = Const a
            | Var String
            | Neg (Term a)
            | (Term a) :+ (Term a)
            | (Term a) :- (Term a)
            | (Term a) :* (Term a)
            | (Term a) :/ (Term a)
            | (Term a) :^ (Term a) deriving (Eq)


--
-- Print Term's prettily
--

instance Show a => Show (Term a) where
  showsPrec p e0 =
    case e0 of
     Const n -> showParen (p > 10) $ showsPrec p n
     Var   x -> showParen (p > 10) $ showString x
     x :+ y -> showParen (p > 6) $ showsPrec 6 x . showString " + " . showsPrec 7 y
     x :- y -> showParen (p > 6) $ showsPrec 6 x . showString " - " . showsPrec 7 y
     x :* y -> showParen (p > 7) $ showsPrec 7 x . showString " * " . showsPrec 8 y
     x :/ y -> showParen (p > 7) $ showsPrec 7 x . showString " / " . showsPrec 8 y
     x :^ y -> showParen (p > 8) $ showsPrec 8 x . showString "^" . showsPrec 9 y


--
-- Does the variable x occur in a term (freely)?
--

freeFrom :: String -> Term a -> Bool
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

zero :: Num a => Term a
zero =  Const (fromInteger 0)

one  :: Num a => Term a
one  =  Const (fromInteger 1)

two  :: Num a => Term a
two  =  Const (fromInteger 2)

three  :: Num a => Term a
three  =  Const (fromInteger 3)
