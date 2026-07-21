<?php
	require 'init.conf';

	#
	# GATE DE SESIÓN -> si no hay usuario logueado, manda a /login
	# guarda la URL solicitada para regresar ahí después del login
	#
		if( empty($UserID) ) {
			$_SESSION['gologout'] = URL.$_SERVER['REQUEST_URI'];
			header('Location: '.URL.'/login');
			exit;
		}

	#
	# CONFIGURACIÓN DE VISTAS (THEMES)
	# Cada vista es un archivo independiente en kernel/themes/
	#
	$VIEWS = array(
		'dashboard'    => array('title' => 'Panel general',                'cta' => null),
		'bitacora'     => array('title' => 'Bitácora de acciones',         'cta' => 'Nueva acción',            'ctaFn' => 'openBForm()'),
		'eventos'      => array('title' => 'Eventos',                      'cta' => 'Nuevo evento',            'ctaFn' => 'openEForm()'),
		'mapa'         => array('title' => 'Mapa de calor',                'cta' => 'Regenerar simulación',    'ctaFn' => 'regenSim(); renderHeatmap();'),
		'brm'          => array('title' => 'BRM · Enrolamiento',           'cta' => null),
		'estadisticas' => array('title' => 'Estadísticas',                 'cta' => null),
		'candidatura'  => array('title' => 'Estadística de candidatura',   'cta' => null)
	);
	#
	# VALIDAR VISTA SOLICITADA (whitelist -> evita path traversal)
	#
		$actionReq  = !empty($_GET['action']) ? $_GET['action'] : 'dashboard';
		$activeView = array_key_exists($actionReq, $VIEWS) ? $actionReq : 'dashboard';
		$viewTitle  = $VIEWS[$activeView]['title'];
	#
	# RENDER: head + body (sidebar/topbar) + theme de la vista + footer
	#
		require PATH.'/kernel/tpl/head.tpl';
		require PATH.'/kernel/tpl/body.tpl';
		require PATH.'/kernel/themes/'.$activeView.'.php';
		require PATH.'/kernel/tpl/footer.tpl';
?>