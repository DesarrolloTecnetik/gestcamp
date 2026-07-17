<?php

	require 'init.conf';

	// ya hay sesión activa -> directo al panel
	if( !empty($UserID) ) {
		header('Location: '.URL.'/inicio/dashboard');
		exit;
	}

?>
<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Iniciar sesión · <?php echo TITLE; ?></title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=IBM+Plex+Mono:wght@500&display=swap" rel="stylesheet">
	<link rel="icon" type="image/png" href="<?php echo URL; ?>/assets/images/favicon.ico">
	<link rel="stylesheet" href="<?php echo URL; ?>/assets/css/app.css">
	<style>

		html, body{ overflow:auto !important; height:auto; }

		.login-screen{
			min-height:100vh;
			display:grid;
			grid-template-columns:minmax(0,7fr) minmax(0,5fr);
		}

		/* ---------- Panel de marca ---------- */
		.login-brand{
			position:relative;
			background:
				radial-gradient(560px 420px at 15% 15%, rgba(255,255,255,.08), transparent 60%),
				linear-gradient(165deg, var(--purple-dark) 0%, var(--purple) 55%, var(--violet) 100%);
			color:#fff;
			padding:44px 48px;
			display:flex;
			flex-direction:column;
			overflow:hidden;
		}
		.login-brand-top{
			display:flex;
			align-items:center;
			gap:10px;
		}
		.login-brand-top img{ height:28px; display:block; filter:brightness(0) invert(1); opacity:.95; }
		.login-brand-top span{
			font-size:11px;
			font-weight:700;
			letter-spacing:.14em;
			text-transform:uppercase;
			color:rgba(255,255,255,.6);
			border-left:1px solid rgba(255,255,255,.25);
			padding-left:10px;
		}

		.login-brand-mid{
			flex:1;
			display:flex;
			flex-direction:column;
			justify-content:center;
			max-width:440px;
			margin:0 auto 0 0;
		}
		.login-brand-mid h1{
			font-size:32px;
			line-height:1.18;
			font-weight:800;
			letter-spacing:-.01em;
			margin:22px 0 12px;
		}
		.login-brand-mid p{
			font-size:14px;
			line-height:1.6;
			color:rgba(255,255,255,.72);
			margin:0;
			max-width:360px;
		}

		/* señal / radar — representa monitoreo en tiempo real de zonas y eventos */
		.signal{
			position:relative;
			width:30px;
			height:30px;
			flex-shrink:0;
		}
		.signal .dot{
			position:absolute;
			top:50%;left:50%;
			width:8px;height:8px;
			margin:-4px 0 0 -4px;
			border-radius:50%;
			background:#fff;
		}
		.signal .ring{
			position:absolute;
			top:50%;left:50%;
			width:8px;height:8px;
			margin:-4px 0 0 -4px;
			border-radius:50%;
			border:1.5px solid rgba(255,255,255,.75);
			animation:signal-pulse 2.6s cubic-bezier(.2,.6,.35,1) infinite;
		}
		.signal .ring:nth-child(3){ animation-delay:.65s; }
		.signal .ring:nth-child(4){ animation-delay:1.3s; }
		@keyframes signal-pulse{
			0%{ width:8px;height:8px;margin:-4px 0 0 -4px; opacity:.85; }
			100%{ width:30px;height:30px;margin:-15px 0 0 -15px; opacity:0; }
		}

		.login-brand-tags{
			display:flex;
			flex-wrap:wrap;
			gap:8px;
			margin-top:26px;
		}
		.login-brand-tags span{
			font-size:11.5px;
			font-weight:600;
			color:rgba(255,255,255,.85);
			background:rgba(255,255,255,.1);
			border:1px solid rgba(255,255,255,.16);
			padding:6px 12px;
			border-radius:999px;
		}

		.login-brand-foot{
			font-size:11px;
			color:rgba(255,255,255,.45);
			letter-spacing:.02em;
		}

		/* ---------- Panel de formulario ---------- */
		.login-panel{
			display:flex;
			align-items:center;
			justify-content:center;
			padding:32px;
			background:var(--bg);
		}
		.login-card{
			width:100%;
			max-width:360px;
		}
		.login-card-logo{ height:160px; margin:0 auto 20px; display:block; }
		.login-card .eyebrow{
			font-size:11px;
			font-weight:700;
			letter-spacing:.1em;
			text-transform:uppercase;
			color:var(--violet);
			margin:0 0 8px;
		}
		.login-card h2{
			font-size:22px;
			font-weight:800;
			letter-spacing:-.01em;
			margin:0 0 6px;
			color:var(--ink);
		}
		.login-card p.sub{
			font-size:13px;
			color:var(--ink-soft);
			margin:0 0 26px;
		}

		.login-error{
			display:none;
			align-items:center;
			gap:8px;
			background:var(--red-soft);
			color:var(--red);
			font-size:12.5px;
			font-weight:600;
			padding:10px 12px;
			border-radius:10px;
			margin-bottom:16px;
		}
		.login-error svg{ width:14px;height:14px;flex-shrink:0; }

		.field{ margin-bottom:16px; }
		.field label{
			display:block;
			font-size:12px;
			font-weight:700;
			color:var(--ink);
			margin-bottom:6px;
		}
		.field-input{
			position:relative;
			display:flex;
			align-items:center;
		}
		.field-input svg{
			position:absolute;
			left:13px;
			width:15px;height:15px;
			color:var(--ink-faint);
			pointer-events:none;
		}
		.field-input input{
			width:100%;
			padding:11px 13px 11px 38px;
			border-radius:11px;
			border:1px solid var(--line);
			background:var(--surface);
			font-family:'Inter',sans-serif;
			font-size:13.5px;
			color:var(--ink);
			outline:none;
			transition:border-color .15s, box-shadow .15s;
		}
		.field-input input::placeholder{ color:var(--ink-faint); }
		.field-input input:focus{
			border-color:var(--violet);
			box-shadow:0 0 0 3px var(--violet-soft);
		}
		.field-toggle{
			position:absolute;
			right:11px;
			background:none;
			border:none;
			padding:4px;
			cursor:pointer;
			color:var(--ink-faint);
			display:flex;
		}
		.field-toggle svg{ position:static; width:15px;height:15px; }
		.field-toggle:hover{ color:var(--ink-soft); }

		.login-row{
			display:flex;
			align-items:center;
			justify-content:space-between;
			margin:-4px 0 20px;
		}
		.remember{
			display:flex;
			align-items:center;
			gap:7px;
			font-size:12.5px;
			color:var(--ink-soft);
			cursor:pointer;
			user-select:none;
		}
		.remember input{ accent-color:var(--purple); width:14px;height:14px; }

		.login-submit{
			width:100%;
			justify-content:center;
			padding:11px 18px;
			font-size:13.5px;
		}
		.login-submit:disabled{ opacity:.7; cursor:default; }
		.login-submit .spinner{
			width:14px;height:14px;
			border-radius:50%;
			border:2px solid rgba(255,255,255,.4);
			border-top-color:#fff;
			animation:spin .7s linear infinite;
			display:none;
		}
		.login-submit.loading .spinner{ display:inline-block; }
		.login-submit.loading .label-text{ display:none; }
		@keyframes spin{ to{ transform:rotate(360deg); } }

		.login-foot{
			margin-top:22px;
			font-size:12px;
			color:var(--ink-faint);
			text-align:center;
		}

		@media (prefers-reduced-motion: reduce){
			.signal .ring{ animation:none; opacity:.4; }
		}

		@media (max-width:900px){
			.login-screen{ grid-template-columns:1fr; }
			.login-brand{ display:none; }
			.login-panel{ padding:20px; min-height:100vh; }
		}

	</style>
</head>
<body>

	<div class="login-screen">

		<section class="login-brand">
			<div class="login-brand-top">
				<img src="<?php echo URL; ?>/assets/images/logo.png" alt="">
				<span>Plataforma de campaña</span>
			</div>

			<div class="login-brand-mid">
				<div class="signal">
					<div class="ring"></div>
					<div class="ring"></div>
					<div class="ring"></div>
					<div class="dot"></div>
				</div>
				<h1>Coordina cada acción de la campaña desde un solo lugar.</h1>
				<p>Bitácora, eventos, enrolamiento y mapa de zonas en tiempo real, sincronizados para todo tu equipo de coordinación.</p>

				<div class="login-brand-tags">
					<span>Bitácora de acciones</span>
					<span>Eventos</span>
					<span>Mapa de calor</span>
					<span>BRM · Enrolamiento</span>
				</div>
			</div>

			<div class="login-brand-foot">Acceso exclusivo para equipo autorizado de campaña.</div>
		</section>

		<section class="login-panel">
			<div class="login-card">

				<img src="<?php echo URL; ?>/assets/images/logo.png" alt="Logotipo" class="login-card-logo">

				<p class="eyebrow">Bienvenido de vuelta</p>
				<h2>Inicia sesión</h2>
				<p class="sub">Ingresa tus credenciales para entrar al panel.</p>

				<div class="login-error" id="loginError">
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16h.01"/></svg>
					<span id="loginErrorText"></span>
				</div>

				<form id="loginForm" novalidate>

					<div class="field">
						<label for="user">Usuario</label>
						<div class="field-input">
							<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.5-6 8-6s8 2 8 6"/></svg>
							<input type="text" id="user" name="user" autocomplete="username" placeholder="tu.usuario" required>
						</div>
					</div>

					<div class="field">
						<label for="pass">Contraseña</label>
						<div class="field-input">
							<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="5" y="11" width="14" height="9" rx="2"/><path d="M8 11V8a4 4 0 0 1 8 0v3"/></svg>
							<input type="password" id="pass" name="pass" autocomplete="current-password" placeholder="••••••••" required>
							<button type="button" class="field-toggle" id="passToggle" aria-label="Mostrar contraseña" tabindex="-1">
								<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7Z"/><circle cx="12" cy="12" r="3"/></svg>
							</button>
						</div>
					</div>

					<div class="login-row">
						<label class="remember">
							<input type="checkbox" id="remember" name="remember">
							Recordarme
						</label>
					</div>

					<button type="submit" class="pill-btn login-submit" id="loginBtn">
						<span class="spinner"></span>
						<span class="label-text">Entrar</span>
					</button>
				</form>

				<p class="login-foot">¿Problemas para entrar? Contacta a tu coordinador de campaña.</p>
			</div>
		</section>

	</div>

	<script>
		const form     = document.getElementById('loginForm');
		const btn      = document.getElementById('loginBtn');
		const errBox   = document.getElementById('loginError');
		const errText  = document.getElementById('loginErrorText');
		const passInp  = document.getElementById('pass');
		const passTgl  = document.getElementById('passToggle');

		passTgl.addEventListener('click', () => {
			passInp.type = passInp.type === 'password' ? 'text' : 'password';
		});

		function showError(msg){
			errText.textContent = msg;
			errBox.style.display = 'flex';
		}

		form.addEventListener('submit', async (ev) => {
			ev.preventDefault();
			errBox.style.display = 'none';
			btn.disabled = true;
			btn.classList.add('loading');

			try {
				const body = new FormData();
				body.append('op', 'login');
				body.append('user', document.getElementById('user').value.trim());
				body.append('pass', passInp.value);
				body.append('remember', document.getElementById('remember').checked ? 1 : 0);

				const r = await fetch('<?php echo URL; ?>/ajax/login.php', {
					method: 'POST',
					headers: { 'X-Requested-With': 'XMLHttpRequest' },
					body
				});
				const j = await r.json();

				if( j && j.ok ) {
					window.location.href = j.redirect || '<?php echo URL; ?>/inicio/dashboard';
				} else {
					showError((j && j.error) ? j.error : 'No se pudo iniciar sesión.');
					btn.disabled = false;
					btn.classList.remove('loading');
				}
			} catch (e) {
				showError('Error de conexión, intenta de nuevo.');
				btn.disabled = false;
				btn.classList.remove('loading');
			}
		});
	</script>

</body>
</html>