<?php

	require '../init.conf';
	$CR->ajaxToken();
	header('Content-Type: application/json; charset=utf-8');

	$op = !empty($_GET['op']) ? $_GET['op'] : (!empty($_POST['op']) ? $_POST['op'] : 'list');

	#
	# LISTAR SIMPATIZANTES ENROLADOS
	#
	if( $op == 'list' ) {

		$db->query("SELECT * FROM campaign_brm ORDER BY fecha DESC, id DESC");
		$db->execute();
		$rows = $db->resultSet();
		$db->CloseConnection();

		$data = array();
		foreach( $rows as $r ) {

			$data[] = array(
				'id'       => $r['uid'],
				'nombre'   => $r['nombre'],
				'telefono' => $r['telefono'],
				'zona'     => $r['zona'],
				'fecha'    => $r['fecha'],
				'ine'      => $r['ine_photo'],
				'selfie'   => $r['selfie_photo'],
				'consent'  => (bool) $r['consent']
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

		$db->query("DELETE FROM campaign_brm");
		$db->execute();
		$db->CloseConnection();

		foreach( $list as $e ) {

			$uidv = !empty($e['id']) ? substr($e['id'], 0, 40) : uniqid('brm_', true);

			$db->query("INSERT INTO campaign_brm
				(uid, nombre, telefono, zona, fecha, ine_photo, selfie_photo, consent, userid, created_at)
				VALUES
				(:uid, :nombre, :telefono, :zona, :fecha, :ine, :selfie, :consent, :userid, :now)");

			$db->bind(':uid', $uidv);
			$db->bind(':nombre', isset($e['nombre']) ? $e['nombre'] : '');
			$db->bind(':telefono', isset($e['telefono']) ? $e['telefono'] : '');
			$db->bind(':zona', isset($e['zona']) ? $e['zona'] : '');
			$db->bind(':fecha', !empty($e['fecha']) ? $e['fecha'] : $date);
			$db->bind(':ine', isset($e['ine']) ? $e['ine'] : null);
			$db->bind(':selfie', isset($e['selfie']) ? $e['selfie'] : null);
			$db->bind(':consent', !empty($e['consent']) ? 1 : 0);
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
