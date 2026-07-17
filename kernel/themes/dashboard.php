<?php /* Vista: Panel general (dashboard) */ ?>
      <div class="kpi-grid">
        <div class="card kpi">
          <div class="kpi-top"><div class="kpi-icon" style="background:var(--purple-soft)"><svg viewBox="0 0 24 24" fill="none" stroke="var(--purple-dark)" stroke-width="2"><path d="M9 2h6l1 3H8l1-3Z"/><rect x="4" y="5" width="16" height="17" rx="2"/><path d="M8 11h8M8 15h8"/></svg></div><span class="kpi-tag">Total</span></div>
          <div class="num" id="kpi-total">0</div>
          <div class="label">Acciones registradas</div>
          <svg class="spark" id="spark-1" viewBox="0 0 200 34" preserveAspectRatio="none"></svg>
        </div>
        <div class="card kpi">
          <div class="kpi-top"><div class="kpi-icon" style="background:var(--green-soft)"><svg viewBox="0 0 24 24" fill="none" stroke="var(--green)" stroke-width="2"><path d="M20 6 9 17l-5-5"/></svg></div><span class="kpi-tag">Hoy</span></div>
          <div class="num" id="kpi-terminadas">0</div>
          <div class="label">Acciones terminadas</div>
          <svg class="spark" id="spark-2" viewBox="0 0 200 34" preserveAspectRatio="none"></svg>
        </div>
        <div class="card kpi">
          <div class="kpi-top"><div class="kpi-icon" style="background:var(--red-soft)"><svg viewBox="0 0 24 24" fill="none" stroke="var(--red)" stroke-width="2"><path d="M12 9v4M12 17h.01"/><path d="M10.3 3.9 1.8 18a2 2 0 0 0 1.7 3h17a2 2 0 0 0 1.7-3L13.7 3.9a2 2 0 0 0-3.4 0Z"/></svg></div><span class="kpi-tag">Urgente</span></div>
          <div class="num" id="kpi-altas">0</div>
          <div class="label">Prioridad alta pendiente</div>
          <svg class="spark" id="spark-3" viewBox="0 0 200 34" preserveAspectRatio="none"></svg>
        </div>
        <div class="card kpi">
          <div class="kpi-top"><div class="kpi-icon" style="background:var(--violet-soft)"><svg viewBox="0 0 24 24" fill="none" stroke="var(--violet)" stroke-width="2"><rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 10h18M8 3v4M16 3v4"/></svg></div><span class="kpi-tag">Agenda</span></div>
          <div class="num" id="kpi-eventos">0</div>
          <div class="label">Eventos programados</div>
          <svg class="spark" id="spark-4" viewBox="0 0 200 34" preserveAspectRatio="none"></svg>
        </div>
      </div>

      <div class="grid-2">
        <div class="card card-pad">
          <div class="card-title">Pulso de campaña</div>
          <div class="card-sub">Acciones y eventos registrados por día — últimos 14 días</div>
          <svg id="pulse-svg" viewBox="0 0 640 130" preserveAspectRatio="none" style="width:100%;height:150px;margin-top:8px;"></svg>
        </div>
        <div class="card card-pad">
          <div class="card-title">Distribución de acciones</div>
          <div class="card-sub">Por status actual</div>
          <div class="donut-wrap" style="margin-top:12px;">
            <svg viewBox="0 0 120 120" width="120" height="120" id="donut-svg"></svg>
            <div class="donut-legend" id="donut-legend"></div>
          </div>
        </div>
      </div>

      <div class="grid-2">
        <div class="card card-pad">
          <div class="card-title">Actividad reciente</div>
          <div id="actividad-reciente" style="margin-top:8px;"></div>
        </div>
        <div class="card card-pad">
          <div class="card-title">Próximos eventos</div>
          <div id="proximos-eventos" style="margin-top:8px;"></div>
        </div>
      </div>

<script>
let bitacora = [], eventos = [];

function sparkPath(counts, w, h){
  const max = Math.max(1, ...counts);
  const step = w/(counts.length-1);
  return counts.map((c,i)=>`${i*step},${h-(c/max)*(h-4)-2}`).join(' ');
}

function renderDashboard(){
  document.getElementById('kpi-total').textContent = bitacora.length;
  document.getElementById('kpi-terminadas').textContent = bitacora.filter(e=>e.status==='Terminada').length;
  document.getElementById('kpi-altas').textContent = bitacora.filter(e=>e.prioridad==='ALTA' && e.status!=='Terminada').length;
  document.getElementById('kpi-eventos').textContent = eventos.filter(e=>e.estatus==='Programado').length;

  const days = []; const today = new Date();
  for(let i=13;i>=0;i--){ const d = new Date(today); d.setDate(d.getDate()-i); days.push(d.toISOString().slice(0,10)); }
  const counts = days.map(d => bitacora.filter(e=>e.fecha===d).length + eventos.filter(e=>e.fecha===d).length);

  const sparkColors = {1:'#1B4D6B',2:'#1EAE6D',3:'#EF4444',4:'#2E7A8C'};
  [1,2,3,4].forEach(n=>{
    const svg = document.getElementById('spark-'+n);
    const pts = sparkPath(counts, 200, 34);
    const areaPts = `0,34 ${pts} 200,34`;
    svg.innerHTML = `<polygon points="${areaPts}" fill="${sparkColors[n]}" opacity="0.12"/><polyline points="${pts}" fill="none" stroke="${sparkColors[n]}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>`;
  });

  const max = Math.max(1, ...counts);
  const w=640,h=130,step=w/(days.length-1);
  const pts = counts.map((c,i)=>`${i*step},${h-14-(c/max)*(h-30)}`).join(' ');
  const areaPts = `0,${h-8} ${pts} ${w},${h-8}`;
  document.getElementById('pulse-svg').innerHTML = `
    <polygon points="${areaPts}" fill="#1B4D6B" opacity="0.08"/>
    <polyline points="${pts}" fill="none" stroke="#1B4D6B" stroke-width="2.4" stroke-linejoin="round" stroke-linecap="round"/>
    ${counts.map((c,i)=> c>0 ? `<circle cx="${i*step}" cy="${h-14-(c/max)*(h-30)}" r="3" fill="#0F3650"/>` : '').join('')}
    <line x1="0" y1="${h-6}" x2="${w}" y2="${h-6}" stroke="#ECEDF3" stroke-width="1"/>
  `;

  const statusCounts = {Pendiente:0,Proceso:0,Terminada:0};
  bitacora.forEach(e=> statusCounts[e.status] = (statusCounts[e.status]||0)+1);
  const total = bitacora.length || 1;
  const colors = {Pendiente:'#9CA3AF',Proceso:'#F5A524',Terminada:'#1EAE6D'};
  let offset = 0; const r=50, C=2*Math.PI*r;
  const segs = Object.entries(statusCounts).map(([k,v])=>{
    const frac = v/total; const dash = frac*C;
    const seg = `<circle cx="60" cy="60" r="${r}" fill="none" stroke="${colors[k]}" stroke-width="14" stroke-dasharray="${dash} ${C-dash}" stroke-dashoffset="${-offset}" transform="rotate(-90 60 60)"/>`;
    offset += dash; return seg;
  }).join('');
  document.getElementById('donut-svg').innerHTML = `${segs}<text x="60" y="56" text-anchor="middle" font-size="20" font-weight="800" fill="#1F2430" font-family="Inter">${bitacora.length}</text><text x="60" y="72" text-anchor="middle" font-size="9" fill="#9CA3AF" font-family="Inter">acciones</text>`;
  document.getElementById('donut-legend').innerHTML = Object.entries(statusCounts).map(([k,v])=>`
    <div class="legend-item"><div class="legend-left"><span class="legend-dot" style="background:${colors[k]}"></span>${k}</div><span class="legend-val">${v}</span></div>`).join('');

  const recent = [...bitacora].sort((a,b)=>(b.fecha||'').localeCompare(a.fecha||'')).slice(0,5);
  const dotColor = {Pendiente:'#9CA3AF',Proceso:'#F5A524',Terminada:'#1EAE6D'};
  document.getElementById('actividad-reciente').innerHTML = recent.length ? recent.map(e=>`
    <div class="list-item"><span class="list-dot" style="background:${dotColor[e.status]}"></span>
      <div><div class="t1">${esc(e.actividad)}</div><div class="t2">${esc(e.responsable)||'Sin responsable'}</div></div>
      <span class="t3">${fmtDate(e.fecha)}</span></div>`).join('') : '<div class="empty-state" style="padding:16px;">Sin actividad registrada aún.</div>';

  const upcoming = [...eventos].filter(e=>e.estatus==='Programado').sort((a,b)=>(a.fecha||'').localeCompare(b.fecha||'')).slice(0,5);
  document.getElementById('proximos-eventos').innerHTML = upcoming.length ? upcoming.map(e=>`
    <div class="list-item"><span class="list-dot" style="background:#2E7A8C"></span>
      <div><div class="t1">${esc(e.tipo)}</div><div class="t2">${esc(e.lugar)||'Sin zona definida'}</div></div>
      <span class="t3">${fmtDate(e.fecha)}</span></div>`).join('') : '<div class="empty-state" style="padding:16px;">No hay eventos programados.</div>';
}

(async function initDashboard(){
  bitacora = await loadList('bitacora:entries');
  eventos = await loadList('eventos:entries');
  renderDashboard();
})();
</script>
