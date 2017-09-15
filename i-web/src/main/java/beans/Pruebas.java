package beans;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class Pruebas {

	/**
	 * Redondea un valor a n decimales
	 * 
	 * @param aValor
	 * @param aNumeroDecimales
	 * @return valor
	 */
	public BigDecimal getValorRedondeado(BigDecimal aValor,
			Integer aNumeroDecimales) {

		BigDecimal valor = new BigDecimal(0);
		try {

			valor = aValor.setScale(aNumeroDecimales, RoundingMode.HALF_UP);

		} catch (Exception e) {
			valor = new BigDecimal(0);
		}

		return valor;
	}

	public static void main(String[] args) throws Exception {

		Pruebas objeto = new Pruebas();

		System.out.println(objeto.getValorRedondeado(new BigDecimal(3.001), 2));
		System.out.println(objeto.getValorRedondeado(new BigDecimal(3.005), 2));
		System.out.println(objeto.getValorRedondeado(new BigDecimal(3.0049), 2));
		System.out.println(objeto.getValorRedondeado(new BigDecimal(3.1539), 2));
		System.out.println(objeto.getValorRedondeado(new BigDecimal(3.1416), 2));
		System.out.println(objeto.getValorRedondeado(new BigDecimal(2.95), 2));
		System.out.println(objeto.getValorRedondeado(new BigDecimal(2.945), 2));
		System.out.println(objeto.getValorRedondeado(new BigDecimal(2.94999), 2));

	}

}
