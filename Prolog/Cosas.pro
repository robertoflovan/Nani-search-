%%%%%%%%%%%%%%%%%%%%%%---------Cosas---------%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%	color
%%%%%%%%%	tamaño
%%%%%%%%%	peso
			%mis_objetos(caja3).
			%mis_objetos(llave).

%%%%%%%%-Objetos-%%%%%%%%%%%

:- dynamic
	locación/2,
	contenedor/2.


	%cocina
	objeto(refrigerador, color(blanco), tamaño(grande), peso(100)).
	objeto(barrita, color(blanco), tamaño(grande), peso(100)).
	objeto(carne, color(roja), tamaño(pequeño), peso(1)).
	objeto(uvas, color(morada), tamaño(pequeño), peso(1)).
	objeto(chocolate, color(cafe), tamaño(grande), peso(100)).
	objeto(estufa, color(negra), tamaño(pequeño), peso(1)).
	objeto(manzana, color(roja), tamaño(pequeño), peso(1)).
	objeto(pera, color(verde), tamaño(pequeño), peso(1)).
	objeto(madera, color(cafe), tamaño(pequeño), peso(1)).
	objeto(bolsa, color(verde), tamaño(mediano), peso(100)).
	
	%comedor
	objeto(mesa, color(cafe), tamaño(grande), peso(100)).
	objeto(plato, color(blanco), tamaño(pequeño), peso(1)).
	objeto(cofre_de_nani, color(negro), tamaño(mediano), peso(100)).
	objeto(caja_amarilla, color(oro), tamaño(pequeño), peso(30)).
	objeto(caja_roja, color(oro), tamaño(pequeño), peso(30)).
	objeto(caja_azul, color(oro), tamaño(pequeño), peso(30)).
	objeto(nani, color(blanco), tamaño(pequeño), peso(1)).
	
	
		
	
	objeto(llave_cofre, color(amarillo), tamaño(pequeño), peso(1)).
	
	
	%pasillo

	
	%sala1
	objeto(estambre, color(azul), tamaño(pequeño), peso(1)).
	objeto(caja, color(cafe), tamaño(pequeño), peso(50)).


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
	locación(refrigerador,cocina).
	locación(barrita,cocina).
	locación(carne,refrigerador).
	locación(uvas,refrigerador).
	locación(chocolate,refrigerador).
	locación(estufa,cocina).
	locación(manzana,barrita).
	locación(pera,barrita).
	locación(madera,cocina).
	locación(bolsa,cocina).

	%comedor
	locación(mesa,comedor).
	locación(plato,mesa).
	locación(cofre_de_nani,comedor).
	locación(caja_amarilla,cofre_de_nani).
	locación(caja_roja,cofre_de_nani).
	locación(caja_azul,cofre_de_nani).
	locación(nani,caja_amarilla).
	
	



	%pasillo1
	%locación(caja1,pasillo1).

	

	%sala1
	locación(caja,sala1).
	locación(estambre,caja).


	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				
				
