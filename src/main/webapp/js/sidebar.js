/**
 * ELMS Sidebar – Collapse, mobile toggle, and active link highlighting
 */
(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function () {
    var sidebar = document.getElementById('sidebar');
    var toggleBtn = document.getElementById('sidebarToggle');
    var overlay = document.getElementById('sidebarOverlay');
    if (!sidebar) return;

    var isMobile = function () { return window.innerWidth < 992; };

    /* Restore collapsed state from localStorage (desktop only) */
    if (!isMobile() && localStorage.getItem('sidebarCollapsed') === 'true') {
      sidebar.classList.add('collapsed');
      document.body.classList.add('sidebar-collapsed');
    }

    /* Toggle button */
    if (toggleBtn) {
      toggleBtn.addEventListener('click', function () {
        if (isMobile()) {
          sidebar.classList.toggle('mobile-open');
          if (overlay) overlay.classList.toggle('active');
        } else {
          sidebar.classList.toggle('collapsed');
          document.body.classList.toggle('sidebar-collapsed');
          localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
        }
      });
    }

    /* Overlay click closes mobile sidebar */
    if (overlay) {
      overlay.addEventListener('click', function () {
        sidebar.classList.remove('mobile-open');
        overlay.classList.remove('active');
      });
    }

    /* Close mobile sidebar on link click */
    sidebar.querySelectorAll('.sidebar-link').forEach(function (link) {
      link.addEventListener('click', function () {
        if (isMobile()) {
          sidebar.classList.remove('mobile-open');
          if (overlay) overlay.classList.remove('active');
        }
      });
    });

    /* Reset on resize */
    window.addEventListener('resize', function () {
      if (!isMobile()) {
        sidebar.classList.remove('mobile-open');
        if (overlay) overlay.classList.remove('active');
      }
    });

    /* Active link based on current page */
    var currentPath = window.location.pathname;
    sidebar.querySelectorAll('.sidebar-link').forEach(function (link) {
      var href = link.getAttribute('href');
      if (!href) return;
      if (currentPath.endsWith(href) || currentPath.indexOf(href) !== -1) {
        link.classList.add('active');
      }
    });
  });
})();
