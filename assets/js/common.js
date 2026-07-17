/* ==========================================================================
   Plataforma de Gestión de Campaña — helpers comunes
   Sustituye el window.storage del prototipo por persistencia real en MySQL
   a través de los endpoints en /ajax/{entidad}.php
   ========================================================================== */

const uid = () => Date.now().toString(36) + Math.random().toString(36).slice(2, 6);

function esc(s) {
  return (s || '').toString().replace(/[&<>"']/g, c => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
  }[c]));
}

function fmtDate(d) {
  if (!d) return '—';
  const [y, m, day] = d.split('-');
  return day && m && y ? `${day}/${m}/${y}` : d;
}

/* Mapa de llaves lógicas (heredadas del prototipo) -> endpoint ajax real */
const STORAGE_ENTITY = {
  'bitacora:entries': 'bitacora',
  'eventos:entries': 'eventos',
  'brm:entries': 'brm'
};

/**
 * Carga la lista completa de una entidad desde la base de datos.
 * @param {string} key p.ej. 'bitacora:entries'
 * @returns {Promise<Array>}
 */
async function loadList(key) {
  const entity = STORAGE_ENTITY[key];
  if (!entity) return [];
  try {
    const r = await fetch(`${window.APP_URL}/ajax/${entity}.php?op=list`, {
      headers: { 'X-Requested-With': 'XMLHttpRequest' }
    });
    const j = await r.json();
    return (j && j.ok && Array.isArray(j.data)) ? j.data : [];
  } catch (e) {
    console.error('loadList error', key, e);
    return [];
  }
}

/**
 * Reemplaza la lista completa de una entidad en la base de datos.
 * @param {string} key p.ej. 'bitacora:entries'
 * @param {Array} list
 */
async function saveList(key, list) {
  const entity = STORAGE_ENTITY[key];
  if (!entity) return;
  try {
    await fetch(`${window.APP_URL}/ajax/${entity}.php?op=sync`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
      body: JSON.stringify({ list })
    });
  } catch (e) {
    console.error('saveList error', key, e);
  }
}

/* Reloj/fecha del topbar, presente en todas las vistas */
document.addEventListener('DOMContentLoaded', () => {
  const sub = document.getElementById('topbar-sub');
  if (sub) {
    const now = new Date();
    sub.textContent = now.toLocaleDateString('es-MX', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })
      + ' · ' + now.toLocaleTimeString('es-MX', { hour: '2-digit', minute: '2-digit' });
  }
});
