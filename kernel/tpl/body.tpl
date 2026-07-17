<body>
<div class="app">

  <aside class="sidebar">
    <div class="brand">
      <img src="<?php echo URL; ?>/assets/images/logo.png" alt="Logotipo" class="brand-logo">
    </div>

    <div class="nav-group">
      <div class="nav-group-label">Principal</div>
      <nav class="nav-list">
        <a class="nav-btn <?php echo $activeView==='dashboard' ? 'active' : ''; ?>" href="<?php echo URL; ?>/inicio/dashboard">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="9" rx="1.5"/><rect x="14" y="3" width="7" height="5" rx="1.5"/><rect x="14" y="12" width="7" height="9" rx="1.5"/><rect x="3" y="16" width="7" height="5" rx="1.5"/></svg>
          Panel general
        </a>
      </nav>
    </div>

    <div class="nav-group">
      <div class="nav-group-label">Operaciones</div>
      <nav class="nav-list">
        <a class="nav-btn <?php echo $activeView==='bitacora' ? 'active' : ''; ?>" href="<?php echo URL; ?>/inicio/bitacora">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 2h6l1 3H8l1-3Z"/><rect x="4" y="5" width="16" height="17" rx="2"/><path d="M8 11h8M8 15h8M8 19h5"/></svg>
          Bitácora de acciones
        </a>
        <a class="nav-btn <?php echo $activeView==='eventos' ? 'active' : ''; ?>" href="<?php echo URL; ?>/inicio/eventos">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 10h18M8 3v4M16 3v4"/></svg>
          Eventos
        </a>
        <a class="nav-btn <?php echo $activeView==='mapa' ? 'active' : ''; ?>" href="<?php echo URL; ?>/inicio/mapa">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-6.2-7-11.5A7 7 0 0 1 19 9.5C19 14.8 12 21 12 21Z"/><circle cx="12" cy="9.5" r="2.3"/></svg>
          Mapa de calor
        </a>
        <a class="nav-btn <?php echo $activeView==='brm' ? 'active' : ''; ?>" href="<?php echo URL; ?>/inicio/brm">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3a9 9 0 0 0-9 9c0 2.5 1 4.5 2 6M12 3a9 9 0 0 1 9 9c0 3-1 5-2 7"/><path d="M12 7a5 5 0 0 0-5 5c0 3 1.5 5 2.5 6.5M12 7a5 5 0 0 1 5 5c0 1.7-.4 3-1 4"/><path d="M12 11a1 1 0 0 0-1 1c0 3 1 5 2 6.5"/></svg>
          BRM · Enrolamiento
        </a>
      </nav>
    </div>

    <div class="nav-group">
      <div class="nav-group-label">Análisis</div>
      <nav class="nav-list">
        <a class="nav-btn <?php echo $activeView==='estadisticas' ? 'active' : ''; ?>" href="<?php echo URL; ?>/inicio/estadisticas">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 20V10M11 20V4M18 20v-7"/></svg>
          Estadísticas
        </a>
        <a class="nav-btn <?php echo $activeView==='candidatura' ? 'active' : ''; ?>" href="<?php echo URL; ?>/inicio/candidatura">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg>
          Estadística de candidatura
        </a>
      </nav>
    </div>

    <div class="sidebar-foot">
      <div class="avatar"><?php echo isset($avatarInitials) ? $avatarInitials : 'EC'; ?></div>
      <div><b><?php echo isset($nombreEquipo) ? $nombreEquipo : 'Equipo de campaña'; ?></b><span>Coordinación</span></div>
      <a href="<?php echo URL; ?>/logout.php" class="icon-square" title="Cerrar sesión" style="margin-left:auto;">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><path d="M16 17l5-5-5-5"/><path d="M21 12H9"/></svg>
      </a>
    </div>
  </aside>

  <div class="main">
    <div class="topbar">
      <div class="topbar-left">
        <button class="back-btn" onclick="history.back()"><svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M15 18l-6-6 6-6"/></svg></button>
        <div>
          <h2><?php echo $VIEWS[$activeView]['title']; ?></h2>
          <div class="sub" id="topbar-sub"></div>
        </div>
      </div>
      <div class="topbar-right">
        <div class="icon-square"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8Z"/><path d="M14 2v6h6"/></svg></div>
        <div class="icon-square"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8a6 6 0 1 0-12 0c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.7 21a2 2 0 0 1-3.4 0"/></svg></div>
        <?php if( !empty($VIEWS[$activeView]['cta']) ) : ?>
        <button class="pill-btn" onclick="<?php echo $VIEWS[$activeView]['ctaFn']; ?>"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M12 5v14M5 12h14"/></svg><span><?php echo $VIEWS[$activeView]['cta']; ?></span></button>
        <?php endif; ?>
      </div>
    </div>

    <div class="content">
