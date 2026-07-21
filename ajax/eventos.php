<?php
    require '../init.conf';
    $CR->ajaxToken();
    header('Content-Type: application/json; charset=utf-8');

    $op = !empty($_GET['op']) ? $_GET['op'] : (!empty($_POST['op']) ? $_POST['op'] : 'list');

    if( $op == 'list' ) {
        $db->query("SELECT * FROM campaign_eventos ORDER BY fecha DESC, id DESC");
        $db->execute();
        $rows = $db->resultSet();
        $db->CloseConnection();

        $data = array();
        foreach( $rows as $r ) {
            $data[] = array(
                'id' => $r['uid'], 'tipo' => $r['tipo'], 'fecha' => $r['fecha'],
                'lugar' => $r['lugar'], 'responsable' => $r['responsable'],
                'participantes' => (int) $r['participantes'], 'estatus' => $r['estatus'], 'descripcion' => $r['descripcion']
            );
        }
        echo json_encode(array('ok' => true, 'data' => $data));
        exit;
    }

    if( $op == 'create' ) {

        $body = json_decode(file_get_contents('php://input'), true);
        $e = isset($body['entry']) && is_array($body['entry']) ? $body['entry'] : array();
        $uidv = !empty($e['id']) ? substr($e['id'], 0, 40) : uniqid('evt_', true);

        try {
            $db->query("INSERT INTO campaign_eventos (uid, tipo, fecha, lugar, responsable, participantes, estatus, descripcion, userid, created_at, updated_at) VALUES (:uid, :tipo, :fecha, :lugar, :responsable, :participantes, :estatus, :descripcion, :userid, :created_at, :updated_at)");
            $db->bind(':uid', $uidv); $db->bind(':tipo', isset($e['tipo']) ? $e['tipo'] : 'Mitin');
            $db->bind(':fecha', !empty($e['fecha']) ? $e['fecha'] : null); $db->bind(':lugar', isset($e['lugar']) ? $e['lugar'] : '');
            $db->bind(':responsable', isset($e['responsable']) ? $e['responsable'] : ''); $db->bind(':participantes', isset($e['participantes']) ? (int) $e['participantes'] : 0);
            $db->bind(':estatus', isset($e['estatus']) ? $e['estatus'] : 'Programado'); $db->bind(':descripcion', isset($e['descripcion']) ? $e['descripcion'] : '');
            $db->bind(':userid', $UserID ? $UserID : 0); $db->bind(':created_at', $datetime); $db->bind(':updated_at', $datetime);
            $db->execute();
            echo json_encode(array('ok' => true, 'id' => $uidv));
        } catch (Exception $ex) {
            error_log('eventos create error: ' . $ex->getMessage());
            echo json_encode(array('ok' => false, 'error' => $ex->getMessage()));
        }
        $db->CloseConnection();
        exit;
    }

    if( $op == 'update' ) {

        $body = json_decode(file_get_contents('php://input'), true);
        $e = isset($body['entry']) && is_array($body['entry']) ? $body['entry'] : array();
        $uidv = !empty($body['id']) ? substr($body['id'], 0, 40) : '';

        if( empty($uidv) ) {
            echo json_encode(array('ok' => false, 'error' => 'Falta el id del registro.'));
            exit;
        }

        try {
            $db->query("UPDATE campaign_eventos SET
                tipo = :tipo, fecha = :fecha, lugar = :lugar, responsable = :responsable,
                participantes = :participantes, estatus = :estatus, descripcion = :descripcion, updated_at = :updated_at
                WHERE uid = :uid");
            $db->bind(':tipo', isset($e['tipo']) ? $e['tipo'] : 'Mitin');
            $db->bind(':fecha', !empty($e['fecha']) ? $e['fecha'] : null);
            $db->bind(':lugar', isset($e['lugar']) ? $e['lugar'] : '');
            $db->bind(':responsable', isset($e['responsable']) ? $e['responsable'] : '');
            $db->bind(':participantes', isset($e['participantes']) ? (int) $e['participantes'] : 0);
            $db->bind(':estatus', isset($e['estatus']) ? $e['estatus'] : 'Programado');
            $db->bind(':descripcion', isset($e['descripcion']) ? $e['descripcion'] : '');
            $db->bind(':updated_at', $datetime);
            $db->bind(':uid', $uidv);
            $db->execute();
            echo json_encode(array('ok' => true));
        } catch (Exception $ex) {
            error_log('eventos update error: ' . $ex->getMessage());
            echo json_encode(array('ok' => false, 'error' => $ex->getMessage()));
        }
        $db->CloseConnection();
        exit;
    }

    if( $op == 'delete' ) {

        $body = json_decode(file_get_contents('php://input'), true);
        $uidv = !empty($body['id']) ? substr($body['id'], 0, 40) : '';

        if( empty($uidv) ) {
            echo json_encode(array('ok' => false, 'error' => 'Falta el id del registro.'));
            exit;
        }

        try {
            $db->query("DELETE FROM campaign_eventos WHERE uid = :uid");
            $db->bind(':uid', $uidv);
            $db->execute();
            echo json_encode(array('ok' => true));
        } catch (Exception $ex) {
            error_log('eventos delete error: ' . $ex->getMessage());
            echo json_encode(array('ok' => false, 'error' => $ex->getMessage()));
        }
        $db->CloseConnection();
        exit;
    }

    # SINCRONIZAR: solo para importes masivos/respaldo, ya no la usa el frontend día a día
    if( $op == 'sync' ) {
        $body = json_decode(file_get_contents('php://input'), true);
        $list = isset($body['list']) && is_array($body['list']) ? $body['list'] : array();

        try {
            $db->beginTransaction();
            $db->query("DELETE FROM campaign_eventos");
            $db->execute();

            foreach( $list as $e ) {
                $uidv = !empty($e['id']) ? substr($e['id'], 0, 40) : uniqid('evt_', true);
                $db->query("INSERT INTO campaign_eventos (uid, tipo, fecha, lugar, responsable, participantes, estatus, descripcion, userid, created_at, updated_at) VALUES (:uid, :tipo, :fecha, :lugar, :responsable, :participantes, :estatus, :descripcion, :userid, :created_at, :updated_at)");
                $db->bind(':uid', $uidv); $db->bind(':tipo', isset($e['tipo']) ? $e['tipo'] : 'Mitin');
                $db->bind(':fecha', !empty($e['fecha']) ? $e['fecha'] : null); $db->bind(':lugar', isset($e['lugar']) ? $e['lugar'] : '');
                $db->bind(':responsable', isset($e['responsable']) ? $e['responsable'] : ''); $db->bind(':participantes', isset($e['participantes']) ? (int) $e['participantes'] : 0);
                $db->bind(':estatus', isset($e['estatus']) ? $e['estatus'] : 'Programado'); $db->bind(':descripcion', isset($e['descripcion']) ? $e['descripcion'] : '');
                $db->bind(':userid', $UserID ? $UserID : 0); $db->bind(':created_at', $datetime); $db->bind(':updated_at', $datetime);
                $db->execute();
            }
            $db->commitTransaction();
            echo json_encode(array('ok' => true));
        } catch (Exception $e) {
            $db->rollBack();
            echo json_encode(array('ok' => false, 'error' => $e->getMessage()));
        }
        $db->CloseConnection();
        exit;
    }
?>