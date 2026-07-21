<?php

	require 'init.conf';

	if( !empty($UserID) ) {

		// borra la sesiиоn activa en login_temp
		$db->query("DELETE FROM login_temp WHERE userid = :account");
		$db->bind(':account', $UserID);
		$db->execute();
		$db->CloseConnection();

		// marca al usuario como desconectado
		$CR->updateData("login", "isonline", 0, "userid", $UserID);

		// destruye la sesiиоn del kernel + la sesiиоn PHP
		if( isset($session) ) { $session->destroy($UserID); }
		unset($_SESSION['id']);
		unset($_SESSION['gologout']);
		@session_destroy();

	}

	header('Location: '.URL.'/login');
	exit;

?>