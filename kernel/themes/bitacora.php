<style>
    /* Estilos para el panel de filtros */
    .filters-panel { display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap; }
    .filters-panel input, .filters-panel select { padding: 8px; border: 1px solid #ccc; border-radius: 4px; background: #fff; }

    /* Paginador fuera del card */
    .pagination-wrapper { 
        display: flex; justify-content: center; align-items: center; 
        gap: 20px; margin-top: 20px; padding: 10px;
    }
    .btn-page { 
        display: flex; align-items: center; justify-content: center;
        background: #f0f0f0; border: none; border-radius: 8px; 
        padding: 8px; cursor: pointer; transition: 0.2s;
    }
    .btn-page:hover:not(:disabled) { background: #e0e0e0; }
    .btn-page:disabled { opacity: 0.3; cursor: not-allowed; }
    .page-info { font-size: 14px; font-weight: 600; color: #555; }
</style>

<!-- 1. PANEL DE FILTROS -->
<div class="filters-panel">
    <input type="text" id="f-search" placeholder="Buscar actividad..." oninput="applyFilters()" style="flex-grow: 1;">
    <select id="f-status" onchange="applyFilters()">
        <option value="Todos">Todos los estados</option>
        <option value="Pendiente">Pendiente</option>
        <option value="Proceso">Proceso</option>
        <option value="Terminada">Terminada</option>
    </select>
    <select id="f-prioridad" onchange="applyFilters()">
        <option value="Todos">Todas las prioridades</option>
        <option value="BAJA">Baja</option>
        <option value="MEDIA">Media</option>
        <option value="ALTA">Alta</option>
    </select>
</div>

<!-- 2. FORMULARIO (MODAL) -->
<div class="form-panel form-modal" id="form-bitacora">
    <div class="form-modal-box">
        <button type="button" class="form-modal-close" id="b-cerrar" aria-label="Cerrar">
            <svg viewBox="0 0 24 24" width="16" stroke="currentColor" fill="none" stroke-width="2"><path d="M18 6 6 18M6 6l12 12"/></svg>
        </button>
        <h3 id="form-bitacora-title">Nueva acción</h3>
        <input type="hidden" id="b-id">
        <div class="form-grid">
            <div class="field"><label>Fecha</label><input type="date" id="b-fecha"></div>
            <div class="field full"><label>Actividad</label><input type="text" id="b-actividad" placeholder="Ej. Reunión"></div>
            <div class="field"><label>Responsable</label><input type="text" id="b-responsable" placeholder="Nombre"></div>
            <div class="field"><label>Prioridad</label>
                <select id="b-prioridad"><option value="BAJA">Baja</option><option value="MEDIA">Media</option><option value="ALTA" selected>Alta</option></select>
            </div>
            <div class="field"><label>Fecha de inicio</label><input type="date" id="b-fecha-inicio"></div>
            <div class="field full"><label>Acuerdos</label><textarea id="b-acuerdos" placeholder="Acuerdos"></textarea></div>
            <div class="field"><label>Status</label>
                <select id="b-status"><option value="Pendiente">Pendiente</option><option value="Proceso">Proceso</option><option value="Terminada">Terminada</option></select>
            </div>
            <div class="field"><label>Avance (%)</label><input type="number" id="b-avance" min="0" max="100" value="0"></div>
            <div class="field"><label>Fecha de seguimiento</label><input type="date" id="b-seg-fecha"></div>
            <div class="field full"><label>Descripción de seguimiento</label><textarea id="b-seg-desc" placeholder="Seguimiento"></textarea></div>
            <div class="field full"><label>Próxima acción</label><input type="text" id="b-proxima" placeholder="Siguiente paso"></div>
        </div>
        <div class="form-actions">
            <button class="btn btn-purple" id="b-guardar">Guardar acción</button>
            <button class="btn" id="b-cancelar">Cancelar</button>
        </div>
    </div>
</div>

<!-- 3. TABLA -->
<div class="card table-wrap">
    <table>
        <thead><tr>
            <th>No.</th><th>Fecha</th><th>Actividad</th><th>Responsable</th><th>Prioridad</th>
            <th>Inicio</th><th>Acuerdos</th><th>Status</th><th>Avance</th><th>Seguimiento</th><th>Próxima acción</th><th></th>
        </tr></thead>
        <tbody id="bitacora-tbody"></tbody>
    </table>
    <div class="empty-state" id="bitacora-empty" style="display:none;">Sin acciones registradas</div>
</div>

<!-- 4. PAGINADOR (FUERA DEL CARD) -->
<div class="pagination-wrapper" id="pagination-controls"></div>

<script>
let bitacora = [];
let currentPage = 1;
const itemsPerPage = 10;
const bForm = document.getElementById('form-bitacora');

function openBForm(){ clearBForm(); document.getElementById('form-bitacora-title').textContent='Nueva acción'; bForm.classList.add('open'); }
function closeBForm(){ bForm.classList.remove('open'); }
document.getElementById('b-cancelar').addEventListener('click', closeBForm);
document.getElementById('b-cerrar').addEventListener('click', closeBForm);
bForm.addEventListener('click', (ev)=>{ if(ev.target === bForm) closeBForm(); });
document.addEventListener('keydown', (ev)=>{ if(ev.key === 'Escape' && bForm.classList.contains('open')) closeBForm(); });

function clearBForm(){
    ['b-id','b-fecha','b-actividad','b-responsable','b-fecha-inicio','b-acuerdos','b-avance','b-seg-fecha','b-seg-desc','b-proxima'].forEach(id=>document.getElementById(id).value='');
    document.getElementById('b-prioridad').value='ALTA'; document.getElementById('b-status').value='Pendiente'; document.getElementById('b-avance').value=0;
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
    const backup = bitacora.slice();
    if(idx>-1) bitacora[idx]=entry; else bitacora.push(entry);
    const ok = await saveList('bitacora:entries', bitacora);
    if(!ok){ bitacora = backup; renderBitacora(); return; }
    bitacora = await loadList('bitacora:entries');
    closeBForm(); renderBitacora();
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
    bForm.classList.add('open');
}

async function deleteBitacora(id){
    if(!confirm('¿Eliminar esta acción?')) return;
    const backup = bitacora.slice();
    bitacora = bitacora.filter(x=>x.id!==id);
    const ok = await saveList('bitacora:entries', bitacora);
    if(!ok){ bitacora = backup; renderBitacora(); return; }
    bitacora = await loadList('bitacora:entries');
    renderBitacora();
}

function applyFilters() { currentPage = 1; renderBitacora(); }
function changePage(delta) { currentPage += delta; renderBitacora(); }

function renderBitacora(){
    const tbody = document.getElementById('bitacora-tbody'); 
    const empty = document.getElementById('bitacora-empty');
    const pagControls = document.getElementById('pagination-controls');
    
    const search = document.getElementById('f-search')?.value.toLowerCase() || '';
    const statusFilter = document.getElementById('f-status')?.value || 'Todos';
    const prioFilter = document.getElementById('f-prioridad')?.value || 'Todos';

    let filtered = bitacora.filter(e => {
        const matchSearch = e.actividad.toLowerCase().includes(search) || e.responsable.toLowerCase().includes(search) || e.acuerdos.toLowerCase().includes(search);
        const matchStatus = statusFilter === 'Todos' || e.status === statusFilter;
        const matchPrio = prioFilter === 'Todos' || e.prioridad === prioFilter;
        return matchSearch && matchStatus && matchPrio;
    });

    const sorted = [...filtered].sort((a,b)=> (b.fecha||'').localeCompare(a.fecha||''));
    const totalPages = Math.ceil(sorted.length / itemsPerPage) || 1;
    const start = (currentPage - 1) * itemsPerPage;
    const paginated = sorted.slice(start, start + itemsPerPage);

    if(sorted.length === 0){ 
        tbody.innerHTML = ''; empty.style.display = 'block'; pagControls.innerHTML = ''; return; 
    }
    
    empty.style.display = 'none';
    tbody.innerHTML = paginated.map((e, i)=>`
        <tr>
            <td class="no-cell">${(start + i) + 1}</td>
            <td>${fmtDate(e.fecha)}</td>
            <td><strong>${esc(e.actividad)}</strong></td>
            <td>${esc(e.responsable)||'—'}</td>
            <td><span class="badge p-${e.prioridad}">${e.prioridad}</span></td>
            <td>${fmtDate(e.fechaInicio)}</td>
            <td style="max-width:180px;">${esc(e.acuerdos)||'—'}</td>
            <td><span class="badge s-${e.status}">${e.status}</span></td>
            <td><div class="progress"><i style="width:${e.avance}%"></i></div></td>
            <td>${e.segFecha? `<strong>${fmtDate(e.segFecha)}</strong><br>`:''}${esc(e.segDesc)||'—'}</td>
            <td>${esc(e.proxima)||'—'}</td>
            <td><div class="row-actions">
                <button class="icon-btn" onclick="editBitacora('${e.id}')"><svg viewBox="0 0 24 24" width="16" stroke="currentColor" fill="none" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4Z"/></svg></button>
                <button class="icon-btn" onclick="deleteBitacora('${e.id}')"><svg viewBox="0 0 24 24" width="16" stroke="currentColor" fill="none" stroke-width="2"><path d="M3 6h18M8 6V4h8v2M19 6l-1 14H6L5 6"/></svg></button>
            </div></td>
        </tr>`).join('');

    pagControls.innerHTML = `
        <button class="btn-page" ${currentPage === 1 ? 'disabled' : ''} onclick="changePage(-1)">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 18l-6-6 6-6"/></svg>
        </button>
        <span class="page-info">Pág. ${currentPage} de ${totalPages}</span>
        <button class="btn-page" ${currentPage >= totalPages ? 'disabled' : ''} onclick="changePage(1)">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 18l6-6-6-6"/></svg>
        </button>
    `;
}

document.addEventListener('DOMContentLoaded', async () => {
    bitacora = await loadList('bitacora:entries');
    renderBitacora();
});
</script>