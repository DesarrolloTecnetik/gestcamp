<?php

   require '../init.conf';
   $CR->ajaxToken();
   header('Content-Type: application/json; charset=utf-8');

   $op = !empty($_GET['op']) ? $_GET['op'] : (!empty($_POST['op']) ? $_POST['op'] : 'heat');

   function mapaNormaliza($s) {

      $s = trim(mb_strtolower($s, 'UTF-8'));
      $from = array('á','é','í','ó','ú','ü','à','è','ì','ò','ù','ä','ë','ï','ö','ñ');
      $to   = array('a','e','i','o','u','u','a','e','i','o','u','a','e','i','o','n');
      $s = str_replace($from, $to, $s);
      $s = preg_replace('/\s+/', ' ', $s);

      return $s;
   }

   if( $op == 'heat' ) {

      $db->query("SELECT cve_geo, nombre_municipio FROM cat_zonas WHERE cve_ent = '20' ORDER BY nombre_municipio ASC");
      $db->execute();
      $zonas = $db->resultSet();

      $indice = array();
      foreach( $zonas as $z ) {

         $indice[mapaNormaliza($z['nombre_municipio'])] = $z['cve_geo'];
      }

      $db->query("SELECT lugar, COUNT(*) AS total, MAX(fecha) AS ultima FROM campaign_eventos WHERE lugar IS NOT NULL AND lugar <> '' GROUP BY lugar");
      $db->execute();
      $agregado = $db->resultSet();

      $conteo = array();
      $sinMatch = array();

      foreach( $agregado as $a ) {

         $norm = mapaNormaliza($a['lugar']);

         if( isset($indice[$norm]) ) {

            $cve = $indice[$norm];

            if( !isset($conteo[$cve]) ) {

               $conteo[$cve] = array('total' => 0, 'ultima' => null);
            }

            $conteo[$cve]['total'] += (int) $a['total'];

            if( $a['ultima'] > $conteo[$cve]['ultima'] ) {

               $conteo[$cve]['ultima'] = $a['ultima'];
            }
         }
         else {

            $sinMatch[] = array('lugar' => $a['lugar'], 'total' => (int) $a['total']);
         }
      }

      $db->query("SELECT lugar, tipo, fecha, responsable, estatus FROM campaign_eventos WHERE lugar IS NOT NULL AND lugar <> '' ORDER BY fecha DESC, id DESC");
      $db->execute();
      $todos = $db->resultSet();
      $db->CloseConnection();

      $recientes = array();
      foreach( $todos as $t ) {

         $norm = mapaNormaliza($t['lugar']);

         if( !isset($indice[$norm]) ) {

            continue;
         }

         $cve = $indice[$norm];

         if( !isset($recientes[$cve]) ) {

            $recientes[$cve] = array();
         }

         if( count($recientes[$cve]) < 3 ) {

            $recientes[$cve][] = array(
               'tipo'        => $t['tipo'],
               'fecha'       => $t['fecha'],
               'responsable' => $t['responsable'],
               'estatus'     => $t['estatus']
            );
         }
      }

      if( count($sinMatch) > 0 ) {

         $nombres = array();
         foreach( $sinMatch as $sm ) {

            $nombres[] = $sm['lugar'].' ('.$sm['total'].')';
         }
         error_log('mapa.php lugares sin match ('.count($sinMatch).'): '.implode(' | ', $nombres));
      }

      echo json_encode(array(
         'ok'        => true,
         'conteo'    => $conteo,
         'recientes' => $recientes,
         'sin_match' => $sinMatch,
         'total_municipios' => count($zonas)
      ));
      exit;
   }

   echo json_encode(array('ok' => false, 'error' => 'Operación no válida.'));

?>
