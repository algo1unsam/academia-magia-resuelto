object acme {

	method utilidad(cosa) {
		return cosa.volumen() / 2
	}

}

object fenix {

	method utilidad(cosa) {
		return if (cosa.esReliquia()) {
			3
		} else {
			0
		}
	}

}

object cuchuflito {

	method utilidad(cosa) {
		return 0
	}

}

class Cosa {

	const property marca
	const property volumen
	const property esMagico
	const property esReliquia

	method utilidad() {
		return volumen + self.plusMagico() + self.plusReliquia() + marca.utilidad(self)
	}

	method plusMagico() {
		return if (esMagico) {
			3
		} else {
			0
		}
	}

	method plusReliquia() {
		return if (esReliquia) {
			5
		} else {
			0
		}
	}

}

class Mueble {

	const property cosas = #{}

	method puedeGuardar(cosa)

	method contiene(cosa) {
		return cosas.contains(cosa)
	}

	method guardar(cosa) {
		cosas.add(cosa)
	}

	method utilidad() {
		return cosas.sum({ cosa => cosa.utilidad() }) / self.precio()
	}

	method precio()

	method menosUtil() {
		return cosas.min({ cosa => cosa.utilidad() })
	}

	method remover(cosa) {
		cosas.remove(cosa)
	}

}

class Baul inherits Mueble {

	var property capacidadMaxima

	method volumenUsado() {
		return cosas.sum({ cosa => cosa.volumen() })
	}

	override method puedeGuardar(cosa) {
		return cosa.volumen() + self.volumenUsado() < capacidadMaxima
	}

	override method precio() {
		return capacidadMaxima + 2
	}

	override method utilidad() {
		return super() + if(self.guardaSoloReliquias()){return 2} else {return 0}
	}

	method guardaSoloReliquias() {
		return cosas.all({ cosa => cosa.esReliquia() })
	}

}

class BaulMagico inherits Baul {

	override method precio() {
		return super() * 2
	}

	override method utilidad() {
		return super() + self.bonusPorElementosMagicos()
	}

	method bonusPorElementosMagicos() {
		return cosas.count({ cosa => cosa.esMagico() })
	}

}

class GabineteMagico inherits Mueble {

	var property precio

	override method puedeGuardar(cosa) {
		return cosa.esMagico()
	}

}

class ArmarioConvencional inherits Mueble {

	var property capacidadMaxima

	override method puedeGuardar(cosa) {
		return cosas.size() < capacidadMaxima
	}

	override method precio() {
		return 5 * capacidadMaxima
	}

}

class Academia {

	var property muebles = #{}

	method puedeGuardar(cosa) {
		return self.algunMueblePuedeGuardar(cosa) and not self.yaExisteEnAlgunMueble(cosa)
	}

	method algunMueblePuedeGuardar(cosa) {
		return muebles.any({ mueble => mueble.puedeGuardar(cosa) })
	}

	method yaExisteEnAlgunMueble(cosa) {
		return muebles.any({ mueble => mueble.contiene(cosa) })
	}

	method dondeEsta(cosa) {
		return muebles.find({ mueble => mueble.contiene(cosa) })
	}

	method dondePuedeGuardar(cosa) {
		return muebles.filter({ mueble => mueble.puedeGuardar(cosa) })
	}

	method guardar(cosa) {
		self.validarSePuedeGuardar(cosa)
		self.dondePuedeGuardar(cosa).asList().first().guardar(cosa)
	}

	method validarSePuedeGuardar(cosa) {
		if (not self.puedeGuardar(cosa)) {
			self.error("No se puede guardar")
		}
	}

	method menosUtiles() {
		return muebles.map({ mueble => mueble.menosUtil() }).asSet()
	}

	method marcaMenosUtil() {
		return self.menosUtiles().min({ cosa => cosa.utilidad() }).marca()
	}

	method removerMenosUtilesNoMagicos() {
		self.validarHaySuficientesMuebles()
		self.menosUtilesNoMagicos().forEach({ cosaARemover =>
			const mueble = self.dondeEsta(cosaARemover)
			mueble.remover(cosaARemover)
		})
	}

	method validarHaySuficientesMuebles() {
		if (muebles.size() < 3) {
			self.error("Tiene que haber al menos tres muebles para poder remover")
		}
	}

	method menosUtilesNoMagicos() {
		return self.menosUtiles().filter({ cosa => not cosa.esMagico() })
	}

}

