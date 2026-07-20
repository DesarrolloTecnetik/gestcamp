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
  if (!entity) return false;
  try {
    const r = await fetch(`${window.APP_URL}/ajax/${entity}.php?op=sync`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
      body: JSON.stringify({ list })
    });
    const j = await r.json();
    if (!j || !j.ok) {
      console.error('saveList error', key, j && j.error);
      return false;
    }
    return true;
  } catch (e) {
    console.error('saveList error', key, e);
    return false;
  }
}

/**
 * Modal de confirmación reutilizable (reemplaza al confirm() nativo del navegador).
 * Uso: const ok = await confirmDialog('¿Eliminar esta acción?'); if (ok) { ... }
 * @param {string} message
 * @param {{title?:string, confirmText?:string, cancelText?:string}} opts
 * @returns {Promise<boolean>}
 */
function confirmDialog(message, opts) {
  opts = opts || {};
  return new Promise((resolve) => {
    let overlay = document.getElementById('confirm-dialog-overlay');
    if (!overlay) {
      overlay = document.createElement('div');
      overlay.id = 'confirm-dialog-overlay';
      overlay.className = 'confirm-dialog-overlay';
      overlay.innerHTML = `
        <div class="confirm-dialog-box" role="alertdialog" aria-modal="true">
          <h3 id="confirm-dialog-title"></h3>
          <p id="confirm-dialog-message"></p>
          <div class="confirm-dialog-actions">
            <button type="button" class="btn" id="confirm-dialog-cancel"></button>
            <button type="button" class="btn btn-danger btn-danger-solid" id="confirm-dialog-ok"></button>
          </div>
        </div>`;
      document.body.appendChild(overlay);
    }

    overlay.querySelector('#confirm-dialog-title').textContent = opts.title || 'Confirmar';
    overlay.querySelector('#confirm-dialog-message').textContent = message || '¿Estás seguro?';
    const btnOk = overlay.querySelector('#confirm-dialog-ok');
    const btnCancel = overlay.querySelector('#confirm-dialog-cancel');
    btnOk.textContent = opts.confirmText || 'Eliminar';
    btnCancel.textContent = opts.cancelText || 'Cancelar';

    const close = (result) => {
      overlay.classList.remove('open');
      document.removeEventListener('keydown', onKeydown);
      resolve(result);
    };
    const onKeydown = (ev) => { if (ev.key === 'Escape') close(false); };

    btnOk.onclick = () => close(true);
    btnCancel.onclick = () => close(false);
    overlay.onclick = (ev) => { if (ev.target === overlay) close(false); };
    document.addEventListener('keydown', onKeydown);

    overlay.classList.add('open');
  });
}

/**
 * Notificación tipo "toast" en la esquina inferior derecha.
 * @param {string} message
 * @param {'success'|'error'|'info'} type
 */
function showToast(message, type) {
  type = type || 'success';
  let host = document.getElementById('toast-host');
  if (!host) {
    host = document.createElement('div');
    host.id = 'toast-host';
    host.className = 'toast-host';
    document.body.appendChild(host);
  }
  const toast = document.createElement('div');
  toast.className = `toast toast-${type}`;
  const icon = type === 'error'
    ? '<svg viewBox="0 0 24 24" width="18" stroke="currentColor" fill="none" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 8v5M12 16h.01"/></svg>'
    : '<svg viewBox="0 0 24 24" width="18" stroke="currentColor" fill="none" stroke-width="2"><path d="M20 6 9 17l-5-5"/></svg>';
  toast.innerHTML = `<span class="toast-icon">${icon}</span><span class="toast-msg"></span>`;
  toast.querySelector('.toast-msg').textContent = message;
  host.appendChild(toast);

  requestAnimationFrame(() => toast.classList.add('show'));
  const remove = () => {
    toast.classList.remove('show');
    setTimeout(() => toast.remove(), 200);
  };
  toast.addEventListener('click', remove);
  setTimeout(remove, 3200);
}

/* --- Colapsar / expandir sidebar (escritorio) --- */
function toggleSidebar() {
  document.body.classList.toggle('sidebar-collapsed');
  const collapsed = document.body.classList.contains('sidebar-collapsed');
  localStorage.setItem('sidebarCollapsed', collapsed ? '1' : '0');

  const btn = document.getElementById('sidebar-toggle-btn');
  if (btn) btn.title = collapsed ? 'Expandir menú' : 'Colapsar menú';
}

/* --- Menú móvil (drawer) --- */
function toggleMobileSidebar() {
  document.body.classList.toggle('mobile-sidebar-open');
}
function closeMobileSidebar() {
  document.body.classList.remove('mobile-sidebar-open');
}

/* Si el usuario rota o agranda la ventana a escritorio, cierra el drawer
   para que no quede "atorado" abierto al volver a mobile */
window.addEventListener('resize', () => {
  if (window.innerWidth > 960) closeMobileSidebar();
});

/* Reloj/fecha del topbar + estado del sidebar, presentes en todas las vistas */
document.addEventListener('DOMContentLoaded', () => {
  const sub = document.getElementById('topbar-sub');
  if (sub) {
    const now = new Date();
    sub.textContent = now.toLocaleDateString('es-MX', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })
      + ' · ' + now.toLocaleTimeString('es-MX', { hour: '2-digit', minute: '2-digit' });
  }

  if (localStorage.getItem('sidebarCollapsed') === '1') {
    document.body.classList.add('sidebar-collapsed');
    const btn = document.getElementById('sidebar-toggle-btn');
    if (btn) btn.title = 'Expandir menú';
  }
});