<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

<div class="map-toolbar">
  <div class="map-note">División municipal completa del estado de Oaxaca (570 municipios, límites oficiales INEGI). El color de cada municipio refleja el número de eventos registrados en ese lugar.</div>
  <div class="mapa-leyenda-inline" id="mapa-sinmatch"></div>
</div>

<div class="card mapa-card">
  <div id="mapa-heat"></div>
  <div class="mapa-loading" id="mapa-loading">
    <div class="mapa-spinner"></div>
    <span>Cargando cartografía…</span>
  </div>
</div>

<style>
  .mapa-card{padding:14px;position:relative;}
  #mapa-heat{width:100%;height:620px;border-radius:12px;background:#EAF0F4;}
  .mapa-loading{position:absolute;inset:14px;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:12px;background:rgba(255,255,255,.86);border-radius:12px;z-index:500;color:var(--ink-soft);font-size:13px;font-weight:600;}
  .mapa-spinner{width:34px;height:34px;border:3px solid var(--line);border-top-color:var(--purple);border-radius:50%;animation:mapaSpin .8s linear infinite;}
  @keyframes mapaSpin{to{transform:rotate(360deg);}}

  .leaflet-container{font-family:'Inter',sans-serif;background:#EAF0F4;}
  .mapa-tooltip{background:var(--ink);color:#fff;border:none;border-radius:8px;padding:6px 10px;font-size:12px;font-weight:600;box-shadow:0 6px 16px rgba(0,0,0,.22);}
  .mapa-tooltip::before{border-top-color:var(--ink);}

  .mapa-pop h4{font-size:14px;font-weight:800;color:var(--ink);margin:0 0 2px;}
  .mapa-pop .mapa-pop-cve{font-size:10.5px;color:var(--ink-faint);font-family:'IBM Plex Mono',monospace;margin-bottom:8px;}
  .mapa-pop .mapa-pop-total{display:flex;align-items:center;gap:7px;font-size:13px;font-weight:700;color:var(--ink);margin-bottom:10px;}
  .mapa-pop .mapa-pop-total b{font-size:18px;font-family:'IBM Plex Mono',monospace;color:var(--purple);}
  .mapa-pop-list{display:flex;flex-direction:column;gap:6px;border-top:1px solid var(--line);padding-top:8px;}
  .mapa-pop-ev{display:flex;flex-direction:column;gap:1px;}
  .mapa-pop-ev .mapa-pop-ev-top{font-size:12px;font-weight:600;color:var(--ink);}
  .mapa-pop-ev .mapa-pop-ev-sub{font-size:10.5px;color:var(--ink-faint);}
  .mapa-pop-empty{font-size:11.5px;color:var(--ink-faint);font-style:italic;}

  .mapa-legend{background:#fff;padding:10px 12px;border-radius:10px;box-shadow:0 4px 14px rgba(0,0,0,.12);font-size:11.5px;color:var(--ink-soft);line-height:1.5;}
  .mapa-legend h5{font-size:11px;font-weight:800;color:var(--ink);margin:0 0 6px;text-transform:uppercase;letter-spacing:.03em;}
  .mapa-legend .mapa-legend-row{display:flex;align-items:center;gap:7px;}
  .mapa-legend .mapa-legend-sw{width:16px;height:16px;border-radius:4px;flex-shrink:0;border:1px solid rgba(0,0,0,.08);}

  .mapa-leyenda-inline{font-size:11.5px;color:var(--amber);font-weight:600;}
</style>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>
(function(){

  const BUCKETS = [
    {min:31, color:'#DC2626', label:'31 o más'},
    {min:16, color:'#F97316', label:'16 – 30'},
    {min:6,  color:'#FBBF24', label:'6 – 15'},
    {min:1,  color:'#FEF3C7', label:'1 – 5'},
    {min:0,  color:'#E9ECEF', label:'Sin eventos'}
  ];

  function colorFor(total){
    for(let i=0;i<BUCKETS.length;i++){
      if(total >= BUCKETS[i].min) return BUCKETS[i].color;
    }
    return '#E9ECEF';
  }

  function fmtFecha(d){
    if(!d) return '';
    const p = d.split('-');
    return (p.length===3) ? p[2]+'/'+p[1]+'/'+p[0] : d;
  }

  let mapa, capaGeo, datos = {conteo:{}, recientes:{}, sin_match:[]};

  function estilo(feature){
    const cve = feature.properties.CVEGEO;
    const total = (datos.conteo[cve] && datos.conteo[cve].total) ? datos.conteo[cve].total : 0;
    return {
      fillColor: colorFor(total),
      weight: 0.6,
      opacity: 1,
      color: '#ffffff',
      fillOpacity: 0.88
    };
  }

  function alResaltar(e){
    const l = e.target;
    l.setStyle({weight:2.5, color:'#1F2430', fillOpacity:0.95});
    l.bringToFront();
  }

  function alSalir(e){
    capaGeo.resetStyle(e.target);
  }

  function contenidoPopup(feature){
    const cve = feature.properties.CVEGEO;
    const nombre = feature.properties.NOMGEO;
    const total = (datos.conteo[cve] && datos.conteo[cve].total) ? datos.conteo[cve].total : 0;
    const evs = datos.recientes[cve] || [];

    let html = '<div class="mapa-pop">';
    html += '<h4>'+esc(nombre)+'</h4>';
    html += '<div class="mapa-pop-cve">Clave INEGI: '+esc(cve)+'</div>';
    html += '<div class="mapa-pop-total"><b>'+total+'</b> '+(total===1?'evento registrado':'eventos registrados')+'</div>';

    if(evs.length){
      html += '<div class="mapa-pop-list">';
      evs.forEach(ev=>{
        html += '<div class="mapa-pop-ev">';
        html += '<span class="mapa-pop-ev-top">'+esc(ev.tipo)+' · '+esc(ev.estatus)+'</span>';
        html += '<span class="mapa-pop-ev-sub">'+fmtFecha(ev.fecha)+(ev.responsable?' · '+esc(ev.responsable):'')+'</span>';
        html += '</div>';
      });
      html += '</div>';
    } else if(total===0){
      html += '<div class="mapa-pop-empty">Sin eventos en este municipio.</div>';
    }

    html += '</div>';
    return html;
  }

  function porCadaFeature(feature, layer){
    layer.bindTooltip(esc(feature.properties.NOMGEO), {sticky:true, className:'mapa-tooltip', direction:'top'});
    layer.bindPopup(contenidoPopup(feature), {maxWidth:260});
    layer.on({
      mouseover: alResaltar,
      mouseout: alSalir
    });
  }

  function agregarLeyenda(){
    const leyenda = L.control({position:'bottomright'});
    leyenda.onAdd = function(){
      const div = L.DomUtil.create('div', 'mapa-legend');
      let html = '<h5>Eventos por municipio</h5>';
      BUCKETS.forEach(b=>{
        html += '<div class="mapa-legend-row"><span class="mapa-legend-sw" style="background:'+b.color+'"></span> '+b.label+'</div>';
      });
      div.innerHTML = html;
      return div;
    };
    leyenda.addTo(mapa);
  }

  async function iniciar(){
    mapa = L.map('mapa-heat', {zoomControl:true, attributionControl:false, scrollWheelZoom:true});
    L.tileLayer('https://{s}.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}{r}.png', {maxZoom:12, minZoom:6}).addTo(mapa);

    let geojson, resp;
    try {
      const rGeo = await fetch(window.APP_URL + '/Oaxaca.min.json');
      geojson = await rGeo.json();
      const rData = await fetch(window.APP_URL + '/ajax/mapa.php?op=heat', {headers:{'X-Requested-With':'XMLHttpRequest'}});
      resp = await rData.json();
    } catch(err){
      document.getElementById('mapa-loading').innerHTML = '<span style="color:var(--red)">No se pudo cargar la cartografía.</span>';
      return;
    }

    if(resp && resp.ok){
      datos = {conteo: resp.conteo||{}, recientes: resp.recientes||{}, sin_match: resp.sin_match||[]};
      if(datos.sin_match.length){
        document.getElementById('mapa-sinmatch').textContent = datos.sin_match.length + ' registro(s) sin municipio reconocido (ver bitácora del servidor)';
      }
    }

    capaGeo = L.geoJSON(geojson, {style: estilo, onEachFeature: porCadaFeature}).addTo(mapa);
    mapa.fitBounds(capaGeo.getBounds(), {padding:[10,10]});
    agregarLeyenda();

    document.getElementById('mapa-loading').style.display = 'none';
  }

  window.addEventListener('load', iniciar);
})();
</script>
