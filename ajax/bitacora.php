<?php

	require '../init.conf';
	$CR->ajaxToken();
	header('Content-Type: application/json; charset=utf-8');

	$op = !empty($_GET['op']) ? $_GET['op'] : (!empty($_POST['op']) ? $_POST['op'] : 'list');
	$datetime = date('Y-m-d H:i:s');

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
	# CREAR UNA NUEVA ACCIÓN (fila individual)
	#
	if( $op == 'create' ) {

		$body = json_decode(file_get_contents('php://input'), true);
		$e = isset($body['entry']) && is_array($body['entry']) ? $body['entry'] : array();
		$uidv = !empty($e['id']) ? substr($e['id'], 0, 40) : uniqid('bit_', true);

		try {
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
			echo json_encode(array('ok' => true, 'id' => $uidv));
		} catch (Exception $ex) {
			error_log('bitacora create error: ' . $ex->getMessage());
			echo json_encode(array('ok' => false, 'error' => $ex->getMessage()));
		}
		$db->CloseConnection();
		exit;
	}

	#
	# ACTUALIZAR UNA ACCIÓN EXISTENTE (fila individual)
	#
	if( $op == 'update' ) {

		$body = json_decode(file_get_contents('php://input'), true);
		$e = isset($body['entry']) && is_array($body['entry']) ? $body['entry'] : array();
		$uidv = !empty($body['id']) ? substr($body['id'], 0, 40) : '';

		if( empty($uidv) ) {
			echo json_encode(array('ok' => false, 'error' => 'Falta el id del registro.'));
			exit;
		}

		try {
			$db->query("UPDATE campaign_bitacora SET
				fecha = :fecha, actividad = :actividad, responsable = :responsable, prioridad = :prioridad,
				fecha_inicio = :fechaInicio, acuerdos = :acuerdos, status = :status, avance = :avance,
				seg_fecha = :segFecha, seg_desc = :segDesc, proxima = :proxima, updated_at = :updated_at
				WHERE uid = :uid");
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
			$db->bind(':updated_at', $datetime);
			$db->bind(':uid', $uidv);
			$db->execute();
			echo json_encode(array('ok' => true));
		} catch (Exception $ex) {
			error_log('bitacora update error: ' . $ex->getMessage());
			echo json_encode(array('ok' => false, 'error' => $ex->getMessage()));
		}
		$db->CloseConnection();
		exit;
	}

	#
	# ELIMINAR UNA ACCIÓN (fila individual)
	#
	if( $op == 'delete' ) {

		$body = json_decode(file_get_contents('php://input'), true);
		$uidv = !empty($body['id']) ? substr($body['id'], 0, 40) : '';

		if( empty($uidv) ) {
			echo json_encode(array('ok' => false, 'error' => 'Falta el id del registro.'));
			exit;
		}

		try {
			$db->query("DELETE FROM campaign_bitacora WHERE uid = :uid");
			$db->bind(':uid', $uidv);
			$db->execute();
			echo json_encode(array('ok' => true));
		} catch (Exception $ex) {
			error_log('bitacora delete error: ' . $ex->getMessage());
			echo json_encode(array('ok' => false, 'error' => $ex->getMessage()));
		}
		$db->CloseConnection();
		exit;
	}

	#
	# SINCRONIZAR (SOLO PARA IMPORTES MASIVOS / RESPALDO. Ya no la usa el frontend
	# para crear/editar/eliminar día a día porque con tablas grandes el payload
	# completo puede chocar con límites del WAF del hosting)
	#
	if( $op == 'sync' ) {
		$body = json_decode(file_get_contents('php://input'), true);
		$list = isset($body['list']) && is_array($body['list']) ? $body['list'] : array();
		try {
			$db->beginTransaction();
			$db->query("DELETE FROM campaign_bitacora");
			$db->execute();
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
			}
			$db->commitTransaction();
			echo json_encode(array('ok' => true));
		} catch (Exception $e) {
			$db->rollBack();
			error_log('bitacora sync error: ' . $e->getMessage());
			echo json_encode(array('ok' => false, 'error' => $e->getMessage()));
		}
		$db->CloseConnection();
		exit;
	}

	echo json_encode(array('ok' => false, 'error' => 'Operación no válida.'));

?>