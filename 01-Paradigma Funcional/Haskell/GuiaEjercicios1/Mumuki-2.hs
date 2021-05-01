{- 
Definí una función comienzaConA que, al aplicarla con un string, me diga si el mismo comienza con la letra 'a'. Por ejemplo:

 comienzaConA "aguja"
    True
 comienzaConA "bote"
    False 
-}

comienzaConA :: String -> Bool
comienzaConA string = head string ==  "a"