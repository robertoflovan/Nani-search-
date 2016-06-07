

		ayuda :- tutorial(3),newWrite,
				 appendWrite('Consola&*Lees el extra�o tatuaje de tu brazo*
Acciones que puedes controlar, escrito por Low ;)
	Ver
	Conocer el inventario que llevas
	Apagar la luz de la habitaci�n
	Encender la luz de la habitaci�n
	Abrir alg�n contenedor o una puerta
	Cerrar alg�n contenedor o una puerta
	Ir a alg�n lugar
	Tomar alg�n objeto
	Tirar alg�n objeto
	Comer algo
	Colocar en tu �nica mano alg�n objeto
	Guardar un objeto en una mochila
	Inspeccionar un objeto**
	Usar un objeto**.
	*Podr�s ver esta lista pronunciando �ayuda� cuando quieras*').

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%- Cerrar un objeto -%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-Habitaci�n o inventario-%%%%%%%%%
	/*1*/cerrar(Objeto) :-tutorial(3),newWrite,
									not(habitaci�n(Objeto)),
									contenedor(Objeto,_),
									disponible(Objeto),
									not(abierto(Objeto)),
									appendWrite('El/La '),
									appendWrite(Objeto),
									appendWrite(' ya se encuentra cerrado.').
	/*2*/cerrar(Objeto) :-tutorial(3),newWrite,
									not(habitaci�n(Objeto)),
									contenedor(Objeto,_),
									disponible(Objeto),
									abierto(Objeto),
									retract(abierto(Objeto)),
									appendWrite('Cerraste la '),
									appendWrite(Objeto).
	/*3*/cerrar(Objeto) :-tutorial(3),newWrite,
									not(habitaci�n(Objeto)),
									not(contenedor(Objeto,_)),
									disponible(Objeto),
									appendWrite('Creo que est�s confundiendo el concepto de "cerrar"').
	/*4*/cerrar(Objeto) :-tutorial(3),newWrite,
									not(habitaci�n(Objeto)),
									not(contenedor(Objeto,_)),
									not(disponible(Objeto)),
									appendWrite('No encuentras ning�n '),
									appendWrite(Objeto),
									appendWrite(' para intentar cerrar').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%- Cerrar habitaci�n -%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*1*/cerrar(Habitaci�n) :-tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(contenedor(Habitaci�n,_)),
									not(disponible(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									conecta_con(Ubicaci�n,Habitaci�n),
									puerta_abierta(Ubicaci�n,Habitaci�n),
									appendWrite('No existe ning�na puerta hacia el/la '),
									appendWrite(Habitaci�n),
									appendWrite(' para cerrar').
	/*2*/cerrar(Habitaci�n) :-tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(contenedor(Habitaci�n,_)),
									not(disponible(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									conecta_con(Ubicaci�n,Habitaci�n),
									not(puerta_abierta(Ubicaci�n,Habitaci�n)),
									not(abierto(Ubicaci�n,Habitaci�n)),
									appendWrite('La puerta hacia el/la '),
									appendWrite(Habitaci�n),
									appendWrite(' ya se encuentra cerrada').
	/*3*/cerrar(Habitaci�n) :-tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(contenedor(Habitaci�n,_)),
									not(disponible(Habitaci�n)),
									not(ubicaci�n(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									not(conecta_con(Ubicaci�n,Habitaci�n)),
									appendWrite('Ese lugar est� muy lejos').
	/*4*/cerrar(Habitaci�n) :-tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(contenedor(Habitaci�n,_)),
									not(disponible(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									conecta_con(Ubicaci�n,Habitaci�n),
									not(puerta_abierta(Ubicaci�n,Habitaci�n)),
									abierto(Ubicaci�n,Habitaci�n),
									retractabierto(Ubicaci�n,Habitaci�n),
									appendWrite('Cerraste la puesta hacia el/la '),
									appendWrite(Habitaci�n).
	/*5*/cerrar(Habitaci�n) :-tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(contenedor(Habitaci�n,_)),
									not(disponible(Habitaci�n)),
									ubicaci�n(Habitaci�n),
									appendWrite('Indica la puerta de una habitaci�n a tu alrrededor para cerrar').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- ubicaci�n actual, conexiones y cosas en la ubicaci�n actual -%%%%%%
	ver:-tutorial(3),
		write('Se ejecut� "ver"'),
		newWrite,
		ubicaci�n(X),
		not(apagado(X)),
		appendWrite('Te encuentras en la '),
		appendWrite(X), nlW, appendWrite('Puedes ver: '), nlW,
		listar_objetos(X),
		nlW,appendWrite('Las habitaciones a tu alrededor son:'), nlW,
		listar_conexiones(X),
		write('Termino de ejecuci�n de "ver"').
	ver:-tutorial(3),
		newWrite,
		ubicaci�n(X),
		apagado(X),
		appendWrite('Te encuentras en la '),
		appendWrite(X), nlW,
		appendWrite('No puedes ver nada porque la luz est� apagada'), nlW,
		appendWrite('Las habitaciones a tu alrededor son:'), nlW,
		listar_conexiones(X).
	verApp:- tutorial(3),
		ubicaci�n(X),
		not(apagado(X)),
		appendWrite('Te encuentras en la '),
		appendWrite(X), nlW, appendWrite('Puedes ver: '), nlW,
		listar_objetos(X),
		nlW,appendWrite('Las habitaciones a tu alrededor son:'), nlW,
		listar_conexiones(X).
	verApp:-tutorial(3),
		ubicaci�n(X),
		apagado(X),
		appendWrite('Te encuentras en la '),
		appendWrite(X), nlW,
		appendWrite('No puedes ver nada porque la luz est� apagada'), nlW,
		appendWrite('Las habitaciones a tu alrededor son:'), nlW,
		listar_conexiones(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- Mover al personaje a otra habitaci�n -%%%%%%
	%Mover de ubicaci�n y actualizar estado
		%ir_a(Lugar):-tutorial(3),newWrite,
		%					puede_ir(Lugar),
		%					mover(Lugar),
		%					verApp.


	%Verifica si la ubicaci�n est� conectada para poder ir
		/*1*/puede_ir(Algo):-
								not(habitaci�n(Algo)),
								not(disponible(Algo)),
								appendWrite('No encuentras ese lugar'),
								nlW,fail.
		/*2*/puede_ir(Objeto):-
								not(habitaci�n(Objeto)),
								disponible(Objeto),
								appendWrite('No puedes ir dentro de los objetos... Por ahora'),
								nlW,fail.
		/*3*/puede_ir(Habitaci�n):-
								habitaci�n(Habitaci�n),
								not(disponible(Habitaci�n)),
								not(ubicaci�n(Habitaci�n)),
								ubicaci�n(X),
								not(conecta_con(X,Habitaci�n)),
								appendWrite('No puedes ir ah� desde aqui'),
								nlW,fail.
		/*4*/puede_ir(Habitaci�n):-
								habitaci�n(Habitaci�n),
								not(disponible(Habitaci�n)),
								ubicaci�n(Habitaci�n),
								appendWrite('Ya te encuentras en la '),
								appendWrite(Habitaci�n),
								nlW,fail.
		/*5*/puede_ir(Habitaci�n):-
								habitaci�n(Habitaci�n),
								not(disponible(Habitaci�n)),
								ubicaci�n(X),
								conecta_con(X,Habitaci�n),
								puerta_abierta(X,Habitaci�n).
		/*5*/puede_ir(Habitaci�n):-
								habitaci�n(Habitaci�n),
								not(disponible(Habitaci�n)),
								ubicaci�n(X),
								conecta_con(X,Habitaci�n),
								not(puerta_abierta(X,Habitaci�n)),
								abierto(X,Habitaci�n).
		/*5*/puede_ir(Habitaci�n):-
								habitaci�n(Habitaci�n),
								not(disponible(Habitaci�n)),
								ubicaci�n(X),
								conecta_con(X,Habitaci�n),
								not(puerta_abierta(X,Habitaci�n)),
								not(abierto(X,Habitaci�n)),
								appendWrite('Te acabas de darte un golpe contra la puerta, creo que ser�a mejor si intentaras abrirla primero'),
								nlW,fail.



	%elimina la ubicaci�n actual y crea una nueva con el lugar indicado
		mover(Lugar):-
								ubicaci�n(X),
								retract(ubicaci�n(X)),
								asserta(ubicaci�n(Lugar)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- Tomar alg�n objeto que se encuentre en la habitaci�n -%%%%%%
	tomar(Objeto):-tutorial(3),newWrite,
		puede_tomar(Objeto), %comprueba que sea un objeto v�lido
		puede_agarrar(Objeto), %comprueba que tengas espacio en el inventario
		appendWrite('tomaste el objeto').

%%%%%%%-puede tomar-%%%%%%%
		/*1*/puede_tomar(Algo):-
								not(agarrable(Algo)),
								not(habitaci�n(Algo)),
								not(disponible(Algo)),
								appendWrite('No encuentras ese objeto para tomar'),
								nlW,fail.
		/*2*/puede_tomar(Habitaci�n):-
								not(agarrable(Habitaci�n)),
								habitaci�n(Habitaci�n),
								not(disponible(Habitaci�n)),
								not(ubicaci�n(Habitaci�n)),
								not(conecta_con(X,Habitaci�n)),
								appendWrite('No alcanzas ese lugar para tomar... y de todos modos no puedes tomar una habitaci�n entera.'),
								nlW,fail.
		/*3*/puede_tomar(Habitaci�n):-
								not(agarrable(Habitaci�n)),
								habitaci�n(Habitaci�n),
								not(disponible(Habitaci�n)),
								ubicaci�n(Habitaci�n),
								appendWrite('wow, est�s intentado tomar la habitaci�n entera en donde te encuentras... crear�as una paradoja.'),
								nlW,fail.
		/*3*/puede_tomar(Habitaci�n):-
								not(agarrable(Habitaci�n)),
								habitaci�n(Habitaci�n),
								not(disponible(Habitaci�n)),
								not(ubicaci�n(Habitaci�n)),
								ubicaci�n(X),
								conecta_con(X,Habitaci�n),
								tab(5), appendWrite('Imagina que est�s al lado de una habitaci�n...'),nlW,
								tab(5), appendWrite('en esa habitaci�n hay muchos objetos valiosos para ti,'),nlW,
								tab(5), appendWrite('las paredes y el suelo te parecen hermosos, as� como la iluminaci�n,'),nlW,
								tab(5), appendWrite('entonces piensas, �por qu� no llevarme toda la habitaci�n entera, con sus objetos, paredes, el suelo, el techo, etc...?'),nlW,
								tab(5), appendWrite('La tomas entera y la metes en tu bolsillo'),nlW,
								tab(5), appendWrite('�Te parece algo l�gico?'), tab(7), appendWrite('(Responde con un "si." o "no.") :') ,nlW,
								read(R), respuesta_tomar_habitaci�n(R), nlW, fail.
								respuesta_tomar_habitaci�n(R):- R==si, appendWrite('Oh, si eso te parece l�gico entonces est� bien, ten, toma toda la habitaci�n entera y colocala en tu bolsillo...'),
								nlW, appendWrite('Si claro, graciosito.').
								respuesta_tomar_habitaci�n(R):- R==no, appendWrite('Eso pense... Ahora deja de hacerte el gracioso e intenta tomar algo m�s l�gico.').
								respuesta_tomar_habitaci�n(R):- R\== si, R\== no, appendWrite('No seguir� hablandole a alguien que no sabe ni responder una simple pregunta...').

		/*4*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitaci�n(Objeto)),
								not(contenedor(Objeto,_)),
								ubicaci�n(X),
								not(se_puede_ver(Objeto,X)),
								mis_objetos(Objeto),
								appendWrite('Ya has tomado �ste objeto...'),
								nlW,fail.
		/*&4*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitaci�n(Objeto)),
								not(contenedor(Objeto,_)),
								not(mis_objetos(Objeto)),
								ubicaci�n(X),
								se_puede_ver(Objeto,X),
								objeto(Objeto, color(_), tama�o(peque�o), peso(P)),
								P<5.
		/*5*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitaci�n(Objeto)),
								not(contenedor(Objeto,_)),
								not(mis_objetos(Objeto)),
								ubicaci�n(X),
								se_puede_ver(Objeto,X),
								objeto(Objeto, color(_), tama�o(peque�o), peso(P)),
								P>5,
								appendWrite('Este objeto es muy pesado para ti'),
								nlW,fail.
		/*6*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitaci�n(Objeto)),
								not(contenedor(Objeto)),
								not(mis_objetos(Objeto)),
								ubicaci�n(X),
								se_puede_ver(Objeto,X),
								objeto(Objeto, color(_), tama�o(Tama�o), peso(P)),
								Tama�o \== peque�o,
								P<5,
								appendWrite('Este objeto es muy grande para ti'),
								nlW,fail.
		/*7*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitaci�n(Objeto)),
								not(contenedor(Objeto,_)),
								not(mis_objetos(Objeto)),
								ubicaci�n(X),
								se_puede_ver(Objeto,X),
								objeto(Objeto, color(_), tama�o(Tama�o), peso(P)),
								Tama�o \== peque�o,
								P>5,
								appendWrite('Este objeto es muy grande y pesado para ti.'),
								nlW,fail.
		/*8*/puede_tomar(Agarrable):-
								agarrable(Agarrable),
								not(habitaci�n(Agarrable)),
								not(mis_objetos(Agarrable)),
								ubicaci�n(X),
								se_puede_ver(Agarrable,X).

		/*9*/puede_tomar(Contenedor):-
								contenedor(Contenedor,_),
								not(agarrable(Contenedor)),
								not(habitaci�n(Contenedor)),
								not(mis_objetos(Contenedor)),
								ubicaci�n(X),
								se_puede_ver(Contenedor,X),
								appendWrite('No puedes tomar �ste contendor'),nlW,fail.

		%%%%%%- Comprueba que tengas espacio en tu inventario o agarrable que tengas -%%%%%
		/*1*/ puede_agarrar(Objeto) :-
										not(contenedor(Objeto,_)),
										not(mi_agarrable(_)),
										not(objeto_en_mano(_)),
										retract(locaci�n(Objeto,_)),
										asserta(objeto_en_mano(Objeto)).

		/*2*/ puede_agarrar(Objeto) :-
										not(contenedor(Objeto,_)),
										not(mi_agarrable(_)),
										objeto_en_mano(_),
										appendWrite('No puedes tomar �ste objeto porque ya est�s cargando un objeto y no tienes d�nde m�s colocarlo :P'),
										nlW,fail.
		/*3*/ puede_agarrar(Objeto) :-
										not(contenedor(Objeto,_)),
										mi_agarrable(Contenedor),
										not(lleno(Contenedor)),
										retract(locaci�n(Objeto,_)),
										asserta(locaci�n(Objeto,Contenedor)).
		/*4*/ puede_agarrar(Objeto) :- %Si no puedo quitar el objeto de la mano esta es una posibilidad inecesaria
										not(contenedor(Objeto,_)),
										mi_agarrable(Contenedor),
										lleno(Contenedor),
										not(objeto_en_mano(_)),
										retract(locaci�n(Objeto,_)),
										asserta(objeto_en_mano(Objeto)).
		/*5*/ puede_agarrar(Objeto) :-
										not(contenedor(Objeto,_)),
										mi_agarrable(Contenedor),
										lleno(Contenedor),
										objeto_en_mano(_),
										appendWrite('No puedes tomar el objeto, tu contenedor est� lleno y ya llevas un objeto en la mano'),
										nlW,fail.

		/*6*/ puede_agarrar(Agarrable) :-
										contenedor(Agarrable,_),
										agarrable(Agarrable),
										mi_agarrable(_),
										appendWrite('Solo puedes tener un contenedor a la vez'),
										nlW,fail.
		/*7*/ puede_agarrar(Agarrable) :-
										contenedor(Agarrable,Lim),
										agarrable(Agarrable),
										not(mi_agarrable(_)),
										retract(locaci�n(Agarrable,_)),
										asserta(mi_agarrable(Agarrable)),
										appendWrite('Ahora puedes tener '),
										appendWrite(Lim),
										appendWrite(' cosas m�s en tu inventario.'),
										nlW,fail.

		/*8*/ puede_agarrar(Contenedor) :- %???????????? conbinar con grande y pesado agregando contenedores
										contenedor(Contenedor,_),
										not(agarrable(Contenedor)),
										appendWrite('No puedes llevar contigo �ste contenedor'),
										nlW,fail.



		%%%%%%- Elimina la locaci�n del objeto y coloca el objeto en tu inventario- %%%%%
		%agarrar(Objeto) :-
		%						%ubicaci�n(X),
		%						retract(locaci�n(Objeto,_)),
		%						asserta(mis_objetos(Objeto)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- Dejar un objeto que tengas en el inventario -%%%%%%
	soltar(Objeto):-tutorial(3),newWrite,
		puede_soltar(Objeto),
		dejar(Objeto),
		appendWrite('Acabas de soltar el objeto en el suelo...').
%%%%%%%-puede soltar-%%%%%%%
		/*1*/puede_soltar(Habitaci�n):-
								not(mi_agarrable(Algo)),
								habitaci�n(Habitaci�n),
								not(disponible(Habitaci�n)),
								appendWrite('Por lo menos intenta tomar la habitaci�n primero...'),
								nlW,fail.
		/*1*/puede_soltar(Algo):-
								not(mi_agarrable(Algo)),
								not(habitaci�n(Algo)),
								not(disponible(Algo)),
								appendWrite('No tienes ning�n objeto llamado '),
								appendWrite(Algo),
								nlW,fail.
		/*2*/puede_soltar(Objeto):-
								not(mi_agarrable(Algo)),
								not(habitaci�n(Objeto)),
								not(mis_objetos(Objeto)),
								ubicaci�n(X),
								se_puede_ver(Objeto,X),
								appendWrite('Debes de tener el objeto primero.'),
								nlW,fail.
		/*3*/puede_soltar(Objeto):-
								not(mi_agarrable(Objeto)),
								not(habitaci�n(Objeto)),
								mis_objetos(Objeto),
								ubicaci�n(X),
								not(se_puede_ver(Objeto,X)) ,nlW.
		/*4*/puede_soltar(Agarrable):-
								not(habitaci�n(Agarrable)),
								mi_agarrable(Agarrable),
								nlW.


		%%%%%%- elimina la locaci�n del inventario y la coloca en la ubicaci�n -%%%%%
		dejar(Objeto) :-
							objeto_en_mano(Objeto),
							ubicaci�n(X),
							retract(objeto_en_mano(Objeto)),
							asserta(locaci�n(Objeto,X)).
		dejar(Objeto) :-
							mi_agarrable(Contenedor),
							locaci�n(Objeto,Contenedor),
							ubicaci�n(X),
							retract(locaci�n(Objeto,Contenedor)),
							asserta(locaci�n(Objeto,X)).
		dejar(Agarrable) :-
							mi_agarrable(Agarrable),
							ubicaci�n(X),
							retract(mi_agarrable(Agarrable)),
							asserta(locaci�n(Agarrable,X)).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%- Inventario -%%%%%%%%%%%%%%%
	inventario :-tutorial(3),newWrite,
					imprimir_objeto_en_mano,
					imprimir_agarrable.
	imprimir_objeto_en_mano :-
									objeto_en_mano(X),
									tab(4),appendWrite('Tienes un/una '),nlW,
									tab(4),appendWrite(X),
									tab(4),appendWrite(' en la mano'),nlW.
	imprimir_objeto_en_mano :-
									not(objeto_en_mano(_)),
									tab(4),appendWrite('No llevas ning�n objeto en la mano'),nlW.
	imprimir_agarrable :-
									mi_agarrable(X),
									not(locaci�n(_,X)),
									tab(4), appendWrite('Llevas contigo una '),appendWrite(X),nlW,
									tab(4), appendWrite('Pero dentro de ella no tienes objetos ahora').
	imprimir_agarrable :-
									mi_agarrable(X),
									locaci�n(_,X),
									tab(4), appendWrite('Llevas contigo una '),appendWrite(X),nlW,
									tab(4), appendWrite('Dentro de ella se encuentran:'),nlW,!,
									locaci�n(Cosas,X),
									imprimir_objeto(Cosas).
	imprimir_agarrable :-
									not(mi_agarrable(_)),
									tab(4),appendWrite('Y no llevas alg�n contenedor contigo para guardar m�s objetos.'),nlW.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- Comer un objeto que tengas en el inventario -%%%%%%
	comer(Objeto):-tutorial(3),newWrite,
		puede_comer(Objeto),
		ingerir(Objeto).

		/*1*/puede_comer(Algo):-
										not(habitaci�n(Algo)),
										not(disponible(Algo)),
										appendWrite('No encuentras ese objeto para intentar comer'),
										nlW,fail.
		/*2*/puede_comer(Habitaci�n):-
										habitaci�n(Habitaci�n),
										not(disponible(Habitaci�n)),
										appendWrite('No, no puedes comerte las habitaciones...'),
										nlW,fail.
		/*3*/puede_comer(Objeto):-
										not(habitaci�n(Objeto)),
										not(mis_objetos(Objeto)),
										ubicaci�n(X),
										se_puede_ver(Objeto,X),
										not(comida(Objeto, sabor(_), estado(_))),
										appendWrite('No tienes ese objeto... adem�s que ni siquiera se puede comer .-.'),
										nlW,fail.
		/*4*/puede_comer(Objeto):-
										not(habitaci�n(Objeto)),
										not(mis_objetos(Objeto)),
										ubicaci�n(X),
										se_puede_ver(Objeto,X),
										comida(Objeto, sabor(_), estado(_)),
										appendWrite('Debes de tomar primero la comida.'),
										nlW,fail.
		/*5*/puede_comer(Objeto):-
										not(habitaci�n(Objeto)),
										mis_objetos(Objeto),
										ubicaci�n(X),
										not(se_puede_ver(Objeto,X)),
										not(comida(Objeto, sabor(_), estado(_))),
										appendWrite('Este objeto no se puede comer'),
										nlW,fail.
		/*6*/puede_comer(Objeto):-
										not(habitaci�n(Objeto)),
										mis_objetos(Objeto),
										ubicaci�n(X),
										not(se_puede_ver(Objeto,X)),
										comida(Objeto, sabor(normal), estado(_)),
										appendWrite('Has comido el objeto, su sabor te pareci� indiferente.'),nlW.
		/*6*/puede_comer(Objeto):-
										not(habitaci�n(Objeto)),
										mis_objetos(Objeto),
										ubicaci�n(X),
										not(se_puede_ver(Objeto,X)),
										comida(Objeto, sabor(rico), estado(_)),
										appendWrite('Has comido el objeto, su sabor te pareci� muy bueno, ahora eres muy feliz :D'),nlW.
		/*7*/puede_comer(Objeto):-
										not(habitaci�n(Objeto)),
										mis_objetos(Objeto),
										ubicaci�n(X),
										not(se_puede_ver(Objeto,X)),
										comida(Objeto, sabor(_), estado(crudo)),
										appendWrite('No pudes comer eso proque est� crudo.'),
										nlW,fail.
		/*7*/puede_comer(Objeto):-
										not(habitaci�n(Objeto)),
										mis_objetos(Objeto),
										ubicaci�n(X),
										not(se_puede_ver(Objeto,X)),
										not(comida(Objeto, sabor(_), estado(crudo))),
										comida(Objeto, sabor(feo), estado(_)),
										appendWrite('No quieres comer eso D:'),
										nlW,fail.




		%%%%%%- elimina el objeto del inventario -%%%%%
		ingerir(Objeto) :-
								objeto_en_mano(Objeto),
								ubicaci�n(X),
								retract(objeto_en_mano(Objeto)),
								asserta(locaci�n(Objeto,X)).
		ingerir(Objeto) :-
								mi_agarrable(Contenedor),
								locaci�n(Objeto,Contenedor),
								ubicaci�n(X),
								retract(locaci�n(Objeto,Contenedor)),
								asserta(locaci�n(Objeto,X)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%- Dejar un objeto sobre o dentro de otro objeto -%%%%%%
	soltar_en(Objeto,Apilador):-tutorial(3),newWrite,
		puede_soltar_en(Objeto,Apilador),
		dejar_en(Objeto,Apilador).

				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				dejar_en(Objeto,Apilador) :-
												objeto_en_mano(Objeto),
												retract(objeto_en_mano(Objeto)),
												asserta(locaci�n(Objeto,Apilador)).
				dejar_en(Objeto,Apilador) :-
												mi_agarrable(Contenedor),
												locaci�n(Objeto,Contenedor),
												retract(locaci�n(Objeto,Contenedor)),
												asserta(locaci�n(Objeto,Apilador)).
				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		/*1*/puede_soltar_en(Cosa,NoImporta) :-
										not(habitaci�n(Cosa)),
										not(disponible(Cosa)),
										appendWrite('No encuentras ese objeto para intentar soltar'),
										nlW,fail.
		/*2*/puede_soltar_en(Objeto,NoImporta) :-
										not(habitaci�n(Objeto)),
										disponible(Objeto),
										not(mis_objetos(Objeto)),
										appendWrite('Debes de tomar el objeto primero'),
										nlW,fail.
		/*3*/puede_soltar_en(Habitaci�n,NoImporta) :-
										habitaci�n(Habitaci�n),
										appendWrite('No puedes dejar la habitaci�n porque no la tienes, y porque ser�a il�gico'),
										nlW,fail.
		/*4*/puede_soltar_en(Objeto,Cosa) :-
										mis_objetos(Objeto),
										not(habitaci�n(Cosa)),
										not(disponible(Cosa)),
										appendWrite('No encuentras ese lugar para dejar el objeto'),
										nlW,fail.
		/*5*/puede_soltar_en(Objeto,Inventario) :-
										mis_objetos(Objeto),
										not(habitaci�n(Inventario)),
										disponible(Inventario),
										mis_objetos(Inventario),
										appendWrite('Intentaste colocar un objeto de tu inventario en otra cosa de tu inventario...'),
										nlW,fail.
		/*6*/puede_soltar_en(Objeto,MismoObjeto) :-
										mis_objetos(Objeto),
										not(habitaci�n(MismoObjeto)),
										mis_objetos(MismoObjeto),
										Objeto == MismoObjeto,
										appendWrite('Creaste una paradoja'),
										nlW,fail.
		/*&7*/puede_soltar_en(Objeto,Habitaci�n) :-
										mis_objetos(Objeto),
										habitaci�n(Habitaci�n),
										ubicaci�n(Habitaci�n),
										appendWrite('Colocaste el objeto en el suelo'),nlW.
		/*8*/puede_soltar_en(Objeto,Habitaci�n) :-
										mis_objetos(Objeto),
										habitaci�n(Habitaci�n),
										not(ubicaci�n(Habitaci�n)),
										appendWrite('No puedes dejar ese objeto en esa habitaci�n porque no te encuentras en ella'),
										nlW,fail.
		/*9*/puede_soltar_en(Objeto,OtroObjeto) :-
										mis_objetos(Objeto),
										not(habitaci�n(OtroObjeto)),
										ubicaci�n(X),
										se_puede_ver(OtroObjeto,X),
										not(contenedor(OtroObjeto,_)),
										not(apilador(OtroObjeto)),
										appendWrite('No puedes soltar en �ste objeto'),
										nlW,fail.
		/*10-1-1*/puede_soltar_en(Objeto,OtroObjeto) :- %%Si a�n existe espacio en el contenedor
										mis_objetos(Objeto),  %%El contenedor NO se  encuentra abierto
										not(habitaci�n(OtroObjeto)),
										ubicaci�n(X),
										se_puede_ver(OtroObjeto,X),
										contenedor(OtroObjeto,_),
										not(apilador(OtroObjeto)),
										not(lleno(OtroObjeto)), %-<<<<
										not(abierto(OtroObjeto)), %Solo entra hasta aqu� si el objeto se puede ver, y si se puede ver significa que sus contenedores padres ya est�n abiertos, por lo que solo verificamos d�nde se colocar� el objeto
										%not(contenedores_abiertos(OtroObjeto)),
										appendWrite('No puedes colocar dentro de �ste contenedor porque se encuentra cerrado'),
										nlW,fail.
		/*&10-1-2*/puede_soltar_en(Objeto,OtroObjeto) :- %%Si a�n existe espacio en el contenedor
										mis_objetos(Objeto),  %%El contenedor se encuentra abierto
										not(habitaci�n(OtroObjeto)),
										ubicaci�n(X),
										se_puede_ver(OtroObjeto,X),
										contenedor(OtroObjeto,_),
										not(apilador(OtroObjeto)),
										not(lleno(OtroObjeto)), %-<<<<
										abierto(OtroObjeto),
										contenedores_abiertos(OtroObjeto),
										appendWrite('Colocaste el/la '),
										appendWrite(Objeto),
										appendWrite(' Dentro de el/la '),
										appendWrite(OtroObjeto),
										nlW.
		/*10-2*/puede_soltar_en(Objeto,OtroObjeto) :- %%Si ya No cabe nada m�s en el contenedor
										mis_objetos(Objeto),
										not(habitaci�n(OtroObjeto)),
										ubicaci�n(X),
										se_puede_ver(OtroObjeto,X),
										contenedor(OtroObjeto,_),
										not(apilador(OtroObjeto)),
										lleno(OtroObjeto), %-<<<<
										appendWrite('El contenedor est� lleno'),nlW,
										%appendWrite(Objeto),
										%appendWrite(' Dentro de el/la '),
										%appendWrite(OtroObjeto),
										fail,nlW.
		/*&11*/puede_soltar_en(Objeto,OtroObjeto) :-
										mis_objetos(Objeto),
										not(habitaci�n(OtroObjeto)),
										ubicaci�n(X),
										se_puede_ver(OtroObjeto,X),
										not(contenedor(OtroObjeto,_)),
										apilador(OtroObjeto),
										appendWrite('Colocaste el/la '),
										appendWrite(Objeto),
										appendWrite(' sobre el/la '),
										appendWrite(OtroObjeto),
										nlW.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


	encender_luz :-tutorial(3),newWrite,
						ubicaci�n(X),
						not(apagado(X)),
						appendWrite('La luz ya est� encendida'),
						fail.
	encender_luz :-tutorial(3),newWrite,
						ubicaci�n(X),
						apagado(X),
						retract(apagado(X)),
						appendWrite('Convenientemente el switch lo puedes ver y est� a tu alcance, as� que enciendes la luz').

	apagar_luz :-tutorial(3),newWrite,
						ubicaci�n(X),
						not(apagado(X)),
						asserta(apagado(X)),
						appendWrite('Convenientemente el switch lo puedes alcanzar, as� que apagas la luz').

	apagar_luz :-tutorial(3),newWrite,
						ubicaci�n(X),
						apagado(X),
						appendWrite('La luz ya est� apagada'),
						fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	colocar_en_mano(Objeto) :-tutorial(3),newWrite,
									not(mis_objetos(Objeto)),
									puede_tomar(Objeto),
									colocar_en_mano_habitaci�n(Objeto).
	colocar_en_mano(Objeto) :-tutorial(3),newWrite,
									mis_objetos(Objeto),
									colocar_en_mano_inventario(Objeto).

	/*2*/colocar_en_mano_habitaci�n(Objeto) :-
									not(objeto_en_mano(_)),
									ubicaci�n(X),
									se_puede_ver(Objeto,X),
									not(agarrable(Objeto)),
									puede_tomar(Objeto),
									asserta(objeto_en_mano(Objeto)),
									retract(locaci�n(Objeto,_)),
									appendWrite('Colocaste el objeto en tu mano').
	/*2.1*/colocar_en_mano_habitaci�n(Objeto) :-
									objeto_en_mano(_),
									ubicaci�n(X),
									se_puede_ver(Objeto,X),
									not(agarrable(Objeto)),
									puede_tomar(Objeto),
									appendWrite('S�lo puedes tener un objeto en la mano'),
									nlW,fail.
	/*2.2*/colocar_en_mano_habitaci�n(Agarrable) :-
									ubicaci�n(X),
									se_puede_ver(Agarrable,X),
									agarrable(Agarrable),
									appendWrite('No puedes llevar un contenedor en la mano, ser� mejor que lo cuelges contigo (tomar(Objeto))'),
									nlW,fail.

	/*3*/colocar_en_mano_inventario(Objeto) :-
									objeto_en_mano(Objeto),
									appendWrite('Ese objeto ya se encuentra en tu mano'),
									nlW,fail.
	/*4*/colocar_en_mano_inventario(Objeto) :-
									mi_agarrable(Contenedor),
									locaci�n(Objeto,Contenedor),
									not(objeto_en_mano(_)),
									retract(locaci�n(Objeto,Contenedor)),
									asserta(objeto_en_mano(Objeto)),
									appendWrite('Colocaste en tu mano el objeto que ten�as en tu mochila').
	/*5*/colocar_en_mano_inventario(Objeto) :-
									mi_agarrable(Contenedor),
									locaci�n(Objeto,Contenedor),
									objeto_en_mano(Objeto2),
									retract(locaci�n(Objeto,Contenedor)),
									retract(objeto_en_mano(Objeto2)),
									asserta(objeto_en_mano(Objeto)),
									asserta(locaci�n(Objeto2,Contenedor)),
									appendWrite('Guardaste el/la '), appendWrite(Objeto2), appendWrite(' que ten�as en la mano'),nlW,
									appendWrite('y colocaste el/la '),appendWrite(Objeto),appendWrite( 'en tu mano'),nlW.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	guardar_en_mochila(Objeto):-tutorial(3),newWrite,
									not(mis_objetos(Objeto)),
									puede_tomar(Objeto),
									tiene_mochila,
									guardar_en_mochila_habitaci�n(Objeto).
	guardar_en_mochila(Objeto):-tutorial(3),newWrite,
									mis_objetos(Objeto),
									tiene_mochila,
									guardar_en_mochila_inventario(Objeto).

	tiene_mochila :- mi_agarrable(_).
	tiene_mochila :- not(mi_agarrable(_)), appendWrite('No tienes ning�n contenedor en donde colocar el objeto'),nlW,fail.

	/*1*/guardar_en_mochila_habitaci�n(Objeto) :-
									mi_agarrable(Contenedor),
									not(lleno(Contenedor)),
									retract(locaci�n(Objeto,_)),
									asserta(locaci�n(Objeto,Contenedor)),
									appendWrite('Tomaste el objeto y lo colocaste en tu mochila').
	/*2*/guardar_en_mochila_habitaci�n(Objeto) :-
									mi_agarrable(Contenedor),
									lleno(Contenedor),
									appendWrite('No tienes espacio suficiente en tu mochila'),
									nlW,fail.
	/*3*/guardar_en_mochila_inventario(Objeto) :-
									objeto_en_mano(Objeto),
									mi_agarrable(Contenedor),
									not(lleno(Contenedor)),
									retract(objeto_en_mano(_)),
									asserta(locaci�n(Objeto,Contenedor)),
									appendWrite('Dejaste el objeto que ten�as en la mano en tu mochila').
	/*4*/guardar_en_mochila_inventario(Objeto) :-
									objeto_en_mano(Objeto),
									mi_agarrable(Contenedor),
									lleno(Contenedor),
									appendWrite('No tienes espacio suficiente en tu mochila'),
									nlW,fail.
	/*4*/guardar_en_mochila_inventario(Objeto) :-
									mi_agarrable(Contenedor),
									locaci�n(Objeto,Contenedor),
									appendWrite('Este objeto ya se encuentra en tu mochila'),
									nlW,fail.