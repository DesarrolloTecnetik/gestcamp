<?php

	require '../init.conf';
	$CR->ajaxToken();
	header('Content-Type: application/json; charset=utf-8');

	$op = !empty($_GET['op']) ? $_GET['op'] : (!empty($_POST['op']) ? $_POST['op'] : 'list');

	#
	# LISTAR MUNICIPIOS/ZONAS (para autocompletado)
	#
	if( $op == 'list' ) {

		$db->query("SELECT cve_geo, nombre_municipio FROM cat_zonas ORDER BY nombre_municipio ASC");
		$db->execute();
		$rows = $db->resultSet();
		$db->CloseConnection();

		$data = array();
		foreach( $rows as $r ) {
			$data[] = array(
				'id'     => $r['cve_geo'],
				'nombre' => $r['nombre_municipio']
			);
		}

		echo json_encode(array('ok' => true, 'data' => $data));
		exit;

	}

	echo json_encode(array('ok' => false, 'error' => 'Operación no válida.'));

?>