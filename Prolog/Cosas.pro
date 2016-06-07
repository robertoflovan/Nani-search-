%%%%%%%%%%%%%%%%%%%%%%---------Cosas---------%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%	color
%%%%%%%%%	tama�o
%%%%%%%%%	peso
			%mis_objetos(caja3).
			%mis_objetos(llave).

%%%%%%%%-Objetos-%%%%%%%%%%%

:- dynamic
	locaci�n/2,
	contenedor/2.


	%cocina
	objeto(refrigerador, color(blanco), tama�o(grande), peso(100)).
	objeto(barrita, color(blanco), tama�o(grande), peso(100)).
	objeto(carne, color(roja), tama�o(peque�o), peso(1)).
	objeto(uvas, color(morada), tama�o(peque�o), peso(1)).
	objeto(chocolate, color(cafe), tama�o(grande), peso(100)).
	objeto(estufa, color(negra), tama�o(peque�o), peso(1)).
	objeto(manzana, color(roja), tama�o(peque�o), peso(1)).
	objeto(pera, color(verde), tama�o(peque�o), peso(1)).
	objeto(madera, color(cafe), tama�o(peque�o), peso(1)).
	objeto(bolsa, color(verde), tama�o(mediano), peso(100)).
	
	%comedor
	objeto(mesa, color(cafe), tama�o(grande), peso(100)).
	objeto(plato, color(blanco), tama�o(peque�o), peso(1)).
	objeto(cofre_de_nani, color(negro), tama�o(mediano), peso(100)).
	objeto(caja_amarilla, color(oro), tama�o(peque�o), peso(30)).
	objeto(caja_roja, color(oro), tama�o(peque�o), peso(30)).
	objeto(caja_azul, color(oro), tama�o(peque�o), peso(30)).
	objeto(nani, color(blanco), tama�o(peque�o), peso(1)).
	
	
		
	
	objeto(llave_cofre, color(amarillo), tama�o(peque�o), peso(1)).
	
	
	%pasillo

	
	%sala1
	objeto(estambre, color(azul), tama�o(peque�o), peso(1)).
	objeto(caja, color(cafe), tama�o(peque�o), peso(50)).


%%%%%%%%%%%- Apilador -%%%%%%%%%%%
	apilador(barrita).
	apilador(estufa).
	apilador(mesa).
	

%%%%%%%%-Contenedores-%%%%%%%%%%%
	contenedor(refrigerador,5).
	contenedor(bolsa,3).
	contenedor(cofre_de_nani,3).
	contenedor(caja_amarilla,1).
	contenedor(caja_roja,1).
	contenedor(caja_azul,1).
	
	
	
	
	contenedor(caja,3).

		
%%%%%%%%- Agarrable -%%%%%%%%%%%
		agarrable(bolsa).

%%%%%%%%-Comida-%%%%%%%%%%%
	%comida(cebolla, sabor(feo), estado(podrido)).
	comida(carne, sabor(feo), estado(crudo)).
	comida(uvas, sabor(normal), estado(normal)).
	comida(chocolate, sabor(rico), estado(normal)).
	comida(manzana, sabor(normal), estado(normal)).
	comida(pera, sabor(normal), estado(normal)).

%%%%%%%%-Locaciones-%%%%%%%%%%%
	
	%cocina
	locaci�n(refrigerador,cocina).
	locaci�n(barrita,cocina).
	locaci�n(carne,refrigerador).
	locaci�n(uvas,refrigerador).
	locaci�n(chocolate,refrigerador).
	locaci�n(estufa,cocina).
	locaci�n(manzana,barrita).
	locaci�n(pera,barrita).
	locaci�n(madera,cocina).
	locaci�n(bolsa,cocina).

	%comedor
	locaci�n(mesa,comedor).
	locaci�n(plato,mesa).
	locaci�n(cofre_de_nani,comedor).
	locaci�n(caja_amarilla,cofre_de_nani).
	locaci�n(caja_roja,cofre_de_nani).
	locaci�n(caja_azul,cofre_de_nani).
	locaci�n(nani,caja_amarilla).
	
	



	%pasillo1
	%locaci�n(caja1,pasillo1).

	

	%sala1
	locaci�n(caja,sala1).
	locaci�n(estambre,caja).


	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				
				
