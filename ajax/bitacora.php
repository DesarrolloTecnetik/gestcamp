<?php

	require '../init.conf';
	$CR->ajaxToken();
	header('Content-Type: application/json; charset=utf-8');

	$op = !empty($_GET['op']) ? $_GET['op'] : (!empty($_POST['op']) ? $_POST['op'] : 'list');

	#
	# LISTAR TODAS LAS ACCIONES DE BITÁCORA
	#
	if( $op == 'list' ) {

		$db->query("SELECT * FROM campaign_bitacora ORDER BY fecha DESC, id DESC");
		$db->execute();
		$rows = $db->resultSet();
		$db->CloseConnection();

		$data = array();
		foreach( $rows as $r ) {

			$data[] = array(
				'id'          => $r['uid'],
				'fecha'       => $r['fecha'],
				'actividad'   => $r['actividad'],
				'responsable' => $r['responsable'],
				'prioridad'   => $r['prioridad'],
				'fechaInicio' => $r['fecha_inicio'],
				'acuerdos'    => $r['acuerdos'],
				'status'      => $r['status'],
				'avance'      => (int) $r['avance'],
				'segFecha'    => $r['seg_fecha'],
				'segDesc'     => $r['seg_desc'],
				'proxima'     => $r['proxima']
			);

		}

		echo json_encode(array('ok' => true, 'data' => $data));
		exit;

	}

	#
	# SINCRONIZAR (reemplaza el listado completo, igual que el prototipo con window.storage)
	#
	if( $op == 'sync' ) {

		$body = json_decode(file_get_contents('php://input'), true);
		$list = isset($body['list']) && is_array($body['list']) ? $body['list'] : array();

		$db->beginTransaction();

		$db->query("DELETE FROM campaign_bitacora");
		$db->execute();
		// OJO: no cerramos la conexión aquí — la transacción sigue abierta
		// y necesitamos la MISMA conexión para el resto de las operaciones.

		foreach( $list as $e ) {

			$uidv = !empty($e['id']) ? substr($e['id'], 0, 40) : uniqid('bit_', true);

			$db->query("INSERT INTO campaign_bitacora
				(uid, fecha, actividad, responsable, prioridad, fecha_inicio, acuerdos, status, avance, seg_fecha, seg_desc, proxima, userid, created_at, updated_at)
				VALUES
				(:uid, :fecha, :actividad, :responsable, :prioridad, :fechaInicio, :acuerdos, :status, :avance, :segFecha, :segDesc, :proxima, :userid, :created_at, :updated_at)");

			$db->bind(':uid', $uidv);
			$db->bind(':fecha', !empty($e['fecha']) ? $e['fecha'] : null);
			$db->bind(':actividad', isset($e['actividad']) ? $e['actividad'] : '');
			$db->bind(':responsable', isset($e['responsable']) ? $e['responsable'] : '');
			$db->bind(':prioridad', isset($e['prioridad']) ? $e['prioridad'] : 'MEDIA');
			$db->bind(':fechaInicio', !empty($e['fechaInicio']) ? $e['fechaInicio'] : null);
			$db->bind(':acuerdos', isset($e['acuerdos']) ? $e['acuerdos'] : '');
			$db->bind(':status', isset($e['status']) ? $e['status'] : 'Pendiente');
			$db->bind(':avance', isset($e['avance']) ? (int) $e['avance'] : 0);
			$db->bind(':segFecha', !empty($e['segFecha']) ? $e['segFecha'] : null);
			$db->bind(':segDesc', isset($e['segDesc']) ? $e['segDesc'] : '');
			$db->bind(':proxima', isset($e['proxima']) ? $e['proxima'] : '');
			$db->bind(':userid', $UserID ? $UserID : 0);
			$db->bind(':created_at', $datetime);
			$db->bind(':updated_at', $datetime);
			$db->execute();
			// tampoco aquí — seguimos dentro de la misma transacción

		}

		$db->commitTransaction();
		$db->CloseConnection();

		echo json_encode(array('ok' => true));
		exit;

	}

	echo json_encode(array('ok' => false, 'error' => 'Operación no válida.'));

?>