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
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
	<link rel="icon" type="image/png" href="<?php echo URL; ?>/assets/images/favicon.ico">
	<link rel="stylesheet" href="<?php echo URL; ?>/assets/css/app.css">
	<style>
		html, body { overflow:auto !important; }
		.login-wrap{min-height:100vh;display:flex;align-items:center;justify-content:center;background:var(--bg);padding:20px;}
		.login-card{width:100%;max-width:360px;background:var(--surface);border:1px solid var(--line);border-radius:var(--radius);box-shadow:var(--shadow);padding:32px 28px;}
		.login-logo{display:block;height:200px;margin:0 auto 22px;}
		.login-card h1{font-size:17px;font-weight:800;margin:0 0 4px;text-align:center;}
		.login-card p.sub{font-size:12.5px;color:var(--ink-faint);text-align:center;margin:0 0 22px;}
		.login-error{display:none;background:var(--red-soft);color:var(--red);font-size:12.5px;font-weight:600;padding:9px 11px;border-radius:9px;margin-bottom:14px;}
		.login-submit{width:100%;margin-top:6px;justify-content:center;}
		.field{margin-bottom:14px;}
	</style>
</head>
<body>
	<div class="login-wrap">
		<div class="login-card">
			<img src="<?php echo URL; ?>/assets/images/logo.png" alt="Logotipo" class="login-logo">
			<h1>Iniciar sesión</h1>
			<p class="sub">Accede a tu panel de campaña</p>

			<div class="login-error" id="loginError"></div>

			<form id="loginForm">
				<div class="field">
					<label for="user">Usuario</label>
					<input type="text" id="user" name="user" autocomplete="username" required>
				</div>
				<div class="field">
					<label for="pass">Contraseña</label>
					<input type="password" id="pass" name="pass" autocomplete="current-password" required>
				</div>
				<button type="submit" class="pill-btn login-submit" id="loginBtn"><span>Entrar</span></button>
			</form>
		</div>
	</div>

	<script>
		const form = document.getElementById('loginForm');
		const btn = document.getElementById('loginBtn');
		const errBox = document.getElementById('loginError');

		form.addEventListener('submit', async (ev) => {
			ev.preventDefault();
			errBox.style.display = 'none';
			btn.disabled = true;

			try {
				const body = new FormData();
				body.append('op', 'login');
				body.append('user', document.getElementById('user').value.trim());
				body.append('pass', document.getElementById('pass').value);

				const r = await fetch('<?php echo URL; ?>/ajax/login.php', {
					method: 'POST',
					headers: { 'X-Requested-With': 'XMLHttpRequest' },
					body
				});
				const j = await r.json();

				if( j && j.ok ) {
					window.location.href = j.redirect || '<?php echo URL; ?>/inicio/dashboard';
				} else {
					errBox.textContent = (j && j.error) ? j.error : 'No se pudo iniciar sesión.';
					errBox.style.display = 'block';
					btn.disabled = false;
				}
			} catch (e) {
				errBox.textContent = 'Error de conexión, intenta de nuevo.';
				errBox.style.display = 'block';
				btn.disabled = false;
			}
		});
	</script>
</body>
</html>