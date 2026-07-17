<?php /* Vista: Estadística de candidatura (análisis IA) */ ?>
      <div class="card card-pad">
        <div class="card-title" style="font-size:16px;">Analizar figura pública</div>
        <p class="disclaimer" style="margin-top:4px;">Escribe el nombre completo de la persona o candidatura a analizar.</p>
        <div class="ai-input-row">
          <input type="text" id="ai-nombre" placeholder="Ej. Nombre del candidato o candidata">
          <button class="btn btn-purple" id="ai-analizar">Analizar</button>
        </div>
        <p class="disclaimer">El resultado es generado por IA a partir de fuentes públicas y puede contener imprecisiones. Verifica siempre los datos antes de usarlos en decisiones de campaña.</p>
        <div class="ai-loading" id="ai-loading"><span class="dot-pulse"></span> Analizando información pública…</div>
        <div class="ai-result hidden" id="ai-result"></div>
      </div>

<script>
document.getElementById('ai-analizar').addEventListener('click', async ()=>{
  const nombre = document.getElementById('ai-nombre').value.trim();
  const resultBox = document.getElementById('ai-result'); const loading = document.getElementById('ai-loading');
  if(!nombre){ document.getElementById('ai-nombre').focus(); return; }
  resultBox.classList.add('hidden'); loading.classList.add('active');
  try{
    const response = await fetch(window.APP_URL + '/ajax/candidatura.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
      body: 'nombre=' + encodeURIComponent(nombre)
    });
    const data = await response.json();
    resultBox.textContent = data && data.ok ? (data.text || 'No se obtuvo información suficiente para generar el análisis.') : (data && data.error ? data.error : 'Ocurrió un error al generar el análisis.');
  }catch(err){ resultBox.textContent = 'Ocurrió un error al generar el análisis. Intenta de nuevo.'; console.error(err); }
  loading.classList.remove('active'); resultBox.classList.remove('hidden');
});
</script>
