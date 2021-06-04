
mayorGasto emple1 emple2 | snd emple1 > snd emple2 = emple1
                         | otherwise = emple2


masGastador (empleado:empleados) = foldl mayorGasto empleado empleados

lista = [("ana",80),("pepe",40),("juan",300),("maria",120)]

gastoTotal listaEmp = foldl (\sem (_,gasto) -> sem + gasto) 0 listaEmp 

gastoTotal' listaEmp' = foldr (\(_,gasto) sem -> sem + gasto) 0 listaEmp'


listaFunciones = [(3+), (*2), (5+)]

calculo lista = foldl (\sem f -> f sem) 2 lista
calculo' lista = foldl (flip ($)) 2 lista