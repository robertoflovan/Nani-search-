:- ensure_loaded([
				'Basico',
				'Cosas',
				'Habitaciones',
				'imprimir objetos',
				'Puertas',
				'Respuestas',
				'Interfaz/Interfaz',
				'Interfaz/objetoDeterminante',
				'Interfaz/verbos']).
				
:- dynamic
	tutorial/1,
	abierto2/2,
	apagado/1,
	contenedor/1,
	objeto_en_mano/1,
	mi_agarrable/1,
	ubicación/1.

:- discontiguous 
	tomar/1,
	puerta/2,
	requiere_llave2/2,
	puerta_abierta2/2.
	
%%%%%%- Ubicacion actual -%%%%%%
	ubicación(pasillo1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%- Abrir un objeto -%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-Habitación o inventario-%%%%%%%%%

	/*1*/abrir(Objeto) :- newWrite,
								not(habitación(Objeto)),
								contenedor(Objeto,_),
								disponible(Objeto),
								not(locación(ObjetoAdentro,Objeto)),
								abierto(Objeto),
								appendWrite('El/La '),
								appendWrite(Objeto),
								appendWrite(' ya se encuentra abierto.').

	/*1*/abrir(Objeto) :- newWrite,
								not(habitación(Objeto)),
								 contenedor(Objeto,_),
								 disponible(Objeto),
								 locación(_,Objeto),
								 abierto(Objeto),
								 appendWrite('El/La '),
								 appendWrite(Objeto),
								 appendWrite(' ya se encuentra abierto.'),
								 appendWrite(' Dentro de él puedes ver: '),nlW,!,
								 locación(X,Objeto),
								 imprimir_objeto(X).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-2-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*2*/abrir(Objeto) :- newWrite,
								not(habitación(Objeto)),
								 not(contenedor(Objeto,_)),
								 disponible(Objeto),
								 appendWrite('Te preguntas el por qué estás intentando abrir un/una '),
								 appendWrite(Objeto),
								 appendWrite(', es ilógico.').
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-3-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*3*/abrir(Objeto) :- newWrite,
								not(habitación(Objeto)),
								 contenedor(Objeto,_),
								 disponible(Objeto),
								 not(locación(ObjetoAdentro,Objeto)),
								 not(abierto(Objeto)),
								 asserta(abierto(Objeto)),
								 appendWrite('Abriste el/la '),
								 appendWrite(Objeto),
								 appendWrite(' pero no encuentras nada dentro de ella.').
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-4-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*4*/abrir(Objeto) :- newWrite,
								not(habitación(Objeto)),
								 contenedor(Objeto,_),
								 disponible(Objeto),
								 locación(_,Objeto),
								 not(abierto(Objeto)),
								 asserta(abierto(Objeto)),
								 appendWrite('Abriste el/la '),
								 appendWrite(Objeto),
								 appendWrite(', dentro de ella puedes ver:'), nlW,!,
								 locación(X,Objeto),
								 imprimir_objeto(X).
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-5-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*5*/abrir(Objeto) :- newWrite,
								 not(disponible(Objeto)),
								 not(habitación(Objeto)),
								 appendWrite('No encuentras ningún '),
								 appendWrite(Objeto),
								 appendWrite(' para intentar abrir').
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*2*/abrir(Habitación) :- newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación, Habitación),
									%puerta(Ubicación, Habitación),
									not(puerta_abierta(Ubicación, Habitación)),
									abierto(Ubicación, Habitación),
									appendWrite('La puerta hacia el/la '),
									appendWrite(Habitación),
									appendWrite(' ya se encuentra abierto').
	/*3*/abrir(Habitación) :- newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación, Habitación),
									%not puerta(Ubicación, Habitación),
									puerta_abierta(Ubicación, Habitación),
									appendWrite('No existe ninguna puerta hacia el/la '),
									appendWrite(Habitación),
									appendWrite(' para abrir').
	/*4*/abrir(Habitación) :- newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación, Habitación),
									%puerta(Ubicación, Habitación),
									not(puerta_abierta(Ubicación, Habitación)),
									not(abierto(Ubicación, Habitación)),
									not(requiere_llave(Ubicación, Habitación)), %%???????????????%%%??????????
									asserta(abierto2(Ubicación, Habitación)),
									appendWrite('Abriste la puerta hacia el/la '),
									appendWrite(Habitación).

%%%%%%%%%%%%%%%%%%%%%%%%%%- Puertas especiales (llave) -%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*5*/abrir(Habitación) :- newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación, Habitación),
									%puerta(Ubicación, Habitación),
									not(puerta_abierta(Ubicación, Habitación)),
									not(abierto(Ubicación, Habitación)),
									requiere_llave(Ubicación, Habitación),
									not(tiene_llave),
									appendWrite('La puerta está cerrada con llave, no tienes ningúna llave').
	/*5*/abrir(Habitación) :- newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación, Habitación),
									%puerta(Ubicación, Habitación),
									not(puerta_abierta(Ubicación, Habitación)),
									not(abierto(Ubicación, Habitación)),
									requiere_llave(Ubicación, Habitación),
									tiene_llave,
									not(llave_correcta(Habitación)),
									appendWrite('No tienes la llave correcta').
	/*5*/abrir(Habitación) :- newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación, Habitación),
									%puerta(Ubicación, Habitación),
									not(puerta_abierta(Ubicación, Habitación)),
									not(abierto(Ubicación, Habitación)),
									requiere_llave(Ubicación, Habitación),
									tiene_llave,
									llave_correcta(Habitación),
									asserta(abierto2(Ubicación, Habitación)),
									appendWrite('Abriste la puerta hacia el/la'),
									appendWrite(Habitación).
	/*6*/abrir(Habitación) :- newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									not(ubicación(Habitación)),
									ubicación(Ubicación),
									not(conecta_con(Ubicación, Habitación)),
									appendWrite('Esa habitación se encuentra lejos de donde estás ahora').
	/*7*/abrir(Habitación) :- newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									ubicación(Habitación),
									appendWrite('Indica la puerta de una habitación a tu alrrededor para abirir').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%- Cerrar un objeto -%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-Habitación o inventario-%%%%%%%%%
	/*1*/cerrar(Objeto) :-newWrite,
									not(habitación(Objeto)),
									contenedor(Objeto,_),
									disponible(Objeto),
									not(abierto(Objeto)),
									appendWrite('El/La '),
									appendWrite(Objeto),
									appendWrite(' ya se encuentra cerrado.').
	/*2*/cerrar(Objeto) :-newWrite,
									not(habitación(Objeto)),
									contenedor(Objeto,_),
									disponible(Objeto),
									abierto(Objeto),
									retract(abierto(Objeto)),
									appendWrite('Cerraste la '),
									appendWrite(Objeto).
	/*3*/cerrar(Objeto) :-newWrite,
									not(habitación(Objeto)),
									not(contenedor(Objeto,_)),
									disponible(Objeto),
									appendWrite('Creo que estás confundiendo el concepto de "cerrar"').
	/*4*/cerrar(Objeto) :-newWrite,
									not(habitación(Objeto)),
									not(contenedor(Objeto,_)),
									not(disponible(Objeto)),
									appendWrite('No encuentras ningún '),
									appendWrite(Objeto),
									appendWrite(' para intentar cerrar').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%- Cerrar habitación -%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*1*/cerrar(Habitación) :-newWrite,
									habitación(Habitación),
									not(contenedor(Habitación,_)),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación,Habitación),
									puerta_abierta(Ubicación,Habitación),
									appendWrite('No existe ningúna puerta hacia el/la '),
									appendWrite(Habitación),
									appendWrite(' para cerrar').
	/*2*/cerrar(Habitación) :-newWrite,
									habitación(Habitación),
									not(contenedor(Habitación,_)),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación,Habitación),
									not(puerta_abierta(Ubicación,Habitación)),
									not(abierto(Ubicación,Habitación)),
									appendWrite('La puerta hacia el/la '),
									appendWrite(Habitación),
									appendWrite(' ya se encuentra cerrada').
	/*3*/cerrar(Habitación) :-newWrite,
									habitación(Habitación),
									not(contenedor(Habitación,_)),
									not(disponible(Habitación)),
									not(ubicación(Habitación)),
									ubicación(Ubicación),
									not(conecta_con(Ubicación,Habitación)),
									appendWrite('Ese lugar está muy lejos').
	/*4*/cerrar(Habitación) :-newWrite,
									habitación(Habitación),
									not(contenedor(Habitación,_)),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación,Habitación),
									not(puerta_abierta(Ubicación,Habitación)),
									abierto(Ubicación,Habitación),
									retractabierto(Ubicación,Habitación),
									appendWrite('Cerraste la puesta hacia el/la '),
									appendWrite(Habitación).
	/*5*/cerrar(Habitación) :-newWrite,
									habitación(Habitación),
									not(contenedor(Habitación,_)),
									not(disponible(Habitación)),
									ubicación(Habitación),
									appendWrite('Indica la puerta de una habitación a tu alrrededor para cerrar').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- ubicación actual, conexiones y cosas en la ubicación actual -%%%%%%
	ver:-
		write('Se ejecutó "ver"'),
		newWrite,
		ubicación(X),
		not(apagado(X)),
		appendWrite('Te encuentras en la '),
		appendWrite(X), nlW, appendWrite('Puedes ver: '), nlW,
		listar_objetos(X),
		nlW,appendWrite('Las habitaciones a tu alrededor son:'), nlW,
		listar_conexiones(X),
		write('Termino de ejecución de "ver"').
	ver:-
		newWrite,
		ubicación(X),
		apagado(X),
		appendWrite('Te encuentras en la '),
		appendWrite(X), nlW,
		appendWrite('No puedes ver nada porque la luz está apagada'), nlW,
		appendWrite('Las habitaciones a tu alrededor son:'), nlW,
		listar_conexiones(X).
	verApp:- 
		ubicación(X),
		not(apagado(X)),
		appendWrite('Te encuentras en la '),
		appendWrite(X), nlW, appendWrite('Puedes ver: '), nlW,
		listar_objetos(X),
		nlW,appendWrite('Las habitaciones a tu alrededor son:'), nlW,
		listar_conexiones(X).
	verApp:-
		ubicación(X),
		apagado(X),
		appendWrite('Te encuentras en la '),
		appendWrite(X), nlW,
		appendWrite('No puedes ver nada porque la luz está apagada'), nlW,
		appendWrite('Las habitaciones a tu alrededor son:'), nlW,
		listar_conexiones(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- Mover al personaje a otra habitación -%%%%%%
	%Mover de ubicación y actualizar estado
		ir_a(Lugar):-newWrite,
							puede_ir(Lugar),
							mover(Lugar),
							verApp.


	%Verifica si la ubicación está conectada para poder ir
		/*1*/puede_ir(Algo):-
								not(habitación(Algo)),
								not(disponible(Algo)),
								appendWrite('No encuentras ese lugar'),
								nlW,fail.
		/*2*/puede_ir(Objeto):-
								not(habitación(Objeto)),
								disponible(Objeto),
								appendWrite('No puedes ir dentro de los objetos... Por ahora'),
								nlW,fail.
		/*3*/puede_ir(Habitación):-
								habitación(Habitación),
								not(disponible(Habitación)),
								not(ubicación(Habitación)),
								ubicación(X),
								not(conecta_con(X,Habitación)),
								appendWrite('No puedes ir ahí desde aqui'),
								nlW,fail.
		/*4*/puede_ir(Habitación):-
								habitación(Habitación),
								not(disponible(Habitación)),
								ubicación(Habitación),
								appendWrite('Ya te encuentras en la '),
								appendWrite(Habitación),
								nlW,fail.
		/*5*/puede_ir(Habitación):-
								habitación(Habitación),
								not(disponible(Habitación)),
								ubicación(X),
								conecta_con(X,Habitación),
								puerta_abierta(X,Habitación).
		/*5*/puede_ir(Habitación):-
								habitación(Habitación),
								not(disponible(Habitación)),
								ubicación(X),
								conecta_con(X,Habitación),
								not(puerta_abierta(X,Habitación)),
								abierto(X,Habitación).
		/*5*/puede_ir(Habitación):-
								habitación(Habitación),
								not(disponible(Habitación)),
								ubicación(X),
								conecta_con(X,Habitación),
								not(puerta_abierta(X,Habitación)),
								not(abierto(X,Habitación)),
								appendWrite('Te acabas de darte un golpe contra la puerta, creo que sería mejor si intentaras abrirla primero'),
								nlW,fail.



	%elimina la ubicación actual y crea una nueva con el lugar indicado
		mover(Lugar):-
								ubicación(X),
								retract(ubicación(X)),
								asserta(ubicación(Lugar)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- Tomar algún objeto que se encuentre en la habitación -%%%%%%
	tomar(Objeto):-newWrite,
		puede_tomar(Objeto), %comprueba que sea un objeto válido
		puede_agarrar(Objeto), %comprueba que tengas espacio en el inventario
		appendWrite('tomaste el objeto').

%%%%%%%-puede tomar-%%%%%%%
		/*1*/puede_tomar(Algo):-
								not(agarrable(Algo)),
								not(habitación(Algo)),
								not(disponible(Algo)),
								appendWrite('No encuentras ese objeto para tomar'),
								nlW,fail.
		/*2*/puede_tomar(Habitación):-
								not(agarrable(Habitación)),
								habitación(Habitación),
								not(disponible(Habitación)),
								not(ubicación(Habitación)),
								not(conecta_con(X,Habitación)),
								appendWrite('No alcanzas ese lugar para tomar... y de todos modos no puedes tomar una habitación entera.'),
								nlW,fail.
		/*3*/puede_tomar(Habitación):-
								not(agarrable(Habitación)),
								habitación(Habitación),
								not(disponible(Habitación)),
								ubicación(Habitación),
								appendWrite('wow, estás intentado tomar la habitación entera en donde te encuentras... crearías una paradoja.'),
								nlW,fail.
		/*3*/puede_tomar(Habitación):-
								not(agarrable(Habitación)),
								habitación(Habitación),
								not(disponible(Habitación)),
								not(ubicación(Habitación)),
								ubicación(X),
								conecta_con(X,Habitación),
								tab(5), appendWrite('Imagina que estás al lado de una habitación...'),nlW,
								tab(5), appendWrite('en esa habitación hay muchos objetos valiosos para ti,'),nlW,
								tab(5), appendWrite('las paredes y el suelo te parecen hermosos, así como la iluminación,'),nlW,
								tab(5), appendWrite('entonces piensas, ¿por qué no llevarme toda la habitación entera, con sus objetos, paredes, el suelo, el techo, etc...?'),nlW,
								tab(5), appendWrite('La tomas entera y la metes en tu bolsillo'),nlW,
								tab(5), appendWrite('¿Te parece algo lógico?'), tab(7), appendWrite('(Responde con un "si." o "no.") :') ,nlW,
								read(R), respuesta_tomar_habitación(R), nlW, fail.
								respuesta_tomar_habitación(R):- R==si, appendWrite('Oh, si eso te parece lógico entonces está bien, ten, toma toda la habitación entera y colocala en tu bolsillo...'),
								nlW, appendWrite('Si claro, graciosito.').
								respuesta_tomar_habitación(R):- R==no, appendWrite('Eso pense... Ahora deja de hacerte el gracioso e intenta tomar algo más lógico.').
								respuesta_tomar_habitación(R):- R\== si, R\== no, appendWrite('No seguiré hablandole a alguien que no sabe ni responder una simple pregunta...').

		/*4*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitación(Objeto)),
								not(contenedor(Objeto,_)),
								ubicación(X),
								not(se_puede_ver(Objeto,X)),
								mis_objetos(Objeto),
								appendWrite('Ya has tomado éste objeto...'),
								nlW,fail.
		/*&4*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitación(Objeto)),
								not(contenedor(Objeto,_)),
								not(mis_objetos(Objeto)),
								ubicación(X),
								se_puede_ver(Objeto,X),
								objeto(Objeto, color(_), tamaño(pequeño), peso(P)),
								P<5.
		/*5*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitación(Objeto)),
								not(contenedor(Objeto,_)),
								not(mis_objetos(Objeto)),
								ubicación(X),
								se_puede_ver(Objeto,X),
								objeto(Objeto, color(_), tamaño(pequeño), peso(P)),
								P>5,
								appendWrite('Este objeto es muy pesado para ti'),
								nlW,fail.
		/*6*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitación(Objeto)),
								not(contenedor(Objeto)),
								not(mis_objetos(Objeto)),
								ubicación(X),
								se_puede_ver(Objeto,X),
								objeto(Objeto, color(_), tamaño(Tamaño), peso(P)),
								Tamaño \== pequeño,
								P<5,
								appendWrite('Este objeto es muy grande para ti'),
								nlW,fail.
		/*7*/puede_tomar(Objeto):-
								not(agarrable(Objeto)),
								not(habitación(Objeto)),
								not(contenedor(Objeto,_)),
								not(mis_objetos(Objeto)),
								ubicación(X),
								se_puede_ver(Objeto,X),
								objeto(Objeto, color(_), tamaño(Tamaño), peso(P)),
								Tamaño \== pequeño,
								P>5,
								appendWrite('Este objeto es muy grande y pesado para ti.'),
								nlW,fail.
		/*8*/puede_tomar(Agarrable):-
								agarrable(Agarrable),
								not(habitación(Agarrable)),
								not(mis_objetos(Agarrable)),
								ubicación(X),
								se_puede_ver(Agarrable,X).

		/*9*/puede_tomar(Contenedor):-
								contenedor(Contenedor,_),
								not(agarrable(Contenedor)),
								not(habitación(Contenedor)),
								not(mis_objetos(Contenedor)),
								ubicación(X),
								se_puede_ver(Contenedor,X),
								appendWrite('No puedes tomar éste contendor'),nlW,fail.

		%%%%%%- Comprueba que tengas espacio en tu inventario o agarrable que tengas -%%%%%
		/*1*/ puede_agarrar(Objeto) :-
										not(contenedor(Objeto,_)),
										not(mi_agarrable(_)),
										not(objeto_en_mano(_)),
										retract(locación(Objeto,_)),
										asserta(objeto_en_mano(Objeto)).

		/*2*/ puede_agarrar(Objeto) :-
										not(contenedor(Objeto,_)),
										not(mi_agarrable(_)),
										objeto_en_mano(_),
										appendWrite('No puedes tomar éste objeto porque ya estás cargando un objeto y no tienes dónde más colocarlo :P'),
										nlW,fail.
		/*3*/ puede_agarrar(Objeto) :-
										not(contenedor(Objeto,_)),
										mi_agarrable(Contenedor),
										not(lleno(Contenedor)),
										retract(locación(Objeto,_)),
										asserta(locación(Objeto,Contenedor)).
		/*4*/ puede_agarrar(Objeto) :- %Si no puedo quitar el objeto de la mano esta es una posibilidad inecesaria
										not(contenedor(Objeto,_)),
										mi_agarrable(Contenedor),
										lleno(Contenedor),
										not(objeto_en_mano(_)),
										retract(locación(Objeto,_)),
										asserta(objeto_en_mano(Objeto)).
		/*5*/ puede_agarrar(Objeto) :-
										not(contenedor(Objeto,_)),
										mi_agarrable(Contenedor),
										lleno(Contenedor),
										objeto_en_mano(_),
										appendWrite('No puedes tomar el objeto, tu contenedor está lleno y ya llevas un objeto en la mano'),
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
										retract(locación(Agarrable,_)),
										asserta(mi_agarrable(Agarrable)),
										appendWrite('Ahora puedes tener '),
										appendWrite(Lim),
										appendWrite(' cosas más en tu inventario.'),
										nlW,fail.

		/*8*/ puede_agarrar(Contenedor) :- %???????????? conbinar con grande y pesado agregando contenedores
										contenedor(Contenedor,_),
										not(agarrable(Contenedor)),
										appendWrite('No puedes llevar contigo éste contenedor'),
										nlW,fail.



		%%%%%%- Elimina la locación del objeto y coloca el objeto en tu inventario- %%%%%
		%agarrar(Objeto) :-
		%						%ubicación(X),
		%						retract(locación(Objeto,_)),
		%						asserta(mis_objetos(Objeto)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- Dejar un objeto que tengas en el inventario -%%%%%%
	soltar(Objeto):-newWrite,
		puede_soltar(Objeto),
		dejar(Objeto),
		appendWrite('Acabas de soltar el objeto en el suelo...').
%%%%%%%-puede soltar-%%%%%%%
		/*1*/puede_soltar(Habitación):-
								not(mi_agarrable(Algo)),
								habitación(Habitación),
								not(disponible(Habitación)),
								appendWrite('Por lo menos intenta tomar la habitación primero...'),
								nlW,fail.
		/*1*/puede_soltar(Algo):-
								not(mi_agarrable(Algo)),
								not(habitación(Algo)),
								not(disponible(Algo)),
								appendWrite('No tienes ningún objeto llamado '),
								appendWrite(Algo),
								nlW,fail.
		/*2*/puede_soltar(Objeto):-
								not(mi_agarrable(Algo)),
								not(habitación(Objeto)),
								not(mis_objetos(Objeto)),
								ubicación(X),
								se_puede_ver(Objeto,X),
								appendWrite('Debes de tener el objeto primero.'),
								nlW,fail.
		/*3*/puede_soltar(Objeto):-
								not(mi_agarrable(Objeto)),
								not(habitación(Objeto)),
								mis_objetos(Objeto),
								ubicación(X),
								not(se_puede_ver(Objeto,X)) ,nlW.
		/*4*/puede_soltar(Agarrable):-
								not(habitación(Agarrable)),
								mi_agarrable(Agarrable),
								nlW.


		%%%%%%- elimina la locación del inventario y la coloca en la ubicación -%%%%%
		dejar(Objeto) :-
							objeto_en_mano(Objeto),
							ubicación(X),
							retract(objeto_en_mano(Objeto)),
							asserta(locación(Objeto,X)).
		dejar(Objeto) :-
							mi_agarrable(Contenedor),
							locación(Objeto,Contenedor),
							ubicación(X),
							retract(locación(Objeto,Contenedor)),
							asserta(locación(Objeto,X)).
		dejar(Agarrable) :-
							mi_agarrable(Agarrable),
							ubicación(X),
							retract(mi_agarrable(Agarrable)),
							asserta(locación(Agarrable,X)).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%- Inventario -%%%%%%%%%%%%%%%
	inventario :-newWrite,
					imprimir_objeto_en_mano,
					imprimir_agarrable.
	imprimir_objeto_en_mano :-
									objeto_en_mano(X),
									tab(4),appendWrite('Tienes un/una '),nlW,
									tab(4),appendWrite(X),
									tab(4),appendWrite(' en la mano'),nlW.
	imprimir_objeto_en_mano :-
									not(objeto_en_mano(_)),
									tab(4),appendWrite('No llevas ningún objeto en la mano'),nlW.
	imprimir_agarrable :-
									mi_agarrable(X),
									not(locación(_,X)),
									tab(4), appendWrite('Llevas contigo una '),appendWrite(X),nlW,
									tab(4), appendWrite('Pero dentro de ella no tienes objetos ahora').
	imprimir_agarrable :-
									mi_agarrable(X),
									locación(_,X),
									tab(4), appendWrite('Llevas contigo una '),appendWrite(X),nlW,
									tab(4), appendWrite('Dentro de ella se encuentran:'),nlW,!,
									locación(Cosas,X),
									imprimir_objeto(Cosas).
	imprimir_agarrable :-
									not(mi_agarrable(_)),
									tab(4),appendWrite('Y no llevas algún contenedor contigo para guardar más objetos.'),nlW.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%- Comer un objeto que tengas en el inventario -%%%%%%
	comer(Objeto):-newWrite,
		puede_comer(Objeto),
		ingerir(Objeto).

		/*1*/puede_comer(Algo):-
										not(habitación(Algo)),
										not(disponible(Algo)),
										appendWrite('No encuentras ese objeto para intentar comer'),
										nlW,fail.
		/*2*/puede_comer(Habitación):-
										habitación(Habitación),
										not(disponible(Habitación)),
										appendWrite('No, no puedes comerte las habitaciones...'),
										nlW,fail.
		/*3*/puede_comer(Objeto):-
										not(habitación(Objeto)),
										not(mis_objetos(Objeto)),
										ubicación(X),
										se_puede_ver(Objeto,X),
										not(comida(Objeto, sabor(_), estado(_))),
										appendWrite('No tienes ese objeto... además que ni siquiera se puede comer .-.'),
										nlW,fail.
		/*4*/puede_comer(Objeto):-
										not(habitación(Objeto)),
										not(mis_objetos(Objeto)),
										ubicación(X),
										se_puede_ver(Objeto,X),
										comida(Objeto, sabor(_), estado(_)),
										appendWrite('Debes de tomar primero la comida.'),
										nlW,fail.
		/*5*/puede_comer(Objeto):-
										not(habitación(Objeto)),
										mis_objetos(Objeto),
										ubicación(X),
										not(se_puede_ver(Objeto,X)),
										not(comida(Objeto, sabor(_), estado(_))),
										appendWrite('Este objeto no se puede comer'),
										nlW,fail.
		/*6*/puede_comer(Objeto):-
										not(habitación(Objeto)),
										mis_objetos(Objeto),
										ubicación(X),
										not(se_puede_ver(Objeto,X)),
										comida(Objeto, sabor(normal), estado(_)),
										appendWrite('Has comido el objeto, su sabor te pareció indiferente.'),nlW.
		/*6*/puede_comer(Objeto):-
										not(habitación(Objeto)),
										mis_objetos(Objeto),
										ubicación(X),
										not(se_puede_ver(Objeto,X)),
										comida(Objeto, sabor(rico), estado(_)),
										appendWrite('Has comido el objeto, su sabor te pareció muy bueno, ahora eres muy feliz :D'),nlW.
		/*7*/puede_comer(Objeto):-
										not(habitación(Objeto)),
										mis_objetos(Objeto),
										ubicación(X),
										not(se_puede_ver(Objeto,X)),
										comida(Objeto, sabor(_), estado(crudo)),
										appendWrite('No pudes comer eso proque está crudo.'),
										nlW,fail.
		/*7*/puede_comer(Objeto):-
										not(habitación(Objeto)),
										mis_objetos(Objeto),
										ubicación(X),
										not(se_puede_ver(Objeto,X)),
										not(comida(Objeto, sabor(_), estado(crudo))),
										comida(Objeto, sabor(feo), estado(_)),
										appendWrite('No quieres comer eso D:'),
										nlW,fail.




		%%%%%%- elimina el objeto del inventario -%%%%%
		ingerir(Objeto) :-
								objeto_en_mano(Objeto),
								ubicación(X),
								retract(objeto_en_mano(Objeto)),
								asserta(locación(Objeto,X)).
		ingerir(Objeto) :-
								mi_agarrable(Contenedor),
								locación(Objeto,Contenedor),
								ubicación(X),
								retract(locación(Objeto,Contenedor)),
								asserta(locación(Objeto,X)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%- Dejar un objeto sobre o dentro de otro objeto -%%%%%%
	soltar_en(Objeto,Apilador):-newWrite,
		puede_soltar_en(Objeto,Apilador),
		dejar_en(Objeto,Apilador).

				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				dejar_en(Objeto,Apilador) :-
												objeto_en_mano(Objeto),
												retract(objeto_en_mano(Objeto)),
												asserta(locación(Objeto,Apilador)).
				dejar_en(Objeto,Apilador) :-
												mi_agarrable(Contenedor),
												locación(Objeto,Contenedor),
												retract(locación(Objeto,Contenedor)),
												asserta(locación(Objeto,Apilador)).
				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		/*1*/puede_soltar_en(Cosa,NoImporta) :-
										not(habitación(Cosa)),
										not(disponible(Cosa)),
										appendWrite('No encuentras ese objeto para intentar soltar'),
										nlW,fail.
		/*2*/puede_soltar_en(Objeto,NoImporta) :-
										not(habitación(Objeto)),
										disponible(Objeto),
										not(mis_objetos(Objeto)),
										appendWrite('Debes de tomar el objeto primero'),
										nlW,fail.
		/*3*/puede_soltar_en(Habitación,NoImporta) :-
										habitación(Habitación),
										appendWrite('No puedes dejar la habitación porque no la tienes, y porque sería ilógico'),
										nlW,fail.
		/*4*/puede_soltar_en(Objeto,Cosa) :-
										mis_objetos(Objeto),
										not(habitación(Cosa)),
										not(disponible(Cosa)),
										appendWrite('No encuentras ese lugar para dejar el objeto'),
										nlW,fail.
		/*5*/puede_soltar_en(Objeto,Inventario) :-
										mis_objetos(Objeto),
										not(habitación(Inventario)),
										disponible(Inventario),
										mis_objetos(Inventario),
										appendWrite('Intentaste colocar un objeto de tu inventario en otra cosa de tu inventario...'),
										nlW,fail.
		/*6*/puede_soltar_en(Objeto,MismoObjeto) :-
										mis_objetos(Objeto),
										not(habitación(MismoObjeto)),
										mis_objetos(MismoObjeto),
										Objeto == MismoObjeto,
										appendWrite('Creaste una paradoja'),
										nlW,fail.
		/*&7*/puede_soltar_en(Objeto,Habitación) :-
										mis_objetos(Objeto),
										habitación(Habitación),
										ubicación(Habitación),
										appendWrite('Colocaste el objeto en el suelo'),nlW.
		/*8*/puede_soltar_en(Objeto,Habitación) :-
										mis_objetos(Objeto),
										habitación(Habitación),
										not(ubicación(Habitación)),
										appendWrite('No puedes dejar ese objeto en esa habitación porque no te encuentras en ella'),
										nlW,fail.
		/*9*/puede_soltar_en(Objeto,OtroObjeto) :-
										mis_objetos(Objeto),
										not(habitación(OtroObjeto)),
										ubicación(X),
										se_puede_ver(OtroObjeto,X),
										not(contenedor(OtroObjeto,_)),
										not(apilador(OtroObjeto)),
										appendWrite('No puedes soltar en éste objeto'),
										nlW,fail.
		/*10-1-1*/puede_soltar_en(Objeto,OtroObjeto) :- %%Si aún existe espacio en el contenedor
										mis_objetos(Objeto),  %%El contenedor NO se  encuentra abierto
										not(habitación(OtroObjeto)),
										ubicación(X),
										se_puede_ver(OtroObjeto,X),
										contenedor(OtroObjeto,_),
										not(apilador(OtroObjeto)),
										not(lleno(OtroObjeto)), %-<<<<
										not(abierto(OtroObjeto)), %Solo entra hasta aquí si el objeto se puede ver, y si se puede ver significa que sus contenedores padres ya están abiertos, por lo que solo verificamos dónde se colocará el objeto
										not(contenedores_abiertos(OtroObjeto)),
										appendWrite('No puedes colocar dentro de éste contenedor porque se encuentra cerrado'),
										nlW,fail.
		/*&10-1-2*/puede_soltar_en(Objeto,OtroObjeto) :- %%Si aún existe espacio en el contenedor
										mis_objetos(Objeto),  %%El contenedor se encuentra abierto
										not(habitación(OtroObjeto)),
										ubicación(X),
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
		/*10-2*/puede_soltar_en(Objeto,OtroObjeto) :- %%Si ya No cabe nada más en el contenedor
										mis_objetos(Objeto),
										not(habitación(OtroObjeto)),
										ubicación(X),
										se_puede_ver(OtroObjeto,X),
										contenedor(OtroObjeto,_),
										not(apilador(OtroObjeto)),
										lleno(OtroObjeto), %-<<<<
										appendWrite('El contenedor está lleno'),nlW,
										%appendWrite(Objeto),
										%appendWrite(' Dentro de el/la '),
										%appendWrite(OtroObjeto),
										fail,nlW.
		/*&11*/puede_soltar_en(Objeto,OtroObjeto) :-
										mis_objetos(Objeto),
										not(habitación(OtroObjeto)),
										ubicación(X),
										se_puede_ver(OtroObjeto,X),
										not(contenedor(OtroObjeto,_)),
										apilador(OtroObjeto),
										appendWrite('Colocaste el/la '),
										appendWrite(Objeto),
										appendWrite(' sobre el/la '),
										appendWrite(OtroObjeto),
										nlW.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


	encender_luz :-newWrite,
						ubicación(X),
						not(apagado(X)),
						appendWrite('La luz ya está encendida'),
						fail.
	encender_luz :-newWrite,
						ubicación(X),
						apagado(X),
						retract(apagado(X)),
						appendWrite('Convenientemente el switch lo puedes ver y está a tu alcance, así que enciendes la luz').

	apagar_luz :-newWrite,
						ubicación(X),
						not(apagado(X)),
						asserta(apagado(X)),
						appendWrite('Convenientemente el switch lo puedes alcanzar, así que apagas la luz').

	apagar_luz :-newWrite,
						ubicación(X),
						apagado(X),
						appendWrite('La luz ya está apagada'),
						fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	colocar_en_mano(Objeto) :-newWrite,
									not(mis_objetos(Objeto)),
									puede_tomar(Objeto),
									colocar_en_mano_habitación(Objeto).
	colocar_en_mano(Objeto) :-newWrite,
									mis_objetos(Objeto),
									colocar_en_mano_inventario(Objeto).

	/*2*/colocar_en_mano_habitación(Objeto) :-
									not(objeto_en_mano(_)),
									ubicación(X),
									se_puede_ver(Objeto,X),
									not(agarrable(Objeto)),
									puede_tomar(Objeto),
									asserta(objeto_en_mano(Objeto)),
									retract(locación(Objeto,_)),
									appendWrite('Colocaste el objeto en tu mano').
	/*2.1*/colocar_en_mano_habitación(Objeto) :-
									objeto_en_mano(_),
									ubicación(X),
									se_puede_ver(Objeto,X),
									not(agarrable(Objeto)),
									puede_tomar(Objeto),
									appendWrite('Sólo puedes tener un objeto en la mano'),
									nlW,fail.
	/*2.2*/colocar_en_mano_habitación(Agarrable) :-
									ubicación(X),
									se_puede_ver(Agarrable,X),
									agarrable(Agarrable),
									appendWrite('No puedes llevar un contenedor en la mano, será mejor que lo cuelges contigo (tomar(Objeto))'),
									nlW,fail.

	/*3*/colocar_en_mano_inventario(Objeto) :-
									objeto_en_mano(Objeto),
									appendWrite('Ese objeto ya se encuentra en tu mano'),
									nlW,fail.
	/*4*/colocar_en_mano_inventario(Objeto) :-
									mi_agarrable(Contenedor),
									locación(Objeto,Contenedor),
									not(objeto_en_mano(_)),
									retract(locación(Objeto,Contenedor)),
									asserta(objeto_en_mano(Objeto)),
									appendWrite('Colocaste en tu mano el objeto que tenías en tu mochila').
	/*5*/colocar_en_mano_inventario(Objeto) :-
									mi_agarrable(Contenedor),
									locación(Objeto,Contenedor),
									objeto_en_mano(Objeto2),
									retract(locación(Objeto,Contenedor)),
									retract(objeto_en_mano(Objeto2)),
									asserta(objeto_en_mano(Objeto)),
									asserta(locación(Objeto2,Contenedor)),
									appendWrite('Guardaste el/la '), appendWrite(Objeto2), appendWrite(' que tenías en la mano'),nlW,
									appendWrite('y colocaste el/la '),appendWrite(Objeto),appendWrite( 'en tu mano'),nlW.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	guardar_en_mochila(Objeto):-newWrite,
									not(mis_objetos(Objeto)),
									puede_tomar(Objeto),
									tiene_mochila,
									guardar_en_mochila_habitación(Objeto).
	guardar_en_mochila(Objeto):-newWrite,
									mis_objetos(Objeto),
									tiene_mochila,
									guardar_en_mochila_inventario(Objeto).

	tiene_mochila :- mi_agarrable(_).
	tiene_mochila :- not(mi_agarrable(_)), appendWrite('No tienes ningún contenedor en donde colocar el objeto'),nlW,fail.

	/*1*/guardar_en_mochila_habitación(Objeto) :-
									mi_agarrable(Contenedor),
									not(lleno(Contenedor)),
									retract(locación(Objeto,_)),
									asserta(locación(Objeto,Contenedor)),
									appendWrite('Tomaste el objeto y lo colocaste en tu mochila').
	/*2*/guardar_en_mochila_habitación(Objeto) :-
									mi_agarrable(Contenedor),
									lleno(Contenedor),
									appendWrite('No tienes espacio suficiente en tu mochila'),
									nlW,fail.
	/*3*/guardar_en_mochila_inventario(Objeto) :-
									objeto_en_mano(Objeto),
									mi_agarrable(Contenedor),
									not(lleno(Contenedor)),
									retract(objeto_en_mano(_)),
									asserta(locación(Objeto,Contenedor)),
									appendWrite('Dejaste el objeto que tenías en la mano en tu mochila').
	/*4*/guardar_en_mochila_inventario(Objeto) :-
									objeto_en_mano(Objeto),
									mi_agarrable(Contenedor),
									lleno(Contenedor),
									appendWrite('No tienes espacio suficiente en tu mochila'),
									nlW,fail.
	/*4*/guardar_en_mochila_inventario(Objeto) :-
									mi_agarrable(Contenedor),
									locación(Objeto,Contenedor),
									appendWrite('Este objeto ya se encuentra en tu mochila'),
									nlW,fail.










