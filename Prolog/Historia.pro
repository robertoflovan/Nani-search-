:- ensure_loaded([
				'Basico',
				'Cosas',
				'Habitaciones',
				'imprimir objetos',
				'Puertas',
				'comandosJugador',
				'Interfaz/respuestas',
				'Interfaz/Interfaz',
				'Interfaz/objetoDeterminante',
				'Interfaz/verbos']).
				
:- dynamic
	tutorial/1,
	pide_respuesta/1,
	abierto2/2,
	apagado/1,
	contenedor/1,
	objeto_en_mano/1,
	mi_agarrable/1,
	ubicación/1,
	salida_low/0,
	juego_cofre/0,
	conseguir_estambre/0.

:- discontiguous 
	tomar/1,
	puerta/2,
	requiere_llave2/2,
	puerta_abierta2/2,
	abrir/1.
	
empezar_juego :- 
				newWrite,
				retractall(tutorial(_)),
				retractall(pide_respuesta(_)),
				appendWrite('Lo&¡Hola!, me llamo "Lo", soy un pequeño perro y el mejor amigo de la niña, de la cual podrás tener completo control de sus movimientos, ella está pasando un mal momento y necesita la ayuda de cualquiera para guiarla hacia una muñeca llamada “Nani”% la cual la ayudará a librarse de todos los demonios que han estado atormentándola por mucho tiempo.%Te pido que por favor la ayudes, ella ya ha pasado por mucho, hace no mucho tiempo perdió su brazo izquierdo por culpa de uno de esos demonios que la persiguen, guíala  a encontrar a su muñeca encargándote de sus acciones.%Antes de comenzar, debo advertirte que el mundo lo verás a través de la mente imaginativa de la niña, por lo cual podrás toparte con algunas cosas un poco extrañas que ella ve, pero no te preocupes, estoy seguro que sabrás que hacer en cada situación.%El poder de tus palabras en ésta situación son bastante poderosas (más de lo que te imaginas), te pido que empieces a tomar el control de la niña recitando unas simples palabras: "tolle animam meam", ¿qué significan?... en realidad nada en especial, sólo tienen el poder para guiar a la niña.&&Consola&Prueba texto de consola'),	
				asserta(tutorial(1)),
				asserta(pide_respuesta(1)).
				
respuesta_pacto :-
					pide_respuesta(1),
					tutorial(1),
					newWrite,
					appendWrite('Lo&Bien, ahora tienes el control de la niña, las palabras digas ellas las escuchará y las ejecutará, puedes empezar por ver el mundo a través de mi niña pidiéndole que vea (ver), vamos, inténtalo ;D . '),
					retractall(tutorial(_)),
					retractall(pide_respuesta(_)),
					asserta(tutorial(2)),
					asserta(pide_respuesta(2)).
	
respuesta_ver :-	
					tutorial(2),
					pide_respuesta(2),
					asserta(ubicación(cocina)),
					newWrite,
					appendWrite('Consola&*Puedes ver a través de los ojos de la niña, observas que en donde te encuentras ahora mismo parece ser la cocina.%Tal y como dijo Low, al mirar a tu alrededor algunas cosas parecen un poco extrañas, como si viniesen de la imaginación de un niño alegre pero en ocasiones un toque tétrico, como animales que hacen movimientos extraños de los cuales algunos desaparecen sin explicación. Puedes ver algunos objetos que se encuentra ahí:'),
					nlW,
					listar_objetos(cocina),
					nlW,appendWrite('Las habitaciones a tu alrededor son:'), nlW,
					listar_conexiones(cocina),
					appendWrite('&&Lo&¡Bien!, ahora puedes ver lo que mi niña ve, es fácil ¿verdad?, así como le ordenaste que observara el entorno en donde se encuentra, puedes ordenar otras cosas que controlen algunos de sus movimientos o acciones, te proporcionaré una lista de algunas cosas que puedes hacer, usa estas acciones para ayudar a mi niña a encontrar su muñeca, debe estar en algún lugar de ésta casa:'),
					appendWrite('&&Consola&*La lista aparece en tu brazo derecho como si fuera una especie de extraño tatuaje, la miras y lees lo que tiene escrito:%“Acciones que puedes controlar, escrito por Low ;)”
	Ver
	Conocer el inventario que llevas
	Apagar la luz de la habitación
	Encender la luz de la habitación
	Abrir algún contenedor o una puerta
	Cerrar algún contenedor o una puerta
	Ir a algún lugar
	Tomar algún objeto
	Tirar algún objeto
	Comer algo
	Colocar en tu única mano algún objeto
	Guardar un objeto en una mochila
	Inspeccionar un objeto**
	Usar un objeto**
	Podrás ver esta lista pronunciando “ayuda” cuando quieras*'),
					retractall(tutorial(_)),
					retractall(pide_respuesta(_)),
					asserta(tutorial(3)),
					asserta(salida_low).
	
	
	ir_a(comedor):-	
					salida_low,
					tutorial(3),
					newWrite,
					appendWrite('Lo&No puedo permanecer si mi niña no está conciente. Te pido que la cuides y encuentres esa muñeca por su bien, en el momento que la tomes yo me ocuparé del resto.&&Consola&*Low a desaparecido ante ti*'),
					retractall(salida_low),
					asserta(juego_cofre).
	
	ir_a(Lugar):-
					tutorial(3),
					newWrite,
					puede_ir(Lugar),
					mover(Lugar),
					verApp.
					
	%En ésta parte se tendrá juego_cofre y tutorial(3)
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-3-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*3*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitación(Objeto)),
								contenedor(Objeto,_),
								not(juego_cofre),
								Objeto \== cofre_de_nani,
								
								disponible(Objeto),
								not(locación(ObjetoAdentro,Objeto)),
								not(abierto(Objeto)),
								asserta(abierto(Objeto)),
								appendWrite('Abriste el/la '),
								appendWrite(Objeto),
								appendWrite(' pero no encuentras nada dentro de ella.').
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-4-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*4*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitación(Objeto)),
								 contenedor(Objeto,_),
								 not(juego_cofre),
								 Objeto \== cofre_de_nani,
								 
								 disponible(Objeto),
								 locación(_,Objeto),
								 not(abierto(Objeto)),
								 asserta(abierto(Objeto)),
								 appendWrite('Abriste el/la '),
								 appendWrite(Objeto),
								 appendWrite(', dentro de ella puedes ver:'), nlW,!,
								 locación(X,Objeto),
								 imprimir_objeto(X).
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-3-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*3b*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitación(Objeto)),
								contenedor(Objeto,_),
								juego_cofre,
								Objeto \== cofre_de_nani,
								disponible(Objeto),
								not(locación(ObjetoAdentro,Objeto)),
								not(abierto(Objeto)),
								asserta(abierto(Objeto)),
								appendWrite('Abriste el/la '),
								appendWrite(Objeto),
								appendWrite(' pero no encuentras nada dentro de ella.').
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-4-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*4b*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitación(Objeto)),
								 contenedor(Objeto,_),
								 juego_cofre,
								 Objeto \== cofre_de_nani,
								 disponible(Objeto),
								 locación(_,Objeto),
								 not(abierto(Objeto)),
								 asserta(abierto(Objeto)),
								 appendWrite('Abriste el/la '),
								 appendWrite(Objeto),
								 appendWrite(', dentro de ella puedes ver:'), nlW,!,
								 locación(X,Objeto),
								 imprimir_objeto(X).
								 
								 					 
	abrir(cofre_de_nani) :-
					juego_cofre,
					tutorial(3),
					newWrite,
					appendWrite('400&Hola mi pequeña ;). Quieres la muñeca ¿no es así?, sería algo malo, tus padres la han confiscado por lo que puede hacer. De todas maneras, yo puedo ayudarte, podría entregarte la llave de ese cofre a cambio de unas cuántas cosas que me da pereza conseguir.%Si estás interesda puedes traerme una pequeña bola de estambre para entretenerme :D*&&Consola&*Consigue el estambre para 400*'),
					retractall(juego_cofre),
					asserta(conseguir_estambre).
					
	abrir(cofre_de_nani) :- % No tiene la llave
					not(juego_cofre),
					tutorial(3),
					newWrite,
					not(objeto_en_mano(llave_cofre)),
					not(abierto(cofre_de_nani)),
					appendWrite('Consola&*Necesitas una llave*').
					
	
					
					
	
	
	
	
	dar(estambre,400) :- %tiene el estambre
					tutorial(3),
					newWrite,
					conseguir_estambre,
					ubicación(X),
					X == comedor,
					objeto_en_mano(estambre),
					appendWrite('400&Muy bien, dejaré la llave por aquí, pero yo no tomaría esa muñeca ;)&&Consola&*400 ha dejado la llave en el suelo*'),
					retract(objeto_en_mano(estambre)),
					retractall(conseguir_estambre),
					asserta(locación(llave_cofre,comedor)).
					
	dar(estambre,400) :- %  NO tiene el estambre
					tutorial(3),
					newWrite,
					conseguir_estambre,
					ubicación(X),
					X == comedor,
					not(objeto_en_mano(estambre)),
					appendWrite('400&Vamos, no es una cosa tan difícil consegur una pequeña bola de estambre&&Consola&*Consigue el estambre para 400*').
	
	
	abrir(cofre_de_nani) :- % Tiene la llave
					not(juego_cofre),
					tutorial(3),
					newWrite,
					objeto_en_mano(llave_cofre),
					not(abierto(cofre_de_nani)),
					asserta(abierto(cofre_de_nani)),
					appendWrite('Consola&Abriste el cofre de Nani, dentro de el puedes ver 3 cajas:
	Una caja amarilla
	Una caja roja
	Una caja azul&&400&Vamos a hacer esto un poco más interesante, en una de esas cajas se encuentra esa muñeca que tanto buscas, tienes una oportunidad de seleccionar la correcta, puedes leer las pistas que tienen las cajas&&Consola&En cada una de las cajas hay una oración inscrita:
	caja amarilla : Nani no está en la caja roja
	caja roja: Nani no está en esta caja
	caja azul: Nani está en esta caja&&400&Por lo menos una de las tres oraciones es
verdadera y por lo menos una es falsa, suerte ;)').
	
	
	abrir(cofre_de_nani) :- % Tiene la llave
					not(juego_cofre),
					tutorial(3),
					newWrite,
					objeto_en_mano(llave_cofre),
					abierto(cofre_de_nani),
					appendWrite('400&Te explicaré otra vez, en una de esas cajas se encuentra esa muñeca que tanto buscas, tienes una oportunidad de seleccionar la correcta, puedes leer las pistas que tienen las cajas&&Consola&En cada una de las cajas hay una oración inscrita:
	caja amarilla : Nani no está en la caja roja
	caja roja: Nani no está en esta caja
	caja azul: Nani está en esta caja&&400&Por lo menos una de las tres oraciones es
verdadera y por lo menos una es falsa, suerte ;)'),
					retractall(tutorial(_)),
					asserta(tutorial(4)).
					
abrir(caja_amarilla) :-
					tutorial(4),
					newWrite,
					retractall(ubicación(_)),
					asserta(ubicación(hell)),
					appendWrite('Low2&Pequeño ingenuo').

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*1*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitación(Objeto)),
								contenedor(Objeto,_),
								
								
								disponible(Objeto),
								not(locación(ObjetoAdentro,Objeto)),
								abierto(Objeto),
								appendWrite('El/La '),
								appendWrite(Objeto),
								appendWrite(' ya se encuentra abierto.').
								
	/*1*/abrir(Objeto) :- tutorial(3),newWrite,
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
	/*2*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitación(Objeto)),
								 not(contenedor(Objeto,_)),
								 disponible(Objeto),
								 appendWrite('Te preguntas el por qué estás intentando abrir un/una '),
								 appendWrite(Objeto),
								 appendWrite(', es ilógico.').
								 
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-5-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*5*/abrir(Objeto) :- tutorial(3),newWrite,
								 not(disponible(Objeto)),
								 not(habitación(Objeto)),
								 appendWrite('No encuentras ningún '),
								 appendWrite(Objeto),
								 appendWrite(' para intentar abrir').
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*2*/abrir(Habitación) :- tutorial(3),newWrite,
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
	/*3*/abrir(Habitación) :-tutorial(3),newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									ubicación(Ubicación),
									conecta_con(Ubicación, Habitación),
									%not puerta(Ubicación, Habitación),
									puerta_abierta(Ubicación, Habitación),
									appendWrite('No existe ninguna puerta hacia el/la '),
									appendWrite(Habitación),
									appendWrite(' para abrir').
	/*4*/abrir(Habitación) :- tutorial(3),newWrite,
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
	/*5*/abrir(Habitación) :- tutorial(3),newWrite,
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
	/*5*/abrir(Habitación) :- tutorial(3),newWrite,
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
	/*5*/abrir(Habitación) :- tutorial(3),newWrite,
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
	/*6*/abrir(Habitación) :- tutorial(3),newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									not(ubicación(Habitación)),
									ubicación(Ubicación),
									not(conecta_con(Ubicación, Habitación)),
									appendWrite('Esa habitación se encuentra lejos de donde estás ahora').
	/*7*/abrir(Habitación) :- tutorial(3),newWrite,
									habitación(Habitación),
									not(disponible(Habitación)),
									ubicación(Habitación),
									appendWrite('Indica la puerta de una habitación a tu alrrededor para abirir').
	
	