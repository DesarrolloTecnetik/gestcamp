<?php /* Vista: BRM · Enrolamiento */ ?>
      <div class="kpi-grid" style="grid-template-columns:repeat(3,1fr);">
        <div class="card card-pad">
          <div class="card-sub">Simpatizantes enrolados</div>
          <div class="num" id="brm-kpi-total" style="font-size:26px;font-weight:800;margin-top:4px;">0</div>
        </div>
        <div class="card card-pad">
          <div class="card-sub">Enrolados esta semana</div>
          <div class="num" id="brm-kpi-semana" style="font-size:26px;font-weight:800;margin-top:4px;">0</div>
        </div>
        <div class="card card-pad">
          <div class="card-sub">Zonas cubiertas</div>
          <div class="num" id="brm-kpi-zonas" style="font-size:26px;font-weight:800;margin-top:4px;">0</div>
        </div>
      </div>

      <div class="form-panel open" id="form-brm" style="margin-top:4px;">
        <h3>Enrolar simpatizante</h3>
        <div class="form-grid">
          <div class="field full"><label>Nombre completo</label><input type="text" id="brm-nombre" placeholder="Nombre y apellidos"></div>
          <div class="field"><label>Teléfono (opcional)</label><input type="tel" id="brm-telefono" placeholder="10 dígitos"></div>
          <div class="field"><label>Zona / colonia</label><input type="text" id="brm-zona" placeholder="Ej. Centro"></div>
          <div class="field"><label>Fecha de enrolamiento</label><input type="date" id="brm-fecha"></div>
        </div>

        <div class="capture-grid" style="margin-top:14px;">
          <div class="capture-box">
            <img id="brm-ine-preview">
            <div class="cap-label">Credencial INE</div>
            <div class="cap-sub">Foto frontal legible</div>
            <input type="file" accept="image/*" capture="environment" id="brm-ine-input" style="display:none;">
            <button type="button" class="btn" onclick="document.getElementById('brm-ine-input').click()">📷 Capturar INE</button>
          </div>
          <div class="capture-box">
            <img id="brm-selfie-preview">
            <div class="cap-label">Selfie</div>
            <div class="cap-sub">Rostro visible y centrado</div>
            <input type="file" accept="image/*" capture="user" id="brm-selfie-input" style="display:none;">
            <button type="button" class="btn" onclick="document.getElementById('brm-selfie-input').click()">🤳 Capturar selfie</button>
          </div>
        </div>

        <div class="consent-box">
          <input type="checkbox" id="brm-consent">
          <p>La persona simpatizante autoriza el uso de sus datos e imagen (INE y selfie) exclusivamente para fines de afiliación y verificación dentro de esta plataforma, <strong>sin fines comerciales</strong> ni cesión a terceros.</p>
        </div>

        <div class="form-actions">
          <button class="btn btn-purple" id="brm-guardar">Enrolar simpatizante</button>
          <button class="btn" id="brm-limpiar">Limpiar formulario</button>
        </div>
        <div id="brm-error" style="color:var(--red);font-size:12px;margin-top:8px;display:none;"></div>
      </div>

      <div class="card table-wrap" style="margin-top:16px;">
        <table>
          <thead><tr><th></th><th>Nombre</th><th>Zona</th><th>Teléfono</th><th>Fecha</th><th>Consentimiento</th><th>INE</th><th></th></tr></thead>
          <tbody id="brm-tbody"></tbody>
        </table>
        <div class="empty-state" id="brm-empty" style="display:none;">
          <div class="glyph">Sin simpatizantes enrolados</div>
          Captura INE + selfie y confirma el consentimiento para dar de alta al primero.
        </div>
      </div>

<script>
let brm = [];
let brmIne = null, brmSelfie = null;

function resizeImage(file, maxDim){
  return new Promise((resolve,reject)=>{
    const reader = new FileReader();
    reader.onload = ()=>{
      const img = new Image();
      img.onload = ()=>{
        let w = img.width, h = img.height;
        if(w>h){ if(w>maxDim){ h = h*maxDim/w; w = maxDim; } } else { if(h>maxDim){ w = w*maxDim/h; h = maxDim; } }
        const canvas = document.createElement('canvas');
        canvas.width = w; canvas.height = h;
        canvas.getContext('2d').drawImage(img,0,0,w,h);
        resolve(canvas.toDataURL('image/jpeg', 0.72));
      };
      img.onerror = reject;
      img.src = reader.result;
    };
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}

document.getElementById('brm-ine-input').addEventListener('change', async (ev)=>{
  const f = ev.target.files[0]; if(!f) return;
  brmIne = await resizeImage(f, 320);
  const img = document.getElementById('brm-ine-preview'); img.src = brmIne; img.classList.add('show');
});
document.getElementById('brm-selfie-input').addEventListener('change', async (ev)=>{
  const f = ev.target.files[0]; if(!f) return;
  brmSelfie = await resizeImage(f, 240);
  const img = document.getElementById('brm-selfie-preview'); img.src = brmSelfie; img.classList.add('show');
});

document.getElementById('brm-limpiar').addEventListener('click', clearBrmForm);
function clearBrmForm(){
  ['brm-nombre','brm-telefono','brm-zona','brm-fecha'].forEach(id=>document.getElementById(id).value='');
  document.getElementById('brm-consent').checked = false;
  brmIne = null; brmSelfie = null;
  document.getElementById('brm-ine-preview').classList.remove('show');
  document.getElementById('brm-selfie-preview').classList.remove('show');
  document.getElementById('brm-error').style.display='none';
}

document.getElementById('brm-guardar').addEventListener('click', async ()=>{
  const errBox = document.getElementById('brm-error');
  const nombre = document.getElementById('brm-nombre').value.trim();
  const consent = document.getElementById('brm-consent').checked;
  if(!nombre){ errBox.textContent='Captura el nombre completo del simpatizante.'; errBox.style.display='block'; document.getElementById('brm-nombre').focus(); return; }
  if(!brmIne || !brmSelfie){ errBox.textContent='Se requiere capturar la foto de INE y la selfie para enrolar.'; errBox.style.display='block'; return; }
  if(!consent){ errBox.textContent='Se requiere el consentimiento del simpatizante para continuar.'; errBox.style.display='block'; return; }
  errBox.style.display='none';

  const entry = {
    id: uid(), nombre, telefono: document.getElementById('brm-telefono').value.trim(),
    zona: document.getElementById('brm-zona').value.trim(),
    fecha: document.getElementById('brm-fecha').value || new Date().toISOString().slice(0,10),
    ine: brmIne, selfie: brmSelfie, consent: true
  };
  brm.push(entry);
  await saveList('brm:entries', brm);
  clearBrmForm();
  renderBRM();
});

async function deleteBrm(id){
  if(!confirm('¿Eliminar este registro de enrolamiento?')) return;
  brm = brm.filter(x=>x.id!==id); await saveList('brm:entries', brm); renderBRM();
}
function verIne(id){
  const e = brm.find(x=>x.id===id); if(!e) return;
  const w = window.open('', '_blank', 'width=420,height=560');
  w.document.write(`<title>INE — ${esc(e.nombre)}</title><body style="margin:0;background:#111;display:flex;align-items:center;justify-content:center;height:100vh;"><img src="${e.ine}" style="max-width:100%;max-height:100%;"></body>`);
}

function renderBRM(){
  const tbody = document.getElementById('brm-tbody'); const empty = document.getElementById('brm-empty');
  document.getElementById('brm-kpi-total').textContent = brm.length;
  const weekAgo = new Date(); weekAgo.setDate(weekAgo.getDate()-7);
  const weekStr = weekAgo.toISOString().slice(0,10);
  document.getElementById('brm-kpi-semana').textContent = brm.filter(e=>e.fecha>=weekStr).length;
  document.getElementById('brm-kpi-zonas').textContent = new Set(brm.filter(e=>e.zona).map(e=>e.zona.toLowerCase())).size;

  const sorted = [...brm].sort((a,b)=>(b.fecha||'').localeCompare(a.fecha||''));
  if(sorted.length===0){ tbody.innerHTML=''; empty.style.display='block'; return; }
  empty.style.display='none';
  tbody.innerHTML = sorted.map(e=>`
    <tr>
      <td><img class="brm-thumb" src="${e.selfie}"></td>
      <td><strong>${esc(e.nombre)}</strong></td>
      <td>${esc(e.zona)||'—'}</td>
      <td>${esc(e.telefono)||'—'}</td>
      <td>${fmtDate(e.fecha)}</td>
      <td><span class="badge s-Autorizado">Autorizado</span></td>
      <td><button class="btn" style="padding:5px 10px;font-size:11.5px;" onclick="verIne('${e.id}')">Ver INE</button></td>
      <td><button class="icon-btn" onclick="deleteBrm('${e.id}')" title="Eliminar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h18M8 6V4h8v2M19 6l-1 14H6L5 6"/></svg></button></td>
    </tr>`).join('');
}

(async function initBrm(){
  brm = await loadList('brm:entries');
  renderBRM();
})();
</script>
