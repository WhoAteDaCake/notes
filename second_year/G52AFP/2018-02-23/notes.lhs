-- > class Functor f where
-- > fmap :: (a -> b) -> f a -> f b

fmap (+1) (Just 1)
  Just 2
fmap (+1) Nothing
  Nothing

-- > class Functor f => Applicative f where
-- >  pure :: a -> f a

-->  ((*)) :: f (a -> b) -> fa -> fb 

Example:

> data Expr = Val Int | Div Expr Expr

-- > eval :: Expr -> Int
-- > eval (Val n) = n
-- > even (Div x y) = eval x `div` eval y

Will crash when division by 0, so

> safediv :: Int -> Int -> Maybe Int
> safediv _ 0 = Nothing
> safediv a b = Just (a `mod` b)

-- > eval :: Expr -> Maybe Int
-- > eval (Val n) = Just n
-- > eval (Div x y) =
-- >   case eval x of
-- >     Nothing -> Nothing 
-- >     Just n ->
-- >       case eval y of
-- >         Nothing -> Nothing 
-- >         Just m -> safediv n m 

Make nicer with Applicative functions

-- > eval (Val n) = pure n
-- > eval (Div x y) = pure safediv (*) eval x (*) eval y

Using monads

> eval (Val n) = Just n
> eval (Div x y) = eval x >>= (\n -> eval y >>= (\m -> safediv n m))

General case
m1 >>= \x1 ->
m2 >>= \x2 ->
mn >>= \xm ->
f x1 x2 .. xm

Can also: 
  do
    x1 <- m1
    x2 <- m2
    xn <- mn
    f x1 x2 .. xm

> eval2 (Val n) = Just n
> eval2 (Div x y) = do
>   n <- eval x
>   m <- eval y
>   safediv n m
