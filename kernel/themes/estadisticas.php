<?php
// 1. Extraer datos de Bitácora directamente usando la conexión $db que ya existe
$db->query("SELECT * FROM campaign_bitacora ORDER BY fecha DESC, id DESC");
$db->execute();
$rowsBitacora = $db->resultSet();

$bitacoraData = array();
foreach( $rowsBitacora as $r ) {
    $bitacoraData[] = array(
        'id'          => $r['uid'],
        'fecha'       => $r['fecha'],
        'actividad'   => $r['actividad'],
        'responsable' => $r['responsable'],
        'prioridad'   => $r['prioridad'],
        'fechaInicio' => $r['fecha_inicio'],
        'acuerdos'    => $r['acuerdos'],
        'status'      => $r['status'],
        'avance'      => (int) $r['avance'],
        'segFecha'    => $r['seg_fecha'],
        'segDesc'     => $r['seg_desc'],
        'proxima'     => $r['proxima']
    );
}

// 2. Extraer datos de Eventos directamente
$db->query("SELECT * FROM campaign_eventos ORDER BY fecha DESC, id DESC");
$db->execute();
$rowsEventos = $db->resultSet();

$eventosData = array();
foreach( $rowsEventos as $r ) {
    $eventosData[] = array(
        'id'            => $r['uid'],
        'tipo'          => $r['tipo'],
        'fecha'         => $r['fecha'],
        'lugar'         => $r['lugar'],
        'responsable'   => $r['responsable'],
        'participantes' => (int) $r['participantes'],
        'estatus'       => $r['estatus'],
        'descripcion'   => $r['descripcion']
    );
}
?>

<!-- Importar Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
/* Estilos modernos para el Dashboard */
.dashboard-container { font-family: system-ui, -apple-system, sans-serif; color: #374151; }
.grid-4 { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; margin-bottom: 20px; }
.grid-2 { display: grid; grid-template-columns: repeat(auto-fit, minmax(450px, 1fr)); gap: 20px; margin-bottom: 20px; }
.card { background: #ffffff; border-radius: 10px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); padding: 20px; border: 1px solid #e5e7eb; }
.card-title { font-size: 1.1rem; font-weight: 600; margin-bottom: 15px; color: #6b7280; text-transform: uppercase; letter-spacing: 0.05em; }
.kpi-number { font-size: 2.5rem; font-weight: 800; color: #1B4D6B; }
.filtros { display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 20px; align-items: center; }
.filtros input, .filtros select { padding: 10px 15px; border: 1px solid #d1d5db; border-radius: 8px; outline: none; background: #f9fafb; transition: border-color 0.2s; }
.filtros input:focus, .filtros select:focus { border-color: #1B4D6B; }
.btn-filtrar { background: #1B4D6B; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-weight: 600; transition: background 0.2s; }
.btn-filtrar:hover { background: #113246; }
.chart-container { position: relative; height: 300px; width: 100%; }
.avance-container { display: flex; align-items: center; gap: 20px; height: 100%; justify-content: center; flex-direction: column; }
.avance-bar-bg { width: 100%; height: 20px; background: #e5e7eb; border-radius: 999px; overflow: hidden; }
.avance-bar-fill { height: 100%; background: #10b981; transition: width 0.5s ease-in-out; }
</style>

<div class="dashboard-container">
    <!-- Filtros -->
    <div class="card filtros">
        <input type="date" id="fDesde" title="Fecha Desde">
        <input type="date" id="fHasta" title="Fecha Hasta">

        <select id="fStatus">
            <option value="">Todos los status (Acciones)</option>
            <option value="Pendiente">Pendiente</option>
            <option value="Proceso">Proceso</option>
            <option value="Terminada">Terminada</option>
        </select>

        <select id="fPrioridad">
            <option value="">Todas las prioridades</option>
            <option value="ALTA">ALTA</option>
            <option value="MEDIA">MEDIA</option>
            <option value="BAJA">BAJA</option>
        </select>

        <select id="fResponsable">
            <option value="">Todos los responsables</option>
        </select>

        <button class="btn-filtrar" onclick="renderStats()">Aplicar Filtros</button>
    </div>

    <!-- KPIs -->
    <div class="grid-4">
        <div class="card">
            <div class="card-title">Total Acciones</div>
            <div id="kpiAcciones" class="kpi-number">0</div>
        </div>
        <div class="card">
            <div class="card-title">Acciones Terminadas</div>
            <div id="kpiTerminadas" class="kpi-number">0</div>
        </div>
        <div class="card">
            <div class="card-title">Total Eventos</div>
            <div id="kpiEventos" class="kpi-number">0</div>
        </div>
        <div class="card">
            <div class="card-title">Total Participantes</div>
            <div id="kpiParticipantes" class="kpi-number">0</div>
        </div>
    </div>

    <!-- Gráficas Principales -->
    <div class="grid-2">
        <div class="card">
            <div class="card-title">Acciones por Estatus</div>
            <div class="chart-container"><canvas id="chart-status"></canvas></div>
        </div>
        <div class="card">
            <div class="card-title">Acciones por Prioridad</div>
            <div class="chart-container"><canvas id="chart-prioridad"></canvas></div>
        </div>
    </div>

    <div class="grid-2">
        <div class="card">
            <div class="card-title">Avance Promedio Global</div>
            <div class="avance-container" id="chart-avance"></div>
        </div>
        <div class="card">
            <div class="card-title">Eventos por Tipo</div>
            <div class="chart-container"><canvas id="chart-eventos"></canvas></div>
        </div>
    </div>

    <div class="grid-2">
        <div class="card">
            <div class="card-title">Acciones por Responsable</div>
            <div class="chart-container"><canvas id="chart-responsables"></canvas></div>
        </div>
        <div class="card">
            <div class="card-title">Eventos por Responsable</div>
            <div class="chart-container"><canvas id="chart-eventos-resp"></canvas></div>
        </div>
    </div>

    <div class="grid-2">
        <div class="card">
            <div class="card-title">Eventos por Estatus</div>
            <div class="chart-container"><canvas id="chart-eventos-status"></canvas></div>
        </div>
        <div class="card">
            <div class="card-title">Acciones por Mes (Histórico)</div>
            <div class="chart-container"><canvas id="chart-meses"></canvas></div>
        </div>
    </div>
</div>

<script>
// 1. Inyectar datos de PHP
const bitacora = <?php echo json_encode($bitacoraData); ?>;
const eventos = <?php echo json_encode($eventosData); ?>;

// Variables globales para destruir gráficas previas al refiltrar
let chartInstances = {};

// Paleta de colores atractiva
const colorPalette = [
    '#1B4D6B', '#3b82f6', '#10b981', '#f59e0b', '#ef4444', 
    '#8b5cf6', '#14b8a6', '#f97316', '#6366f1', '#ec4899'
];

function popularResponsables() {
    const setResponsables = new Set();
    bitacora.forEach(b => { if(b.responsable) setResponsables.add(b.responsable); });
    eventos.forEach(e => { if(e.responsable) setResponsables.add(e.responsable); });

    const select = document.getElementById('fResponsable');
    [...setResponsables].sort().forEach(resp => {
        select.innerHTML += `<option value="${resp}">${resp}</option>`;
    });
}

// Función genérica para crear/actualizar gráficas con Chart.js
function drawChart(canvasId, type, dataObj, customColors = colorPalette, horizontal = false) {
    const ctx = document.getElementById(canvasId).getContext('2d');
    const labels = Object.keys(dataObj);
    const dataValues = Object.values(dataObj);

    // Si la gráfica ya existe, destrúyela para evitar superposición
    if (chartInstances[canvasId]) {
        chartInstances[canvasId].destroy();
    }

    const config = {
        type: type,
        data: {
            labels: labels,
            datasets: [{
                label: 'Cantidad',
                data: dataValues,
                backgroundColor: customColors,
                borderWidth: 1,
                borderRadius: (type === 'bar') ? 4 : 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            indexAxis: horizontal ? 'y' : 'x', // Para barras horizontales
            plugins: {
                legend: {
                    display: (type === 'pie' || type === 'doughnut'),
                    position: 'right'
                }
            },
            scales: (type === 'bar' || type === 'line') ? {
                y: { beginAtZero: true, ticks: { precision: 0 } },
                x: { beginAtZero: true, ticks: { precision: 0 } }
            } : {}
        }
    };

    chartInstances[canvasId] = new Chart(ctx, config);
}

function renderStats(){
    const fDesde = document.getElementById('fDesde').value;
    const fHasta = document.getElementById('fHasta').value;
    const fStatus = document.getElementById('fStatus').value;
    const fPrioridad = document.getElementById('fPrioridad').value;
    const fResponsable = document.getElementById('fResponsable').value;

    const bitacoraFiltrada = bitacora.filter(e => {
        if(fDesde && e.fecha < fDesde) return false;
        if(fHasta && e.fecha > fHasta) return false;
        if(fStatus && e.status !== fStatus) return false;
        if(fPrioridad && e.prioridad !== fPrioridad) return false;
        if(fResponsable && e.responsable !== fResponsable) return false;
        return true;
    });

    const eventosFiltrados = eventos.filter(e => {
        if(fDesde && e.fecha < fDesde) return false;
        if(fHasta && e.fecha > fHasta) return false;
        if(fResponsable && e.responsable !== fResponsable) return false;
        return true;
    });

    // Actualizar KPIs
    document.getElementById('kpiAcciones').innerText = bitacoraFiltrada.length;
    document.getElementById('kpiTerminadas').innerText = bitacoraFiltrada.filter(x => x.status === 'Terminada').length;
    document.getElementById('kpiEventos').innerText = eventosFiltrados.length;
    document.getElementById('kpiParticipantes').innerText = eventosFiltrados.reduce((s,e)=>s + Number(e.participantes||0), 0);

    // Procesar datos para gráficas
    const countStatus = {}; bitacoraFiltrada.forEach(e=>{ countStatus[e.status||'N/A'] = (countStatus[e.status||'N/A']||0)+1; });
    const countPrioridad = {}; bitacoraFiltrada.forEach(e=>{ countPrioridad[e.prioridad||'N/A'] = (countPrioridad[e.prioridad||'N/A']||0)+1; });
    const countRespAcc = {}; bitacoraFiltrada.forEach(e=>{ countRespAcc[e.responsable||'N/A'] = (countRespAcc[e.responsable||'N/A']||0)+1; });
    const countTiposEv = {}; eventosFiltrados.forEach(e=>{ countTiposEv[e.tipo||'N/A'] = (countTiposEv[e.tipo||'N/A']||0)+1; });
    const countRespEv = {}; eventosFiltrados.forEach(e=>{ countRespEv[e.responsable||'N/A'] = (countRespEv[e.responsable||'N/A']||0)+1; });
    const countStatusEv = {}; eventosFiltrados.forEach(e=>{ countStatusEv[e.estatus||'N/A'] = (countStatusEv[e.estatus||'N/A']||0)+1; });
    
    const countMeses = {}; 
    bitacoraFiltrada.forEach(e=>{
        const mes = (e.fecha || '').substring(0,7);
        if(mes) countMeses[mes] = (countMeses[mes]||0)+1;
    });
    // Ordenar los meses cronológicamente
    const mesesOrdenados = Object.keys(countMeses).sort().reduce((obj, key) => {
        obj[key] = countMeses[key]; return obj;
    }, {});

    // Dibujar Gráficas
    drawChart('chart-status', 'doughnut', countStatus, ['#10b981', '#f59e0b', '#ef4444', '#6b7280']);
    drawChart('chart-prioridad', 'bar', countPrioridad, ['#1B4D6B']);
    drawChart('chart-eventos', 'pie', countTiposEv, colorPalette);
    drawChart('chart-responsables', 'bar', countRespAcc, ['#3b82f6'], true); // true = Barra horizontal
    drawChart('chart-eventos-resp', 'bar', countRespEv, ['#8b5cf6'], true);
    drawChart('chart-eventos-status', 'doughnut', countStatusEv, ['#ef4444', '#10b981', '#6b7280']);
    drawChart('chart-meses', 'line', mesesOrdenados, ['#14b8a6']);

    // Avance Promedio (Barra personalizada mejorada)
    const avancePromedio = bitacoraFiltrada.length
        ? Math.round(bitacoraFiltrada.reduce((s,e)=>s+Number(e.avance||0), 0) / bitacoraFiltrada.length)
        : 0;

    let colorAvance = '#ef4444'; // Rojo si es bajo
    if(avancePromedio > 40) colorAvance = '#f59e0b'; // Naranja a la mitad
    if(avancePromedio > 80) colorAvance = '#10b981'; // Verde si está casi completo

    document.getElementById('chart-avance').innerHTML = `
        <div style="font-size:3rem; font-weight:800; color:${colorAvance};">${avancePromedio}%</div>
        <div class="avance-bar-bg">
            <div class="avance-bar-fill" style="width:${avancePromedio}%; background:${colorAvance};"></div>
        </div>
        <div style="color:#6b7280; margin-top:5px;">Basado en ${bitacoraFiltrada.length} acciones evaluadas</div>
    `;
}

// Inicializar
popularResponsables();
renderStats();
</script>