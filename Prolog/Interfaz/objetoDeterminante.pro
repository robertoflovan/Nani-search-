

	%Ej: determinante(Genero,Numero,S1-S2),
	
	determinante(masculino,singular,[el|X]- X).
	determinante(femenino,singular,[la|X]- X).
	determinante(masculino,plural,[los|X]- X).
	determinante(femenino,plural,[las|X]- X).
	
	%Ej: sustantivo(Tipo,Genero,Numero,Cosa,S2-S3).
		
		%Sustantivos (lugares –habitaciones-):
		%	Piso 1
		sustantivo(estandar, femenino, singular, cochera, [cochera|X]-X).
		sustantivo(estandar, masculino, singular, cochera, [porche|X]-X).
		sustantivo(estandar, femenino, singular, sala1, [sala1|X]-X).
		sustantivo(estandar, masculino, singular, comedor, [comedor|X]-X).
		sustantivo(estandar, femenino, singular, cocina, [cocina|X]-X).
		sustantivo(estandar, masculino, singular, baño1, [baño1|X]-X).
		sustantivo(estandar, femenino, plural, escaleras, [escaleras|X]-X).
		sustantivo(estandar, masculino, singular, pasillo1, [pasillo1|X]-X).
		sustantivo(estandar, masculino, singular, patio1, [patio1|X]-X).
		
		%	Piso 1
		sustantivo(estandar, femenino, singular, baño2, [cochera|X]-X).
		sustantivo(estandar, masculino, singular, cuarto1, [cuarto1|X]-X).
		sustantivo(estandar, masculino, singular, cuarto2, [cuarto2|X]-X).
		sustantivo(estandar, masculino, singular, cuarto3, [cuarto3|X]-X).
		sustantivo(estandar, femenino, singular, sala2, [sala2|X]-X).
		sustantivo(estandar, femenino, singular, lavandería, [lavandería|X]-X).
		sustantivo(estandar, femenino, singular, lavandería, [lavanderia|X]-X).
		sustantivo(estandar, masculino, singular, patio2, [patio2|X]-X).
		sustantivo(estandar, masculino, singular, pasillo2, [pasillo2|X]-X).

	%Sustantivos –cosas-, las cosas se distinguen por aparecer en un
	%predicado 'location' o 'have':
	%	Necesitaré declarar cada objeto en particular igual que las habitaciónes
	%		para poder diferenciar genero y cantidad de algún objeto
	%sustantivo(estandar, masculino, singular, caja1, [caja1|X]-X).
	sustantivo(estandar, masculino, singular, ob1, [ob1|X]-X).
	sustantivo(estandar, masculino, singular, ob1, [objeto1|X]-X).
	%sustantivo(estandar, femenino, singular, caja1, [caja1|X]-X).
	%sustantivo(estandar, femenino, singular, ob2, [ob2|X]-X).
	%sustantivo(estandar, femenino, singular, ob2, [objeto2|X]-X).
	
	%Cocina
	sustantivo(estandar, masculino, singular, refrigerador, [refrigerador|X]-X).
	sustantivo(estandar, femenino, singular, barrita, [barrita|X]-X).
	sustantivo(estandar, femenino, singular, carne, [carne|X]-X).
	sustantivo(estandar, femenino, plural, uvas, [uvas|X]-X).
	sustantivo(estandar, masculino, singular, chocolate, [chocolate|X]-X).
	sustantivo(estandar, femenino, singular, estufa, [estufa|X]-X).
	sustantivo(estandar, femenino, singular, manzana, [manzana|X]-X).
	sustantivo(estandar, femenino, singular, pera, [pera|X]-X).
	sustantivo(estandar, femenino, singular, madera, [madera|X]-X).
	sustantivo(estandar, femenino, singular, bolsa, [bolsa|X]-X).
	
	%Comedor
	sustantivo(estandar, femenino, singular, mesa, [mesa|X]-X).
	sustantivo(estandar, masculino, singular, plato, [plato|X]-X).
	sustantivo(estandar, masculino, singular, cofre_de_nani, [cofre,de,nani|X]-X).
	sustantivo(estandar, femenino, singular, caja_amarilla, [caja,amarilla|X]-X).
	sustantivo(estandar, femenino, singular, caja_roja, [caja,roja|X]-X).
	sustantivo(estandar, femenino, singular, caja_azul, [caja,azul|X]-X).
	sustantivo(estandar, femenino, singular, nani, [nani|X]-X).
	
	
	sustantivo(estandar, masculino, singular, estambre, [estambre|X]-X).
	sustantivo(estandar, masculino, singular, 400, [400|X]-X).
	sustantivo(estandar, femenino, singular, llave_cofre, [llave,cofre|X]-X).
	sustantivo(estandar, femenino, singular, llave_cofre, [llave,de,cofre|X]-X).
	sustantivo(estandar, femenino, singular, llave_cofre, [llave,del,cofre|X]-X).
	sustantivo(estandar, femenino, singular, caja, [caja|X]-X).
	
	
