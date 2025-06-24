class Criatura{
  var salud 
  method disminuirVida(cantidad){salud = (salud - cantidad).max(0)}
}
class CriaturaInmorible{
  var salud 
  method disminuirVida(cantidad){}
}
class Estudiante{
  var salu
  var habilidad
  var property casa
  const sangrePura 
  const hechizos=[]

  method restarHabilidad(cantidad){habilidad = (habilidad - 1).max(0) }
  method aumentarHabilidad(numero){habilidad = habilidad + numero}

  method aumentarSalud(cant){salud = salud + cant}
  method restarSalud(cantidad){salud = (salud - cantidad).max(0) }

  method esSangrePura()= sangrePura
  method esExperimentado()= habilidad >10 
  method cambiarDeCasa(unaCasa){casa = unaCasa}
  method habilidad()= habilidad
  method esPeligroso(estudiante)= casa.esPeligroso(estudiante) or !self.esSangrePura()
  method lanzarHechizoA(unHechizo,unaCriatura){ unHechizo.atacar(unaCriatura) unHechizo.consecuencia(self)}
  method tengoElHechizoAprendido(unHechizo)= hechizos.contains(unHechizo)
  method puedoLanzarHechizo(unHechizo)= self.tengoElHechizoAprendido(unHechizo) and unHechizo.puedeSerEjecutadoPor(self)
  method lanzarHechizoSiPuedeA(unHechizo,unaCriatura)=  if(!self.puedoLanzarHechizo(unHechizo)) self.error("no podes lanzar ese hechizo estudiante") else self.lanzarHechizoA(unHechizo,unaCriatura)
  method aprenderHechizo(unHechizo) {hechizos.add(unHechizo) self.aumentarHabilidad(1)}
  method inscribirseAMateria(unaMateria)= unaMateria.inscribirEstudiante(self)
  method darseDeBajaAMateria(unaMateria)= unaMateria.inscribirEstudiante(self)

}
object gryffindor {
    method esPeligroso(estudiante)= false
    
}
object slytherin {
    method esPeligroso(estudiante)= true
    
}
object ravenclaw {
    method esPeligroso(estudiante)= estudiante.esExperimentado() 
    
}
object hufflepuff {
    method esPeligroso(estudiante)= estudiante.esSangrePura() 
    
}
class Materia{
  var hechizoAenseniar
  const profesor 

  method cambiarHechizo(unHechizo){hechizoAenseniar = unHechizo}
  const estudiantes = []
  method inscribirEstudiante(unEstudiante)= estudiantes.add(unEstudiante)
  method darseDeBajaAMateria(unEstudiante)= estudiantes.remove(unEstudiante)

  method dictarMateria()= estudiantes.forEach({e=>e.aprenderHechizo(hechizoAenseniar)e.aumentarHabilidad(1)})
  method practica(unaCriatura)= estudiantes.forEach({e=>e.lanzarHechizoSiPuedeA(unaCriatura)})
}
class HechizoComun{
  const nivelDeDificultad
  method consecuencia(estudiante){}
  method puedeSerEjecutadoPor(estudiante) { return estudiante.habilidad() > nivelDeDificultad}
  method disminuirVidaA(unaCriatura){unaCriatura.disminuirVidaA(nivelDeDificultad + 10)}
  method atacar(unaCriatura){ self.disminuirVidaA(unaCriatura)}
}

class HechizoImperdonable inherits HechizoComun{
  const saludRestante

  override method consecuencia(estudiante)= estudiante.restarSalud(saludRestante)
  override method atacar(unaCriatura){super(unaCriatura) * 2}
}
class OtrosHechizos inherits HechizoComun{
  

  override method puedeSerEjecutadoPor(estudiante){ return !estudiante.esPeligroso()}
  override method consecuencia(estudiante)= estudiante.restarHabilidad(1)

}
class HechizoDePuraSangre inherits HechizoComun{
  

  override method puedeSerEjecutadoPor(estudiante){ return super(estudiante) and  estudiante.esPuraSangre()}
  override method consecuencia(estudiante)= estudiante.cambiarCasa()
  override method atacar(unaCriatura){super(unaCriatura) * 5}

}
