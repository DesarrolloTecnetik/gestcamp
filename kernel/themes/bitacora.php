<?php /* Vista: Bitácora de acciones */ ?>
      <div class="form-panel" id="form-bitacora">
        <h3 id="form-bitacora-title">Nueva acción</h3>
        <input type="hidden" id="b-id">
        <div class="form-grid">
          <div class="field"><label>Fecha</label><input type="date" id="b-fecha"></div>
          <div class="field full"><label>Actividad</label><input type="text" id="b-actividad" placeholder="Ej. Reunión de trabajo"></div>
          <div class="field"><label>Responsable</label><input type="text" id="b-responsable" placeholder="Nombre"></div>
          <div class="field"><label>Prioridad</label>
            <select id="b-prioridad"><option value="BAJA">Baja</option><option value="MEDIA">Media</option><option value="ALTA" selected>Alta</option></select>
          </div>
          <div class="field"><label>Fecha de inicio</label><input type="date" id="b-fecha-inicio"></div>
          <div class="field full"><label>Acuerdos</label><textarea id="b-acuerdos" placeholder="Acuerdos tomados"></textarea></div>
          <div class="field"><label>Status</label>
            <select id="b-status"><option value="Pendiente">Pendiente</option><option value="Proceso">Proceso</option><option value="Terminada">Terminada</option></select>
          </div>
          <div class="field"><label>Avance (%)</label><input type="number" id="b-avance" min="0" max="100" value="0"></div>
          <div class="field"><label>Fecha de seguimiento</label><input type="date" id="b-seg-fecha"></div>
          <div class="field full"><label>Descripción de seguimiento</label><textarea id="b-seg-desc" placeholder="Ej. Presenta la agenda terminada"></textarea></div>
          <div class="field full"><label>Próxima acción</label><input type="text" id="b-proxima" placeholder="Siguiente paso"></div>
        </div>
        <div class="form-actions">
          <button class="btn btn-purple" id="b-guardar">Guardar acción</button>
          <button class="btn" id="b-cancelar">Cancelar</button>
        </div>
      </div>

      <div class="card table-wrap">
        <table>
          <thead><tr>
            <th>No.</th><th>Fecha</th><th>Actividad</th><th>Responsable</th><th>Prioridad</th>
            <th>Inicio</th><th>Acuerdos</th><th>Status</th><th>Avance</th><th>Seguimiento</th><th>Próxima acción</th><th></th>
          </tr></thead>
          <tbody id="bitacora-tbody"></tbody>
        </table>
        <div class="empty-state" id="bitacora-empty" style="display:none;">
          <div class="glyph">Sin acciones registradas</div>
          Agrega la primera con «Nueva acción» arriba a la derecha.
        </div>
      </div>

<script>
let bitacora = [];

const bForm = document.getElementById('form-bitacora');
function openBForm(){ clearBForm(); document.getElementById('form-bitacora-title').textContent='Nueva acción'; bForm.classList.add('open'); bForm.scrollIntoView({behavior:'smooth'}); }
document.getElementById('b-cancelar').addEventListener('click', ()=> bForm.classList.remove('open'));
function clearBForm(){
  ['b-id','b-fecha','b-actividad','b-responsable','b-fecha-inicio','b-acuerdos','b-avance','b-seg-fecha','b-seg-desc','b-proxima'].forEach(id=>document.getElementById(id).value='');
  document.getElementById('b-prioridad').value='ALTA';
  document.getElementById('b-status').value='Pendiente';
  document.getElementById('b-avance').value=0;
}
document.getElementById('b-guardar').addEventListener('click', async ()=>{
  const id = document.getElementById('b-id').value || uid();
  const entry = {
    id, fecha: document.getElementById('b-fecha').value, actividad: document.getElementById('b-actividad').value.trim(),
    responsable: document.getElementById('b-responsable').value.trim(), prioridad: document.getElementById('b-prioridad').value,
    fechaInicio: document.getElementById('b-fecha-inicio').value, acuerdos: document.getElementById('b-acuerdos').value.trim(),
    status: document.getElementById('b-status').value, avance: Math.max(0, Math.min(100, Number(document.getElementById('b-avance').value)||0)),
    segFecha: document.getElementById('b-seg-fecha').value, segDesc: document.getElementById('b-seg-desc').value.trim(),
    proxima: document.getElementById('b-proxima').value.trim()
  };
  if(!entry.actividad){ document.getElementById('b-actividad').focus(); return; }
  const idx = bitacora.findIndex(x=>x.id===id);
  if(idx>-1) bitacora[idx]=entry; else bitacora.push(entry);
  await saveList('bitacora:entries', bitacora);
  bForm.classList.remove('open');
  renderBitacora();
});
function editBitacora(id){
  const e = bitacora.find(x=>x.id===id); if(!e) return;
  document.getElementById('b-id').value=e.id; document.getElementById('b-fecha').value=e.fecha||'';
  document.getElementById('b-actividad').value=e.actividad||''; document.getElementById('b-responsable').value=e.responsable||'';
  document.getElementById('b-prioridad').value=e.prioridad||'ALTA'; document.getElementById('b-fecha-inicio').value=e.fechaInicio||'';
  document.getElementById('b-acuerdos').value=e.acuerdos||''; document.getElementById('b-status').value=e.status||'Pendiente';
  document.getElementById('b-avance').value=e.avance||0; document.getElementById('b-seg-fecha').value=e.segFecha||'';
  document.getElementById('b-seg-desc').value=e.segDesc||''; document.getElementById('b-proxima').value=e.proxima||'';
  document.getElementById('form-bitacora-title').textContent='Editar acción';
  bForm.classList.add('open'); bForm.scrollIntoView({behavior:'smooth'});
}
async function deleteBitacora(id){
  if(!confirm('¿Eliminar esta acción de la bitácora?')) return;
  bitacora = bitacora.filter(x=>x.id!==id); await saveList('bitacora:entries', bitacora); renderBitacora();
}

function renderBitacora(){
  const tbody = document.getElementById('bitacora-tbody'); const empty = document.getElementById('bitacora-empty');
  const sorted = [...bitacora].sort((a,b)=> (b.fecha||'').localeCompare(a.fecha||''));
  if(sorted.length===0){ tbody.innerHTML=''; empty.style.display='block'; return; }
  empty.style.display='none';
  tbody.innerHTML = sorted.map((e,i)=>`
    <tr>
      <td class="no-cell">${sorted.length-i}</td>
      <td>${fmtDate(e.fecha)}</td>
      <td><strong>${esc(e.actividad)}</strong></td>
      <td>${esc(e.responsable)||'—'}</td>
      <td><span class="badge p-${e.prioridad}">${e.prioridad}</span></td>
      <td>${fmtDate(e.fechaInicio)}</td>
      <td style="max-width:180px;">${esc(e.acuerdos)||'—'}</td>
      <td><span class="badge s-${e.status}">${e.status}</span></td>
      <td><div class="progress"><i style="width:${e.avance}%"></i></div><span style="font-size:10.5px;color:var(--ink-faint)">${e.avance}%</span></td>
      <td style="max-width:170px;">${e.segFecha? `<strong>${fmtDate(e.segFecha)}</strong><br>`:''}${esc(e.segDesc)||'—'}</td>
      <td style="max-width:150px;">${esc(e.proxima)||'—'}</td>
      <td><div class="row-actions">
        <button class="icon-btn" onclick="editBitacora('${e.id}')" title="Editar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4Z"/></svg></button>
        <button class="icon-btn" onclick="deleteBitacora('${e.id}')" title="Eliminar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h18M8 6V4h8v2M19 6l-1 14H6L5 6"/></svg></button>
      </div></td>
    </tr>`).join('');
}

(async function initBitacora(){
  bitacora = await loadList('bitacora:entries');
  renderBitacora();
})();
</script>
