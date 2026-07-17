<?php /* Vista: Estadísticas */ ?>
      <div class="grid-2">
        <div class="card card-pad">
          <div class="card-title">Acciones por status</div>
          <div id="chart-status" style="margin-top:12px;"></div>
        </div>
        <div class="card card-pad">
          <div class="card-title">Acciones por prioridad</div>
          <div id="chart-prioridad" style="margin-top:12px;"></div>
        </div>
      </div>
      <div class="grid-2">
        <div class="card card-pad">
          <div class="card-title">Eventos por tipo</div>
          <div id="chart-eventos" style="margin-top:12px;"></div>
        </div>
        <div class="card card-pad">
          <div class="card-title">Avance promedio de acciones</div>
          <div id="chart-avance" style="margin-top:12px;"></div>
        </div>
      </div>

<script>
let bitacora = [], eventos = [];

function bar(label, val, max, color){
  const pct = max>0 ? (val/max*100) : 0;
  return `<div class="bar-row"><div class="bar-label">${label}</div><div class="bar-track"><div class="bar-fill" style="width:${pct}%;background:${color}"></div></div><div class="bar-val">${val}</div></div>`;
}
function renderStats(){
  const statusCounts = {Pendiente:0,Proceso:0,Terminada:0};
  bitacora.forEach(e=> statusCounts[e.status] = (statusCounts[e.status]||0)+1);
  const maxS = Math.max(1,...Object.values(statusCounts));
  document.getElementById('chart-status').innerHTML =
    bar('Pendiente', statusCounts.Pendiente, maxS, '#9CA3AF') + bar('Proceso', statusCounts.Proceso, maxS, '#F5A524') + bar('Terminada', statusCounts.Terminada, maxS, '#1EAE6D');

  const prioCounts = {ALTA:0,MEDIA:0,BAJA:0};
  bitacora.forEach(e=> prioCounts[e.prioridad] = (prioCounts[e.prioridad]||0)+1);
  const maxP = Math.max(1,...Object.values(prioCounts));
  document.getElementById('chart-prioridad').innerHTML =
    bar('Alta', prioCounts.ALTA, maxP, '#EF4444') + bar('Media', prioCounts.MEDIA, maxP, '#F5A524') + bar('Baja', prioCounts.BAJA, maxP, '#1EAE6D');

  const tipoCounts = {};
  eventos.forEach(e=> tipoCounts[e.tipo] = (tipoCounts[e.tipo]||0)+1);
  const maxT = Math.max(1,...Object.values(tipoCounts), 1);
  document.getElementById('chart-eventos').innerHTML = Object.keys(tipoCounts).length
    ? Object.entries(tipoCounts).map(([k,v])=>bar(k,v,maxT,'#1B4D6B')).join('')
    : '<div class="empty-state" style="padding:14px;">Sin eventos registrados.</div>';

  const avgAvance = bitacora.length ? Math.round(bitacora.reduce((s,e)=>s+(e.avance||0),0)/bitacora.length) : 0;
  document.getElementById('chart-avance').innerHTML = `
    <div style="display:flex;align-items:center;gap:16px;">
      <div style="font-size:34px;font-weight:800;">${avgAvance}%</div>
      <div class="bar-track" style="flex:1;height:12px;"><div class="bar-fill" style="width:${avgAvance}%;background:#1B4D6B;"></div></div>
    </div>
    <p style="color:var(--ink-faint);font-size:12px;margin-top:10px;">Promedio de avance sobre ${bitacora.length} acción(es) registradas.</p>`;
}

(async function initEstadisticas(){
  bitacora = await loadList('bitacora:entries');
  eventos = await loadList('eventos:entries');
  renderStats();
})();
</script>
