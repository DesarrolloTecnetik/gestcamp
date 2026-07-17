<?php

	require '../init.conf';
	$CR->ajaxToken();
	header('Content-Type: application/json; charset=utf-8');

	$op = !empty($_GET['op']) ? $_GET['op'] : (!empty($_POST['op']) ? $_POST['op'] : 'list');

	#
	# LISTAR TODOS LOS EVENTOS
	#
	if( $op == 'list' ) {

		$db->query("SELECT * FROM campaign_eventos ORDER BY fecha DESC, id DESC");
		$db->execute();
		$rows = $db->resultSet();
		$db->CloseConnection();

		$data = array();
		foreach( $rows as $r ) {

			$data[] = array(
				'id'            => $r['uid'],
				'tipo'          => $r['tipo'],
				'fecha'         => $r['fecha'],
				'lugar'         => $r['lugar'],
				'responsable'   => $r['responsable'],
				'participantes' => (int) $r['participantes'],
				'estatus'       => $r['estatus'],
				'descripcion'   => $r['descripcion']
			);

		}

		echo json_encode(array('ok' => true, 'data' => $data));
		exit;

	}

	#
	# SINCRONIZAR (reemplaza el listado completo)
	#
	if( $op == 'sync' ) {

		$body = json_decode(file_get_contents('php://input'), true);
		$list = isset($body['list']) && is_array($body['list']) ? $body['list'] : array();

		$db->beginTransaction();

		$db->query("DELETE FROM campaign_eventos");
		$db->execute();
		$db->CloseConnection();

		foreach( $list as $e ) {

			$uidv = !empty($e['id']) ? substr($e['id'], 0, 40) : uniqid('evt_', true);

			$db->query("INSERT INTO campaign_eventos
				(uid, tipo, fecha, lugar, responsable, participantes, estatus, descripcion, userid, created_at, updated_at)
				VALUES
				(:uid, :tipo, :fecha, :lugar, :responsable, :participantes, :estatus, :descripcion, :userid, :now, :now)");

			$db->bind(':uid', $uidv);
			$db->bind(':tipo', isset($e['tipo']) ? $e['tipo'] : 'Mitin');
			$db->bind(':fecha', !empty($e['fecha']) ? $e['fecha'] : null);
			$db->bind(':lugar', isset($e['lugar']) ? $e['lugar'] : '');
			$db->bind(':responsable', isset($e['responsable']) ? $e['responsable'] : '');
			$db->bind(':participantes', isset($e['participantes']) ? (int) $e['participantes'] : 0);
			$db->bind(':estatus', isset($e['estatus']) ? $e['estatus'] : 'Programado');
			$db->bind(':descripcion', isset($e['descripcion']) ? $e['descripcion'] : '');
			$db->bind(':userid', $UserID ? $UserID : 0);
			$db->bind(':now', $datetime);
			$db->execute();
			$db->CloseConnection();

		}

		$db->commitTransaction();

		echo json_encode(array('ok' => true));
		exit;

	}

	echo json_encode(array('ok' => false, 'error' => 'Operación no válida.'));

?>
