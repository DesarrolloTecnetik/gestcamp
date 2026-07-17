<?php

	require '../init.conf';
	$CR->ajaxToken();
	header('Content-Type: application/json; charset=utf-8');

	$nombre = !empty($_POST['nombre']) ? trim($_POST['nombre']) : null;

	if( $nombre == null ) {

		echo json_encode(array('ok' => false, 'error' => 'Escribe el nombre de la persona o candidatura a analizar.'));
		exit;

	}

	#
	# OBTENER API KEY DESDE LA TABLA config (nunca se expone al navegador)
	#
	$db->query("SELECT anthropic_api_key FROM config");
	$db->execute();
	$configRow = $db->single();
	$db->CloseConnection();

	$apiKey = !empty($configRow['anthropic_api_key']) ? $configRow['anthropic_api_key'] : null;

	if( $apiKey == null ) {

		echo json_encode(array('ok' => false, 'error' => 'No hay una API key de Anthropic configurada. Agrégala en config.anthropic_api_key.'));
		exit;

	}

	$prompt = 'Da un resumen breve, neutral y objetivo, basado únicamente en información pública disponible, sobre la persona o candidatura: "'.$nombre.'".
Estructura la respuesta con estos apartados en español, usando estos títulos exactos seguidos de dos puntos y salto de línea:
Trayectoria:
Temas asociados:
Percepción pública / cobertura reciente:
Sé conciso (máximo 2-3 líneas por apartado). No inventes datos ni cites cifras que no puedas respaldar; si no hay suficiente información pública, dilo explícitamente. No emitas opiniones ni recomendaciones de campaña, solo información factual y verificable.';

	$payload = json_encode(array(
		'model'      => 'claude-sonnet-4-6',
		'max_tokens' => 1000,
		'messages'   => array(
			array('role' => 'user', 'content' => $prompt)
		),
		'tools'      => array(
			array('type' => 'web_search_20250305', 'name' => 'web_search')
		)
	));

	$ch = curl_init('https://api.anthropic.com/v1/messages');
	curl_setopt_array($ch, array(
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_POST           => true,
		CURLOPT_POSTFIELDS     => $payload,
		CURLOPT_TIMEOUT        => 60,
		CURLOPT_HTTPHEADER     => array(
			'content-type: application/json',
			'x-api-key: '.$apiKey,
			'anthropic-version: 2023-06-01'
		)
	));

	$response = curl_exec($ch);
	$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	$curlErr  = curl_error($ch);
	curl_close($ch);

	if( $response === false || $httpCode >= 400 ) {

		$CR->logs('Error análisis IA candidatura', 'HTTP '.$httpCode.' '.$curlErr.' '.substr($response, 0, 300), $UserID);
		echo json_encode(array('ok' => false, 'error' => 'No se pudo contactar al servicio de análisis. Intenta de nuevo más tarde.'));
		exit;

	}

	$data = json_decode($response, true);
	$text = '';

	if( !empty($data['content']) && is_array($data['content']) ) {

		foreach( $data['content'] as $block ) {

			if( isset($block['type']) && $block['type'] == 'text' ) { $text .= $block['text']; }

		}

	}

	echo json_encode(array('ok' => true, 'text' => trim($text)));

?>
