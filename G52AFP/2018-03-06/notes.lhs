Generic function
  
Generalising map

(Regular map definition)
map :: (a -> a) -> [a] -> [b]
map f [] = []
map f (x:xs) = f x : map f xs

(Monadic map function)
mapM :: Monad m => (a -> m b) -> [a] -> m [b]
mapM f [] = return([]) -- Converts to monad when returning
mapM f (x:xs) = do
  y <- f x
  ys <- mapM f xs
  return (y:ys)
