


all' :: (a->b) -> [a] -> Bool
all' _ [] = True
all' f (x:xs) = f x && all' f xs