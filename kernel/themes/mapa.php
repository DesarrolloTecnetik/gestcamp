<div class="map-toolbar">
  <div class="map-note">Representación esquemática por zona (no es un mapa geográfico real). Combina eventos reales registrados con una simulación de referencia.</div>
  <div class="legend-scale">Menos actividad <span class="legend-grad"></span> Más actividad</div>
</div>
<div class="card" style="padding:18px;">
  <div class="map-svg-wrap">
    <svg id="heat-svg" viewBox="0 0 640 380" style="width:100%;height:auto;display:block;"></svg>
  </div>
</div>
<div style="margin-top:10px;font-size:11.5px;color:var(--ink-faint);display:flex;align-items:center;gap:6px;">
  <span style="width:9px;height:9px;border-radius:50%;border:2px dashed #1EAE6D;display:inline-block;"></span>
  Contorno verde = zona con eventos reales registrados
</div>

<script>
let eventos = [];

const ZONES = [
  {name:'Centro', cx:120, cy:80, shape:'M70,60 L150,50 L170,110 L110,130 L60,100 Z'},
  {name:'Chapultepec', cx:300, cy:70, shape:'M250,40 L330,45 L340,100 L270,115 L240,80 Z'},
  {name:'Providencia', cx:470, cy:90, shape:'M420,50 L500,55 L520,110 L450,130 L410,95 Z'},
  {name:'Las Águilas', cx:110, cy:220, shape:'M55,170 L140,165 L155,225 L95,260 L45,225 Z'},
  {name:'Tesistán', cx:300, cy:210, shape:'M250,165 L340,160 L360,215 L295,255 L240,220 Z'},
  {name:'La Estancia', cx:480, cy:230, shape:'M425,175 L515,170 L535,225 L465,265 L410,225 Z'},
  {name:'Ciudad Granja', cx:130, cy:330, shape:'M65,290 L155,285 L170,340 L110,365 L55,335 Z'},
  {name:'Base Aérea', cx:310, cy:330, shape:'M255,285 L345,280 L360,335 L300,365 L245,335 Z'},
  {name:'El Colli', cx:490, cy:320, shape:'M430,285 L520,280 L540,330 L475,360 L420,325 Z'}
];
let simValues = {};
function hashStr(s){ let h=0; for(let i=0;i<s.length;i++) h = (h*31 + s.charCodeAt(i)) % 97; return h; }
function regenSim(){
  const seed = Date.now();
  ZONES.forEach((z,i)=>{
    simValues[z.name] = Math.round(3 + (Math.abs(Math.sin(seed*0.00001 + hashStr(z.name) + i))*10));
  });
}
regenSim();

function mixColor(t){
  const a=[238,236,252], b=[78,31,168];
  const c = a.map((v,i)=> Math.round(v + (b[i]-v)*t));
  return `rgb(${c[0]},${c[1]},${c[2]})`;
}

function renderHeatmap(){
  const realCounts = {};
  eventos.forEach(e=>{
    const z = (e.lugar||'').trim().toLowerCase();
    if(!z) return;
    ZONES.forEach(zone=>{ if(zone.name.toLowerCase().includes(z) || z.includes(zone.name.toLowerCase())){ realCounts[zone.name] = (realCounts[zone.name]||0)+1; } });
  });
  const values = ZONES.map(z => ({...z, count: realCounts[z.name] || simValues[z.name] || 1, isReal: !!realCounts[z.name]}));
  const max = Math.max(...values.map(v=>v.count));
  const svg = document.getElementById('heat-svg');
  svg.innerHTML = values.map(z=>{
    const t = z.count/max;
    const fill = mixColor(t);
    const textColor = t>0.55 ? '#fff' : '#3E3560';
    return `<g>
      <path d="${z.shape}" class="zone-shape" fill="${fill}" ${z.isReal ? 'stroke="#1EAE6D" stroke-width="3"' : ''}></path>
      <text x="${z.cx}" y="${z.cy-2}" text-anchor="middle" class="zone-label" fill="${textColor}">${esc(z.name)}</text>
      <text x="${z.cx}" y="${z.cy+13}" text-anchor="middle" class="zone-count" fill="${textColor}">${z.count} ${z.isReal?'eventos':'(simulado)'}</text>
    </g>`;
  }).join('');
}

(async function initMapa(){
  eventos = await loadList('eventos:entries');
  renderHeatmap();
})();
</script>