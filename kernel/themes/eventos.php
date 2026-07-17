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
    <input type="text" id="f-search" placeholder="Buscar tipo, zona o responsable..." oninput="applyFilters()" style="flex-grow: 1;">
    <select id="f-tipo" onchange="applyFilters()">
        <option value="Todos">Todos los tipos</option>
        <option>Mitin</option><option>Reunión</option><option>Entrega de beneficios</option><option>Encuesta</option>
    </select>
    <select id="f-estatus" onchange="applyFilters()">
        <option value="Todos">Todos los estados</option>
        <option>Programado</option><option>Realizado</option><option>Cancelado</option>
    </select>
</div>

<!-- 2. FORMULARIO -->
<div class="form-panel" id="form-evento">
    <h3 id="form-evento-title">Nuevo evento</h3>
    <input type="hidden" id="e-id">
    <div class="form-grid">
        <div class="field"><label>Tipo</label>
            <select id="e-tipo"><option>Mitin</option><option>Reunión</option><option>Entrega de beneficios</option><option>Encuesta</option></select>
        </div>
        <div class="field"><label>Fecha</label><input type="date" id="e-fecha"></div>
        <div class="field">
            <label>Zona / colonia</label>
            <div class="zona-ac-wrap" id="zona-ac-wrap">
                <input type="text" id="e-lugar" placeholder="Ej. Centro" autocomplete="off">
                <ul class="zona-ac-list" id="zona-ac-list"></ul>
            </div>
        </div>
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

<!-- 3. TABLA -->
<div class="card table-wrap">
    <table>
        <thead><tr>
            <th>Tipo</th><th>Fecha</th><th>Zona</th><th>Responsable</th><th>Participantes</th><th>Estatus</th><th>Descripción</th><th></th>
        </tr></thead>
        <tbody id="eventos-tbody"></tbody>
    </table>
    <div class="empty-state" id="eventos-empty" style="display:none;">Sin eventos registrados</div>
</div>

<!-- 4. PAGINADOR (FUERA DEL CARD) -->
<div class="pagination-wrapper" id="pagination-controls"></div>

<script>
let eventos = [];
let currentPage = 1;
const itemsPerPage = 10;
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
    const idx = eventos.findIndex(x=>x.id===id);
    if(idx>-1) eventos[idx]=entry; else eventos.push(entry);
    await saveList('eventos:entries', eventos);
    eForm.classList.remove('open'); renderEventos();
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

function applyFilters() { currentPage = 1; renderEventos(); }
function changePage(delta) { currentPage += delta; renderEventos(); }

function renderEventos(){
    const tbody = document.getElementById('eventos-tbody'); 
    const empty = document.getElementById('eventos-empty');
    const pagControls = document.getElementById('pagination-controls');
    
    const search = document.getElementById('f-search')?.value.toLowerCase() || '';
    const tipoFilter = document.getElementById('f-tipo')?.value || 'Todos';
    const statusFilter = document.getElementById('f-estatus')?.value || 'Todos';

    let filtered = eventos.filter(e => {
        const matchSearch = e.tipo.toLowerCase().includes(search) || e.lugar.toLowerCase().includes(search) || e.responsable.toLowerCase().includes(search);
        const matchTipo = tipoFilter === 'Todos' || e.tipo === tipoFilter;
        const matchStatus = statusFilter === 'Todos' || e.estatus === statusFilter;
        return matchSearch && matchTipo && matchStatus;
    });

    const sorted = [...filtered].sort((a,b)=> (b.fecha||'').localeCompare(a.fecha||''));
    const totalPages = Math.ceil(sorted.length / itemsPerPage) || 1;
    const start = (currentPage - 1) * itemsPerPage;
    const paginated = sorted.slice(start, start + itemsPerPage);

    if(sorted.length === 0){ 
        tbody.innerHTML = ''; empty.style.display = 'block'; pagControls.innerHTML = ''; return; 
    }
    
    empty.style.display = 'none';
    tbody.innerHTML = paginated.map(e=>`
        <tr>
            <td><strong>${esc(e.tipo)}</strong></td><td>${fmtDate(e.fecha)}</td><td>${esc(e.lugar)||'—'}</td>
            <td>${esc(e.responsable)||'—'}</td><td>${e.participantes}</td>
            <td><span class="badge s-${e.estatus}">${e.estatus}</span></td>
            <td style="max-width:240px;">${esc(e.descripcion)||'—'}</td>
            <td><div class="row-actions">
                <button class="icon-btn" onclick="editEvento('${e.id}')"><svg viewBox="0 0 24 24" width="16" stroke="currentColor" fill="none" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4Z"/></svg></button>
                <button class="icon-btn" onclick="deleteEvento('${e.id}')"><svg viewBox="0 0 24 24" width="16" stroke="currentColor" fill="none" stroke-width="2"><path d="M3 6h18M8 6V4h8v2M19 6l-1 14H6L5 6"/></svg></button>
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

// Lógica de Autocomplete Zonas (Mantenida)
// ... (Aquí iría tu código existente de inicializarAutocompleteZonas, ya que está integrado) ...

document.addEventListener('DOMContentLoaded', async () => {
    eventos = await loadList('eventos:entries');
    renderEventos();
    // Se asume que esta función existe en tu entorno
    if(typeof inicializarAutocompleteZonas === 'function') inicializarAutocompleteZonas();
});
</script>