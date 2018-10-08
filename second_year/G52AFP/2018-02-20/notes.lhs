Example Maybe

Applicative style for Maybe supports a form of exectional programming
where we can apply a function to arguments that may fail or succeed

Instance Applicative maybe where

> -- pure :: a -> Maybe a
> pure x = Just x

> -- (<x>) :: Maybe (a -> b) -> Maybe a -> Maybe b
Nothing <x> mx = Nothing
(Just g) <x> mx = fmap g mx

Examples:

pure (+1) <x> Just 1
  Just 2
pure (+) <x> Just 1 <x> Just 2
  Just 3

pure (+) <x> Nothing (x) Just 2
  Nothing

Instance Applicative [] where
-- pure :: a -> [a]
pure x = [x]
