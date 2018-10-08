A nicer syntax for sequencing functions that may fail

-- > (>>==) :: Maybe a -> (a -> Maybe b) -> Maybe b
-- > Nothing >>== f = Nothing
-- > (Just x) >>== f = f x

Monads (need to be applicative) (Look at functors)

-- > class Applicative m => Monad m where
-- >  (>>==) :: m a -> (a -> b) -> mb
-- >  return :: a -> ma
-- >  -- return = pure

Example Maybe 

-- > instance Monad Maybe where
-- > (>>==) :: Maybe a -> (a -> Maybe b) -> Maybe b
-- > Nothing >>== f = Nothing
-- > Just x >>== f = f x

List Monad

-- > instance Monad [] where
-- > (>>=) :: [a] -> (a -> [b]) -> [b]
-- > xs >>= f = concat . (map f xs) 
-- > xs >>= f = [y | x <- xs, y <- fx] -- The same as above one

Example pairs function

> --pairsI :: [a] -> [b] -> [(a,b)]
> pairsI xs ys = do
>   x <- xs
>   y <- ys
>   return (x, y)
> --pairsI [1,2] [3, 4]
> -- [(1,3), (1,4), (2,3), (2,4)]

Example: State (state transformer)

> type State = Int
> -- type ST = State -> State -- current state -> modified state
> -- type ST a = State -> (a, State)
> newtype ST a = S (State -> (a, State))
> app (S st) s = st s

Exercise make ST into functor/applicative

> instance Monad ST where
> -- return a -> St a
> -- return x = S (\s -> (x, s))
> -- bind St a -> (a -> St b) -> St b
> st >>= f = S(\s -> let (x, s') = app st s
>                     in app (f x) s')