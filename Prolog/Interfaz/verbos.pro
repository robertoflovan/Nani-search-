

	% Ej: verbo(Comando, EnLista-[]).
	verbo(ayuda, [ayuda|X]-X).
	
	verbo(ver, [ver|X]-X).
	verbo(ver, [mirar|X]-X).
	verbo(ver, [vamo,a,ver|X]-X).
	verbo(ver, [examinar|X]-X).

	verbo(inventario, [inventario|X]-X).
	verbo(inventario, [mis,objetos|X]-X).
	
	verbo(apagar_luz, [apagar|X]-X).
	verbo(apagar_luz, [apagar,luz|X]-X).
	
	verbo(encender_luz, [encender|X]-X).
	verbo(encender_luz, [encender,luz|X]-X).
	
	verbo(empezar_juego, [comenzar|X]-X).
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	% Ej: verbo(Tipo_Objeto, Comando, EnLista-S1),
	verbo(estandar, abrir, [abrir|X]-X).
	verbo(estandar, abrir, [vamo,a,abrir|X]-X).
	
	verbo(estandar, cerrar, [cerrar|X]-X).
	verbo(estandar, cerrar, [vamo,a,cerrar|X]-X).
	
	verbo(estandar, ir_a, [ir,a|X]-X).
	verbo(estandar, ir_a, [ir|X]-X).
	verbo(estandar, ir_a, [ir,al|X]-X).%Ir al pasillo1....Ir al el pasillo1, corregir
	verbo(estandar, ir_a, [vamo,a,ir|X]-X).
	verbo(estandar, ir_a, [vamo,a|X]-X).
	
	verbo(estandar, tomar, [tomar|X]-X).
	verbo(estandar, tomar, [recoger|X]-X).
	verbo(estandar, tomar, [agarrar|X]-X).
	verbo(estandar, tomar, [vamo,a,tomar|X]-X).
	
	verbo(estandar, soltar, [soltar|X]-X).
	verbo(estandar, soltar, [dejar|X]-X).
	
	verbo(estandar, comer, [comer|X]-X).
	verbo(estandar, comer, [vamo,a,comer|X]-X).
	
	verbo(estandar, colocar_en_mano, [colocar,en,mano|X]-X).
	verbo(estandar, colocar_en_mano, [en,mano|X]-X).
	verbo(estandar, colocar_en_mano, [guardar,en,mano|X]-X).
	verbo(estandar, colocar_en_mano, [poner,en,mano|X]-X).
	verbo(estandar, colocar_en_mano, [mover,a,mano|X]-X).
	verbo(estandar, colocar_en_mano, [usar|X]-X). %?
	
	verbo(estandar, guardar_en_mochila, [guardar|X]-X).
	verbo(estandar, guardar_en_mochila, [guardar,en,mochila|X]-X).
	verbo(estandar, guardar_en_mochila, [en,mochila|X]-X).
	verbo(estandar, guardar_en_mochila, [colocar,en,mochila|X]-X).
	verbo(estandar, guardar_en_mochila, [mover,a,mochila|X]-X).
	verbo(estandar, guardar_en_mochila, [poner,en,mochila|X]-X).
	
	
	
	%%%LOL
	%command(X,[le,voy,a,pasar,el,programa,a,jair,/?]).
	%verbo([no,que,coma,kaka,el,webon], [le,voy,a,pasar,el,programa,a,jair,/?|X]-X).
	%verbo(tu_gfa, [kyc|X]-X).
	