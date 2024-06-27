import Text.Show.Functions ()
import Data.List()

type Recurso = String

data Pais = Pais {
    ingreso :: Int,
    poblacionPublica :: Int,
    poblacionPrivada :: Int,
    riqueza :: [Recurso],
    deuda:: Int
}deriving (Show)

namibia = Pais {
    ingreso = 4140,
    poblacionPublica = 400000,
    poblacionPrivada = 650000,
    riqueza = ["mineria","ecoturismo"],
    deuda = 50000000
}

arabiaSaudita = Pais {
    ingreso = 2000,
    poblacionPublica = 100000,
    poblacionPrivada = 50000,
    riqueza = ["petroleo"],
    deuda = 75000000
}

--punto 2

--a

receta1 n pais = pais { deuda = deuda pais + div (3000000*n) 2}

--b

reducirPublicos reduccion pais = pais { poblacionPublica = poblacionPublica pais - reduccion}

reducirIngreso porcentaje pais = pais { ingreso = ingreso pais - div (ingreso pais * porcentaje) 100 }

reducirIngresoGuardas reduccion pais
 | reduccion > 100 = reducirIngreso 20 pais
 | otherwise = reducirIngreso 15 pais

receta2 reduccion  = (reducirPublicos reduccion).(reducirIngresoGuardas reduccion)

--c 

disminuirDeuda n pais = pais {deuda = deuda pais - n*1000000}

deletearRecurso recurso pais = pais { riqueza = filter (/=recurso) (riqueza pais)} 

receta3 recurso = (disminuirDeuda 2).(deletearRecurso recurso)

--d

receta1SinMillones n pais = pais { deuda = deuda pais + div (3*n) 2}

calcularMitadPBI pais = div ( ingreso pais * (poblacionPrivada pais + poblacionPublica pais)) 2

blindaje pais = ((reducirPublicos 500).(receta1SinMillones (calcularMitadPBI pais))) pais

--punto 3

recetaDoble = (receta1 200).(receta3 "mineria")

--el efecto colateral se logra al aplicar las 2 funciones y ver que algunos campos del pais cambiaron

--punto 4
--a
puedenZafar paises = filter ((any (=="petroleo")).riqueza) paises

--b 

totalDeuda paises = (sum.map deuda) paises

--punto 5

aplicarReceta receta pais = receta pais 

estaOrdenada pais [receta] = True
estaOrdenado pais (recetaA:recetaB:recetas)
 = (calcularMitadPBI (aplicarReceta recetaA pais))*2 <= (calcularMitadPBI (aplicarReceta recetaB pais))*2 && estaOrdenado pais (recetaB:recetas)