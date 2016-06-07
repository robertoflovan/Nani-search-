:- dynamic
	abierto/1,
	contTemp(0). 


%%%%%%- Encontrar comida u bebida en mi ubicación actual -%%%%%%
buscar_comida(Comida,Lugar):-locación(Comida,Lugar),
									comida(Comida, sabor(_), estado(_)).
buscar_bebida(Bebida,Lugar):-locación(Bebida,Lugar),
									bebida(Bebida, sabor(_), estado(_)).

%%%%%%- Listar todas las conexiones, salida siempre éxito para utilizarla después -%%%%%%
listar_conexiones(Lugar):- 
									conecta_con(Lugar,X),
									puerta_abierta(Lugar,X),
					  				appendWrite('	'),
					  				appendWrite(X), appendWrite(' (no hay puerta)'),
					  				nlW, fail.
listar_conexiones(Lugar):- 
									conecta_con(Lugar,X),
									not(puerta_abierta(Lugar,X)),
									not(abierto(Lugar,X)),
					  				appendWrite('	'),
					  				appendWrite(X), appendWrite(' (la puerta se encuentra cerrada)'),
					  				nlW, fail.
listar_conexiones(Lugar):- 
									conecta_con(Lugar,X),
									not(puerta_abierta(Lugar,X)),
									abierto(Lugar,X),
					  				appendWrite('	'),
					  				appendWrite(X), appendWrite(' (la puerta se encuentra abierta)'),
					  				nlW, fail.

listar_conexiones(_).

%%%%%%- Listar todas las cosas que se pueden ver. Salida siempre éxito para utilizarla después -%%%%%%
listar_objetos(Lugar):- 
								se_puede_ver(Objeto,Lugar),
								imprimir_objetos(Objeto).
listar_objetos(Lugar):- 
								not(se_puede_ver(Objeto,Lugar)),
								appendWrite('		'),
								appendWrite('No, de hecho no puedes ver nada'),nlW,fail.
listar_objetos(_).


/*imprimir_objeto(Objeto) :- 
		locación(Objetos,Lugar),
		apilador(Lugar),
		llave2(Objetos,X,Y),
		^^^^^^^^^^^^^^^^^^^^^^^^
		objeto(Objeto, color(Color), tamaño(Tamaño), peso(Peso)),
		tab(5),appendWrite('Un/Una '),appendWrite(Tamaño),
		tab(1), appendWrite(Objeto),
		tab(1), appendWrite(Color),
		appendWrite(', que pesa '),
		appendWrite(Peso), appendWrite(' kilos.'),
		appendWrite( ' Se encuentra sobre el/la'),
		appendWrite(Lugar),
		nlW,fail.*/

%%%%%%- Objetos y contenedores -%%%%%%
	abierto(X) :- ubicación(X).
	abierto(X) :- apilador(X).
	
	%contenedor(X) :- habitación(X). % ?? Verificar si es necesario
	
	está_contenido_en(Objeto,Lugar) :- 
												locación(Objeto,Lugar).
	está_contenido_en(Objeto,Lugar) :- 
												locación(XXXXXX,Lugar),
												está_contenido_en(Objeto,XXXXXX).
	%bagof(C, se_puede_ver(X,cocina), Cs).
	%se_puede_ver2(Objeto,Habitación):- bagof(C, se_puede_ver(Objeto,Habitación), Cs).

	se_puede_ver(Objeto,Habitación):- 
												está_contenido_en(Objeto,Habitación),
												contenedores_abiertos(Objeto).
				
				
				
	contenedores_abiertos(Objeto):- 
												locación(Objeto,Habitación),
												habitación(Habitación).
	contenedores_abiertos(Objeto):-	
												locación(Objeto,Padre),
												abierto(Padre),
												contenedores_abiertos(Padre).
									
						
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%-Disponible-%%%%%%%%%%%%%%
%Indica si un objeto está disponible
%Verdadero si está en la habitación o en el inventario.

disponible(Objeto) :- ubicación(X),
							 se_puede_ver(Objeto,X).

disponible(Objeto) :- mis_objetos(Objeto).
							 
mis_objetos(Objeto) :- objeto_en_mano(Objeto).
mis_objetos(Objeto) :- mi_agarrable(X), locación(Objeto,X).



%%%%%%- puertas y conexiones -%%%%%%
	%%%%%%- conexiones -%%%%%%
	conecta_con(X,Y):- puerta(X,Y).
	conecta_con(X,Y):- puerta(Y,X).
	conecta_con(X,Y):- puerta_abierta2(X,Y).
	conecta_con(X,Y):- puerta_abierta2(Y,X).
	
	puerta_abierta(X,Y) :- puerta_abierta2(X,Y).
	puerta_abierta(X,Y) :- puerta_abierta2(Y,X).
	
	requiere_llave(X,Y) :- requiere_llave2(X,Y).
	requiere_llave(X,Y) :- requiere_llave2(Y,X).
	
	abierto(X,Y) :- abierto2(X,Y).
	abierto(X,Y) :- abierto2(Y,X).
	
	retractabierto(X,Y) :- retract(abierto2(X,Y)).
	retractabierto(X,Y) :- retract(abierto2(Y,X)).
	
		llave(L,X,Y) :- llave2(L,X,Y).
		llave(L,X,Y) :- llave2(L,Y,X).
		tiene_llave :- mis_objetos(Llave), llave(Llave,_,_).
		llave_correcta(Habitación):- ubicación(X), llave(_,Habitación,X).
	
	
%%%%%%- Verificar espacio en los contenedores-%%%%%%
	
	lleno(Contenedor) :- retractall(contTemp(_)),!,
						not(lleno1(Contenedor)),!,
						verificar1(Contenedor).
	lleno1(Contenedor) :- 
							contenedor(Contenedor,_),
							asserta(contTemp(0)),
							locación(Objetos,Contenedor),
							incrementar,fail.
	verificar1(Contenedor) :- 
							contenedor(Contenedor,Limite),
							verificar(Limite).
	
	
	
	
	llenoOriginal(Contenedor) :- 
							contenedor(Contenedor,Limite),
							asserta(contTemp(0)),
							locación(Objetos,Contenedor),
							incrementar,
							verificar(Limite).
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		incrementar :- 
					contTemp(C),
					A is C+1,
					retractall(contTemp(_)),
					asserta(contTemp(A)).

		verificar(Limite) :- 
					contTemp(X),
					X >= Limite.	
	
		
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%-Codigo Morido-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%- Listar todas las cosas, salida siempre éxito para utilizarla después -%%%%%%
%listar_cosas(Lugar) :-  
%		locación(objeto(Cosa, color(Color), tamaño(Tamaño), peso(Peso)),Lugar),
%		appendWrite('Un '),appendWrite(Tamaño),
%		tab(1), appendWrite(Cosa),
%		tab(1), appendWrite(Color),
%		appendWrite(', que pesa '),
%		appendWrite(Peso), appendWrite(' kilos'), nlW,
%		fail.
%listar_cosas(_).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%abrir(Objeto) :- puede_abrir(Objeto), abrir_objeto(Objeto).
	%puede_abrir(Objeto) :- contenedor(Objeto),
	%							  se_puede_ver(Objeto),
	%							  not abierto(Objeto).
	%abrir_objeto(Objeto) :- asserta(abierto(Objeto)).

%%%%%%- Encontrar comida u bebida en mi ubicación actual -%%%%%%
%buscar_comida(Comida,Lugar):-locación(objeto(Comida, color(_), tamaño(_), peso(_)),Lugar),
%									comida(Comida, sabor(_), estado(_)).
%buscar_bebida(Bebida,Lugar):-locación(objeto(Bebida, color(_), tamaño(_), peso(_)),Lugar),
%									bebida(Bebida, sabor(_), estado(_)).

%se_puede_ver :- bagof(C, se_puede_ver(Objeto), Cs),
%						 ubicación(X),
%						 está_contenido_en(objeto(Objeto, color(Color), tamaño(Tamaño), peso(Peso)),X),
%						 appendWrite('Un '),appendWrite(Tamaño),
%						 tab(1), appendWrite(Objeto),
%						 tab(1), appendWrite(Color),
%						 appendWrite(', que pesa '),
%						 appendWrite(Peso), appendWrite(' kilos'), nlW,
%						 fail.
%	se_puede_ver(Objeto) :- locación(objeto(Objeto, color(_), tamaño(_), peso(_)),Lugar),
%									abierto_contenedores(Lugar).

	%se_puede_ver :- bagof(C, se_puede_ver(Objeto), Cs),
	%					 ubicación(X),
	%					 está_contenido_en(objeto(Objeto, color(Color), tamaño(Tamaño), peso(Peso)),X),
	%					 imprimir_objetos(Objeto).
	%se_puede_ver(Objeto) :- locación(objeto(Objeto, color(_), tamaño(_), peso(_)),Lugar),
	%								abierto_contenedores(Lugar).
	%abierto_contenedores(Objeto) :- not habitación(Objeto),
	%										  está_contenido_en(objeto(Objeto, color(_), tamaño(_), peso(_)),Contenedores),
	%										  abierto(Contenedores),
	%										  abierto(Objeto).
	%abierto_contenedores(Objeto) :- habitación(Objeto),
	%										  abierto(Objeto).
	
	%está_contenido_en(objeto(Objeto, color(Color), tamaño(Tamaño), peso(Peso)),Lugar) :- 
	%						locación(objeto(Objeto, color(Color), tamaño(Tamaño), peso(Peso)),Lugar).
	%está_contenido_en(objeto(Objeto, color(Color), tamaño(Tamaño), peso(Peso)),Lugar) :- 
	%						locación(objeto(XXXXXX, color(Color), tamaño(Tamaño), peso(Peso)),Lugar),
	%						está_contenido_en(objeto(Objeto, color(Color), tamaño(Tamaño), peso(Peso)),XXXXXX).

	
	/*se_puede_ver(Objeto,Habitación) :- bagof(C, se_puede_ver2(Objeto,Lugar), Cs),
										  ubicación(X),
										  está_contenido_en(objeto(Objeto, color(Color), tamaño(Tamaño), peso(Peso)),X),
										  imprimir_objetos(Objeto).
										  
	se_puede_ver2(Objeto,Habitación) :- locación(objeto(Objeto, color(_), tamaño(_), peso(_)),Lugar),
											 abierto_contenedores(Lugar,Habitación).
									

	abierto_contenedores(Objeto) :- not habitación(Objeto),
											  está_contenido_en(objeto(Objeto, color(_), tamaño(_), peso(_)),Contenedores),
											  abierto(Contenedores),
											  abierto(Objeto).
	abierto_contenedores(Objeto) :- habitación(Objeto).*/