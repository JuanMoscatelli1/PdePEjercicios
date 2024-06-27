object camionDeVerduras{
    var velocidadMaxima = 80
    var kilometrajeActual = 700000
    const pesoCajonesVerdura = 50
    var cantidadCajonesVerdura = 10

    method calcularPeso(){
        return pesoCajonesVerdura * cantidadCajonesVerdura
    }

    method velocidadMaxPosible(){
        if (self.calcularPeso() >= 500){
        velocidadMaxima = velocidadMaxima - (self.calcularPeso().div(500))
    }
    }

    method velocidadMaxima(){
        return velocidadMaxima
    }

    method pasarPorRutatlantica()
    {
        kilometrajeActual += 400
        if(velocidadMaxima > 75)
        {
            velocidadMaxima = 75
        }
    }
}

object camionScanion5000{
    const capacidad = 5000
    var velocidadMaxima = 140
    var densidad = 1
    var peso = densidad * capacidad

    method calcularPeso(){return peso}

    method pasarPorRutatlantica()
    {

        if(velocidadMaxima > 75)
        {
            velocidadMaxima = 75
        }
    }
}

object camionCerealero{
    var velocidadMaxima = 60
    var nivelDeterioro = 0
    var velocidadActual = 50
    var cantidadCarga

    method deteriorar(){
        if(velocidadActual>45){
           nivelDeterioro = nivelDeterioro + velocidadActual -45
           velocidadMaxima = velocidadMaxima - nivelDeterioro
        }
        if(velocidadActual > velocidadMaxima){
            velocidadActual = velocidadMaxima
        }
    }

    method velocidadActual(){return velocidadActual}

    method velocidadMaxima(){return velocidadMaxima}

    method pasarPorRutatlantica()
    {

        if(velocidadMaxima > 75)
        {
            velocidadMaxima = 75
        }
    }
}

object puestoRutatlantica{
    const kilometro = 400
    method cobrar(unCamion){
        return 7000 + (unCamion.calcularPeso().div(1000)100)
    }


/ method velocidadMaxima(unCamion){
        if(unCamion.velocidadMaxima() > 75) {sefl.velocidadMaxima = 75}
    }*/


}