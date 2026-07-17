<?php /* Vista: Eventos */ ?>
      <div class="form-panel" id="form-evento">
        <h3 id="form-evento-title">Nuevo evento</h3>
        <input type="hidden" id="e-id">
        <div class="form-grid">
          <div class="field"><label>Tipo</label>
            <select id="e-tipo"><option>Mitin</option><option>Reunión</option><option>Entrega de beneficios</option><option>Encuesta</option></select>
          </div>
          <div class="field"><label>Fecha</label><input type="date" id="e-fecha"></div>
          <div class="field"><label>Zona / colonia</label><input type="text" id="e-lugar" placeholder="Ej. Centro"></div>
          <div class="field"><label>Responsable</label><input type="text" id="e-responsable"></div>
          <div class="field"><label>Participantes estimados</label><input type="number" id="e-participantes" min="0" value="0"></div>
          <div class="field"><label>Estatus</label>
            <select id="e-estatus"><option>Programado</option><option>Realizado</option><option>Cancelado</option></select>
          </div>
          <div class="field full"><label>Descripción</label><textarea id="e-descripcion" placeholder="Detalles del evento"></textarea></div>
        </div>
        <div class="form-actions">
          <button class="btn btn-purple" id="e-guardar">Guardar evento</button>
          <button class="btn" id="e-cancelar">Cancelar</button>
        </div>
      </div>

      <div class="card table-wrap">
        <table>
          <thead><tr><th>Tipo</th><th>Fecha</th><th>Zona</th><th>Responsable</th><th>Participantes</th><th>Estatus</th><th>Descripción</th><th></th></tr></thead>
          <tbody id="eventos-tbody"></tbody>
        </table>
        <div class="empty-state" id="eventos-empty" style="display:none;">
          <div class="glyph">Sin eventos registrados</div>
          Agrega el primero con «Nuevo evento» arriba a la derecha.
        </div>
      </div>

<script>
let eventos = [];

const eForm = document.getElementById('form-evento');
function openEForm(){ clearEForm(); document.getElementById('form-evento-title').textContent='Nuevo evento'; eForm.classList.add('open'); eForm.scrollIntoView({behavior:'smooth'}); }
document.getElementById('e-cancelar').addEventListener('click', ()=> eForm.classList.remove('open'));
function clearEForm(){
  ['e-id','e-fecha','e-lugar','e-responsable','e-descripcion'].forEach(id=>document.getElementById(id).value='');
  document.getElementById('e-participantes').value=0; document.getElementById('e-tipo').value='Mitin'; document.getElementById('e-estatus').value='Programado';
}
document.getElementById('e-guardar').addEventListener('click', async ()=>{
  const id = document.getElementById('e-id').value || uid();
  const entry = {
    id, tipo: document.getElementById('e-tipo').value, fecha: document.getElementById('e-fecha').value,
    lugar: document.getElementById('e-lugar').value.trim(), responsable: document.getElementById('e-responsable').value.trim(),
    participantes: Number(document.getElementById('e-participantes').value)||0, estatus: document.getElementById('e-estatus').value,
    descripcion: document.getElementById('e-descripcion').value.trim()
  };
  if(!entry.lugar && !entry.fecha){ document.getElementById('e-lugar').focus(); return; }
  const idx = eventos.findIndex(x=>x.id===id);
  if(idx>-1) eventos[idx]=entry; else eventos.push(entry);
  await saveList('eventos:entries', eventos);
  eForm.classList.remove('open');
  renderEventos();
});
function editEvento(id){
  const e = eventos.find(x=>x.id===id); if(!e) return;
  document.getElementById('e-id').value=e.id; document.getElementById('e-tipo').value=e.tipo; document.getElementById('e-fecha').value=e.fecha||'';
  document.getElementById('e-lugar').value=e.lugar||''; document.getElementById('e-responsable').value=e.responsable||'';
  document.getElementById('e-participantes').value=e.participantes||0; document.getElementById('e-estatus').value=e.estatus;
  document.getElementById('e-descripcion').value=e.descripcion||'';
  document.getElementById('form-evento-title').textContent='Editar evento';
  eForm.classList.add('open'); eForm.scrollIntoView({behavior:'smooth'});
}
async function deleteEvento(id){
  if(!confirm('¿Eliminar este evento?')) return;
  eventos = eventos.filter(x=>x.id!==id); await saveList('eventos:entries', eventos); renderEventos();
}

function renderEventos(){
  const tbody = document.getElementById('eventos-tbody'); const empty = document.getElementById('eventos-empty');
  const sorted = [...eventos].sort((a,b)=> (b.fecha||'').localeCompare(a.fecha||''));
  if(sorted.length===0){ tbody.innerHTML=''; empty.style.display='block'; return; }
  empty.style.display='none';
  tbody.innerHTML = sorted.map(e=>`
    <tr>
      <td><strong>${esc(e.tipo)}</strong></td><td>${fmtDate(e.fecha)}</td><td>${esc(e.lugar)||'—'}</td>
      <td>${esc(e.responsable)||'—'}</td><td>${e.participantes}</td>
      <td><span class="badge s-${e.estatus}">${e.estatus}</span></td>
      <td style="max-width:240px;">${esc(e.descripcion)||'—'}</td>
      <td><div class="row-actions">
        <button class="icon-btn" onclick="editEvento('${e.id}')" title="Editar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4Z"/></svg></button>
        <button class="icon-btn" onclick="deleteEvento('${e.id}')" title="Eliminar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h18M8 6V4h8v2M19 6l-1 14H6L5 6"/></svg></button>
      </div></td>
    </tr>`).join('');
}

(async function initEventos(){
  eventos = await loadList('eventos:entries');
  renderEventos();
})();
</script>
