Class definition for a monad.

class Applicative m => Monad m where
  return :: a -> m a
  (>>=) :: ma -> (a -> m b) -> mb