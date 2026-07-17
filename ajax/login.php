<?php

	require '../init.conf';
	$CR->ajaxToken();
	header('Content-Type: application/json; charset=utf-8');

	$op = !empty($_POST['op']) ? $_POST['op'] : 'login';

	if( $op == 'login' ) {

		$user = !empty($_POST['user']) ? trim($_POST['user']) : null;
		$pass = !empty($_POST['pass']) ? $_POST['pass'] : null;

		if( !$user || !$pass ) {
			echo json_encode(array('ok' => false, 'error' => 'Ingresa usuario y contraseña.'));
			exit;
		}

		$db->query("SELECT userid, user, pass, verified FROM login WHERE user = :us1");
		$db->bind(':us1', $user);
		$db->execute();
		$usData = $db->single();
		$db->CloseConnection();

		if( !$usData ) {
			echo json_encode(array('ok' => false, 'error' => 'Usuario o contraseña incorrectos.'));
			exit;
		}

		$passHash = $CR->encripter($pass);

		if( $passHash != $usData['pass'] ) {
			echo json_encode(array('ok' => false, 'error' => 'Usuario o contraseña incorrectos.'));
			exit;
		}

		if( (int) $usData['verified'] < 1 ) {
			echo json_encode(array('ok' => false, 'error' => 'Esta cuenta no está verificada.'));
			exit;
		}

		$usId = $usData['userid'];

		// crea sesión real usando la clase ya existente en el kernel
		$token_rand = $CR->key('sb', '10');
		$token = $CR->secret($usId.$user.$token_rand, 'cripte');

		// limpia sesión anterior si existiera
		$db->query("DELETE FROM login_temp WHERE userid = :usid");
		$db->bind(':usid', $usId);
		$db->execute();
		$db->CloseConnection();

		$db->query("INSERT INTO login_temp (userid, itime, ip, token, uagent, remember) VALUES (:us_id, :itime, :ip, :token, :uagent, :remember)");
		$db->bind(':us_id', $usId);
		$db->bind(':itime', time());
		$db->bind(':ip', $ip);
		$db->bind(':token', $token);
		$db->bind(':uagent', $navegator);
		$db->bind(':remember', 0);
		$db->execute();
		$db->CloseConnection();

		$db->query("UPDATE login SET lastlogin = :laslog, last_ip = :lastip, isonline = 1 WHERE userid = :acc_id");
		$db->bind(':laslog', $datetime);
		$db->bind(':lastip', $ip);
		$db->bind(':acc_id', $usId);
		$db->execute();
		$db->CloseConnection();

		$session = new PHPSession($PDO_INSTANCE);
		$session->gc(300);
		$session->write($usId, $token);
		$_SESSION['id'] = $usId;

		$goURL = !empty($_SESSION['gologout']) ? $_SESSION['gologout'] : URL.'/inicio/dashboard';
		unset($_SESSION['gologout']);

		echo json_encode(array('ok' => true, 'redirect' => $goURL));
		exit;

	}

	echo json_encode(array('ok' => false, 'error' => 'Operación no válida.'));

?>