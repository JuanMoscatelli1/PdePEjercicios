
primerosN n = take n (iterate (+1) 1)
mayorSegun funcion num1 num2  = max (funcion num1) (funcion num2)