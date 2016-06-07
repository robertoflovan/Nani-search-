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
	ubicaci�n/1,
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
				appendWrite('Lo&�Hola!, me llamo "Lo", soy un peque�o perro y el mejor amigo de la ni�a, de la cual podr�s tener completo control de sus movimientos, ella est� pasando un mal momento y necesita la ayuda de cualquiera para guiarla hacia una mu�eca llamada �Nani�% la cual la ayudar� a librarse de todos los demonios que han estado atorment�ndola por mucho tiempo.%Te pido que por favor la ayudes, ella ya ha pasado por mucho, hace no mucho tiempo perdi� su brazo izquierdo por culpa de uno de esos demonios que la persiguen, gu�ala  a encontrar a su mu�eca encarg�ndote de sus acciones.%Antes de comenzar, debo advertirte que el mundo lo ver�s a trav�s de la mente imaginativa de la ni�a, por lo cual podr�s toparte con algunas cosas un poco extra�as que ella ve, pero no te preocupes, estoy seguro que sabr�s que hacer en cada situaci�n.%El poder de tus palabras en �sta situaci�n son bastante poderosas (m�s de lo que te imaginas), te pido que empieces a tomar el control de la ni�a recitando unas simples palabras: "tolle animam meam", �qu� significan?... en realidad nada en especial, s�lo tienen el poder para guiar a la ni�a.&&Consola&Prueba texto de consola'),	
				asserta(tutorial(1)),
				asserta(pide_respuesta(1)).
				
respuesta_pacto :-
					pide_respuesta(1),
					tutorial(1),
					newWrite,
					appendWrite('Lo&Bien, ahora tienes el control de la ni�a, las palabras digas ellas las escuchar� y las ejecutar�, puedes empezar por ver el mundo a trav�s de mi ni�a pidi�ndole que vea (ver), vamos, int�ntalo ;D . '),
					retractall(tutorial(_)),
					retractall(pide_respuesta(_)),
					asserta(tutorial(2)),
					asserta(pide_respuesta(2)).
	
respuesta_ver :-	
					tutorial(2),
					pide_respuesta(2),
					asserta(ubicaci�n(cocina)),
					newWrite,
					appendWrite('Consola&*Puedes ver a trav�s de los ojos de la ni�a, observas que en donde te encuentras ahora mismo parece ser la cocina.%Tal y como dijo Low, al mirar a tu alrededor algunas cosas parecen un poco extra�as, como si viniesen de la imaginaci�n de un ni�o alegre pero en ocasiones un toque t�trico, como animales que hacen movimientos extra�os de los cuales algunos desaparecen sin explicaci�n. Puedes ver algunos objetos que se encuentra ah�:'),
					nlW,
					listar_objetos(cocina),
					nlW,appendWrite('Las habitaciones a tu alrededor son:'), nlW,
					listar_conexiones(cocina),
					appendWrite('&&Lo&�Bien!, ahora puedes ver lo que mi ni�a ve, es f�cil �verdad?, as� como le ordenaste que observara el entorno en donde se encuentra, puedes ordenar otras cosas que controlen algunos de sus movimientos o acciones, te proporcionar� una lista de algunas cosas que puedes hacer, usa estas acciones para ayudar a mi ni�a a encontrar su mu�eca, debe estar en alg�n lugar de �sta casa:'),
					appendWrite('&&Consola&*La lista aparece en tu brazo derecho como si fuera una especie de extra�o tatuaje, la miras y lees lo que tiene escrito:%�Acciones que puedes controlar, escrito por Low ;)�
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
	Usar un objeto**
	Podr�s ver esta lista pronunciando �ayuda� cuando quieras*'),
					retractall(tutorial(_)),
					retractall(pide_respuesta(_)),
					asserta(tutorial(3)),
					asserta(salida_low).
	
	
	ir_a(comedor):-	
					salida_low,
					tutorial(3),
					newWrite,
					appendWrite('Lo&No puedo permanecer si mi ni�a no est� conciente. Te pido que la cuides y encuentres esa mu�eca por su bien, en el momento que la tomes yo me ocupar� del resto.&&Consola&*Low a desaparecido ante ti*'),
					retractall(salida_low),
					asserta(juego_cofre).
	
	ir_a(Lugar):-
					tutorial(3),
					newWrite,
					puede_ir(Lugar),
					mover(Lugar),
					verApp.
					
	%En �sta parte se tendr� juego_cofre y tutorial(3)
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-3-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*3*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitaci�n(Objeto)),
								contenedor(Objeto,_),
								not(juego_cofre),
								Objeto \== cofre_de_nani,
								
								disponible(Objeto),
								not(locaci�n(ObjetoAdentro,Objeto)),
								not(abierto(Objeto)),
								asserta(abierto(Objeto)),
								appendWrite('Abriste el/la '),
								appendWrite(Objeto),
								appendWrite(' pero no encuentras nada dentro de ella.').
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-4-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*4*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitaci�n(Objeto)),
								 contenedor(Objeto,_),
								 not(juego_cofre),
								 Objeto \== cofre_de_nani,
								 
								 disponible(Objeto),
								 locaci�n(_,Objeto),
								 not(abierto(Objeto)),
								 asserta(abierto(Objeto)),
								 appendWrite('Abriste el/la '),
								 appendWrite(Objeto),
								 appendWrite(', dentro de ella puedes ver:'), nlW,!,
								 locaci�n(X,Objeto),
								 imprimir_objeto(X).
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-3-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*3b*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitaci�n(Objeto)),
								contenedor(Objeto,_),
								juego_cofre,
								Objeto \== cofre_de_nani,
								disponible(Objeto),
								not(locaci�n(ObjetoAdentro,Objeto)),
								not(abierto(Objeto)),
								asserta(abierto(Objeto)),
								appendWrite('Abriste el/la '),
								appendWrite(Objeto),
								appendWrite(' pero no encuentras nada dentro de ella.').
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-4-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*4b*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitaci�n(Objeto)),
								 contenedor(Objeto,_),
								 juego_cofre,
								 Objeto \== cofre_de_nani,
								 disponible(Objeto),
								 locaci�n(_,Objeto),
								 not(abierto(Objeto)),
								 asserta(abierto(Objeto)),
								 appendWrite('Abriste el/la '),
								 appendWrite(Objeto),
								 appendWrite(', dentro de ella puedes ver:'), nlW,!,
								 locaci�n(X,Objeto),
								 imprimir_objeto(X).
								 
								 					 
	abrir(cofre_de_nani) :-
					juego_cofre,
					tutorial(3),
					newWrite,
					appendWrite('400&Hola mi peque�a ;). Quieres la mu�eca �no es as�?, ser�a algo malo, tus padres la han confiscado por lo que puede hacer. De todas maneras, yo puedo ayudarte, podr�a entregarte la llave de ese cofre a cambio de unas cu�ntas cosas que me da pereza conseguir.%Si est�s interesda puedes traerme una peque�a bola de estambre para entretenerme :D*&&Consola&*Consigue el estambre para 400*'),
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
					ubicaci�n(X),
					X == comedor,
					objeto_en_mano(estambre),
					appendWrite('400&Muy bien, dejar� la llave por aqu�, pero yo no tomar�a esa mu�eca ;)&&Consola&*400 ha dejado la llave en el suelo*'),
					retract(objeto_en_mano(estambre)),
					retractall(conseguir_estambre),
					asserta(locaci�n(llave_cofre,comedor)).
					
	dar(estambre,400) :- %  NO tiene el estambre
					tutorial(3),
					newWrite,
					conseguir_estambre,
					ubicaci�n(X),
					X == comedor,
					not(objeto_en_mano(estambre)),
					appendWrite('400&Vamos, no es una cosa tan dif�cil consegur una peque�a bola de estambre&&Consola&*Consigue el estambre para 400*').
	
	
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
	Una caja azul&&400&Vamos a hacer esto un poco m�s interesante, en una de esas cajas se encuentra esa mu�eca que tanto buscas, tienes una oportunidad de seleccionar la correcta, puedes leer las pistas que tienen las cajas&&Consola&En cada una de las cajas hay una oraci�n inscrita:
	caja amarilla : Nani no est� en la caja roja
	caja roja: Nani no est� en esta caja
	caja azul: Nani est� en esta caja&&400&Por lo menos una de las tres oraciones es
verdadera y por lo menos una es falsa, suerte ;)').
	
	
	abrir(cofre_de_nani) :- % Tiene la llave
					not(juego_cofre),
					tutorial(3),
					newWrite,
					objeto_en_mano(llave_cofre),
					abierto(cofre_de_nani),
					appendWrite('400&Te explicar� otra vez, en una de esas cajas se encuentra esa mu�eca que tanto buscas, tienes una oportunidad de seleccionar la correcta, puedes leer las pistas que tienen las cajas&&Consola&En cada una de las cajas hay una oraci�n inscrita:
	caja amarilla : Nani no est� en la caja roja
	caja roja: Nani no est� en esta caja
	caja azul: Nani est� en esta caja&&400&Por lo menos una de las tres oraciones es
verdadera y por lo menos una es falsa, suerte ;)'),
					retractall(tutorial(_)),
					asserta(tutorial(4)).
					
abrir(caja_amarilla) :-
					tutorial(4),
					newWrite,
					retractall(ubicaci�n(_)),
					asserta(ubicaci�n(hell)),
					appendWrite('Low2&Peque�o ingenuo').

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*1*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitaci�n(Objeto)),
								contenedor(Objeto,_),
								
								
								disponible(Objeto),
								not(locaci�n(ObjetoAdentro,Objeto)),
								abierto(Objeto),
								appendWrite('El/La '),
								appendWrite(Objeto),
								appendWrite(' ya se encuentra abierto.').
								
	/*1*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitaci�n(Objeto)),
								 contenedor(Objeto,_),
								 
								 
								 disponible(Objeto),
								 locaci�n(_,Objeto),
								 abierto(Objeto),
								 appendWrite('El/La '),
								 appendWrite(Objeto),
								 appendWrite(' ya se encuentra abierto.'),
								 appendWrite(' Dentro de �l puedes ver: '),nlW,!,
								 locaci�n(X,Objeto),
								 imprimir_objeto(X).
								 
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-2-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*2*/abrir(Objeto) :- tutorial(3),newWrite,
								not(habitaci�n(Objeto)),
								 not(contenedor(Objeto,_)),
								 disponible(Objeto),
								 appendWrite('Te preguntas el por qu� est�s intentando abrir un/una '),
								 appendWrite(Objeto),
								 appendWrite(', es il�gico.').
								 
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-5-%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*5*/abrir(Objeto) :- tutorial(3),newWrite,
								 not(disponible(Objeto)),
								 not(habitaci�n(Objeto)),
								 appendWrite('No encuentras ning�n '),
								 appendWrite(Objeto),
								 appendWrite(' para intentar abrir').
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*2*/abrir(Habitaci�n) :- tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(disponible(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									conecta_con(Ubicaci�n, Habitaci�n),
									%puerta(Ubicaci�n, Habitaci�n),
									not(puerta_abierta(Ubicaci�n, Habitaci�n)),
									abierto(Ubicaci�n, Habitaci�n),
									appendWrite('La puerta hacia el/la '),
									appendWrite(Habitaci�n),
									appendWrite(' ya se encuentra abierto').
	/*3*/abrir(Habitaci�n) :-tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(disponible(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									conecta_con(Ubicaci�n, Habitaci�n),
									%not puerta(Ubicaci�n, Habitaci�n),
									puerta_abierta(Ubicaci�n, Habitaci�n),
									appendWrite('No existe ninguna puerta hacia el/la '),
									appendWrite(Habitaci�n),
									appendWrite(' para abrir').
	/*4*/abrir(Habitaci�n) :- tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(disponible(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									conecta_con(Ubicaci�n, Habitaci�n),
									%puerta(Ubicaci�n, Habitaci�n),
									not(puerta_abierta(Ubicaci�n, Habitaci�n)),
									not(abierto(Ubicaci�n, Habitaci�n)),
									not(requiere_llave(Ubicaci�n, Habitaci�n)), %%???????????????%%%??????????
									asserta(abierto2(Ubicaci�n, Habitaci�n)),
									appendWrite('Abriste la puerta hacia el/la '),
									appendWrite(Habitaci�n).

%%%%%%%%%%%%%%%%%%%%%%%%%%- Puertas especiales (llave) -%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	/*5*/abrir(Habitaci�n) :- tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(disponible(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									conecta_con(Ubicaci�n, Habitaci�n),
									%puerta(Ubicaci�n, Habitaci�n),
									not(puerta_abierta(Ubicaci�n, Habitaci�n)),
									not(abierto(Ubicaci�n, Habitaci�n)),
									requiere_llave(Ubicaci�n, Habitaci�n),
									not(tiene_llave),
									appendWrite('La puerta est� cerrada con llave, no tienes ning�na llave').
	/*5*/abrir(Habitaci�n) :- tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(disponible(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									conecta_con(Ubicaci�n, Habitaci�n),
									%puerta(Ubicaci�n, Habitaci�n),
									not(puerta_abierta(Ubicaci�n, Habitaci�n)),
									not(abierto(Ubicaci�n, Habitaci�n)),
									requiere_llave(Ubicaci�n, Habitaci�n),
									tiene_llave,
									not(llave_correcta(Habitaci�n)),
									appendWrite('No tienes la llave correcta').
	/*5*/abrir(Habitaci�n) :- tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(disponible(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									conecta_con(Ubicaci�n, Habitaci�n),
									%puerta(Ubicaci�n, Habitaci�n),
									not(puerta_abierta(Ubicaci�n, Habitaci�n)),
									not(abierto(Ubicaci�n, Habitaci�n)),
									requiere_llave(Ubicaci�n, Habitaci�n),
									tiene_llave,
									llave_correcta(Habitaci�n),
									asserta(abierto2(Ubicaci�n, Habitaci�n)),
									appendWrite('Abriste la puerta hacia el/la'),
									appendWrite(Habitaci�n).
	/*6*/abrir(Habitaci�n) :- tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(disponible(Habitaci�n)),
									not(ubicaci�n(Habitaci�n)),
									ubicaci�n(Ubicaci�n),
									not(conecta_con(Ubicaci�n, Habitaci�n)),
									appendWrite('Esa habitaci�n se encuentra lejos de donde est�s ahora').
	/*7*/abrir(Habitaci�n) :- tutorial(3),newWrite,
									habitaci�n(Habitaci�n),
									not(disponible(Habitaci�n)),
									ubicaci�n(Habitaci�n),
									appendWrite('Indica la puerta de una habitaci�n a tu alrrededor para abirir').
	
	