/**
 * ELMS Shimmer Loader – skeleton UI with intentional minimum display time
 */
(function () {
  'use strict';

  var MIN_DISPLAY_MS = 700;
  var FADE_OUT_MS = 300;

  function getShimmerType() {
    var screen = document.getElementById('shimmerScreen');
    return screen ? screen.getAttribute('data-type') || 'auth' : 'auth';
  }

  function buildShimmerHtml(type) {
    if (type === 'dashboard') {
      return (
        '<div class="shimmer-dashboard">' +
          '<div class="shimmer-sidebar">' +
            '<div class="shimmer-block shimmer-sidebar-brand"></div>' +
            '<div class="shimmer-block shimmer-sidebar-link"></div>' +
            '<div class="shimmer-block shimmer-sidebar-link"></div>' +
            '<div class="shimmer-block shimmer-sidebar-link"></div>' +
          '</div>' +
          '<div class="shimmer-main">' +
            '<div class="shimmer-block shimmer-navbar"></div>' +
            '<div class="shimmer-stat-row">' +
              '<div class="shimmer-block shimmer-stat-card"></div>' +
              '<div class="shimmer-block shimmer-stat-card"></div>' +
              '<div class="shimmer-block shimmer-stat-card"></div>' +
              '<div class="shimmer-block shimmer-stat-card"></div>' +
            '</div>' +
            '<div class="shimmer-block shimmer-table-block"></div>' +
          '</div>' +
        '</div>'
      );
    }
    if (type === 'form') {
      return (
        '<div class="shimmer-form-wrap">' +
          '<div class="shimmer-sidebar">' +
            '<div class="shimmer-block shimmer-sidebar-brand"></div>' +
            '<div class="shimmer-block shimmer-sidebar-link"></div>' +
            '<div class="shimmer-block shimmer-sidebar-link"></div>' +
          '</div>' +
          '<div class="shimmer-form-main">' +
            '<div class="shimmer-block shimmer-navbar"></div>' +
            '<div class="shimmer-form-card">' +
              '<div class="shimmer-block shimmer-auth-title" style="width:50%;margin-bottom:1.5rem;"></div>' +
              '<div class="shimmer-block shimmer-form-field"></div>' +
              '<div class="shimmer-block shimmer-form-field"></div>' +
              '<div class="shimmer-block shimmer-form-textarea"></div>' +
              '<div class="shimmer-block shimmer-auth-btn"></div>' +
            '</div>' +
          '</div>' +
        '</div>'
      );
    }
    if (type === 'table') {
      return (
        '<div class="shimmer-table-wrap">' +
          '<div class="shimmer-sidebar">' +
            '<div class="shimmer-block shimmer-sidebar-brand"></div>' +
            '<div class="shimmer-block shimmer-sidebar-link"></div>' +
            '<div class="shimmer-block shimmer-sidebar-link"></div>' +
          '</div>' +
          '<div class="shimmer-main">' +
            '<div class="shimmer-block shimmer-navbar"></div>' +
            '<div class="shimmer-filter-row">' +
              '<div class="shimmer-block shimmer-filter"></div>' +
              '<div class="shimmer-block shimmer-filter shimmer-filter-sm"></div>' +
            '</div>' +
            '<div class="shimmer-block shimmer-table-block"></div>' +
          '</div>' +
        '</div>'
      );
    }
    return (
      '<div class="shimmer-auth">' +
        '<div class="shimmer-auth-card">' +
          '<div class="shimmer-block shimmer-auth-logo"></div>' +
          '<div class="shimmer-block shimmer-auth-title"></div>' +
          '<div class="shimmer-block shimmer-auth-sub"></div>' +
          '<div class="shimmer-block shimmer-auth-field"></div>' +
          '<div class="shimmer-block shimmer-auth-field"></div>' +
          '<div class="shimmer-block shimmer-auth-btn"></div>' +
        '</div>' +
      '</div>'
    );
  }

  function hidePageContent() {
    var content = document.getElementById('pageContent');
    if (content) {
      content.classList.remove('visible');
      content.style.visibility = 'hidden';
      content.style.opacity = '0';
    }
    document.body.classList.add('elms-submitting');
  }

  function showShimmer(type) {
    var shimmerType = type || getShimmerType();
    var existing = document.getElementById('shimmerScreen');

    if (existing) {
      existing.classList.remove('hidden');
      existing.setAttribute('data-type', shimmerType);
      return;
    }

    var screen = document.createElement('div');
    screen.id = 'shimmerScreen';
    screen.className = 'shimmer-screen';
    screen.setAttribute('data-type', shimmerType);
    screen.innerHTML = buildShimmerHtml(shimmerType);
    document.body.appendChild(screen);
  }

  function hideShimmer() {
    var screen = document.getElementById('shimmerScreen');
    var content = document.getElementById('pageContent');

    document.body.classList.remove('elms-submitting');

    if (content) {
      content.style.visibility = '';
      content.style.opacity = '';
      content.classList.add('visible');
    }

    if (!screen) return;

    screen.classList.add('hidden');

    setTimeout(function () {
      if (screen.parentNode) screen.parentNode.removeChild(screen);
    }, FADE_OUT_MS);
  }

  function reveal() {
    var start = window.__shimmerStart || Date.now();
    var elapsed = Date.now() - start;
    var remaining = Math.max(0, MIN_DISPLAY_MS - elapsed);
    setTimeout(hideShimmer, remaining);
  }

  function initFormShimmer() {
    document.querySelectorAll('form[data-shimmer-submit]').forEach(function (form) {
      form.addEventListener('submit', function (e) {
        if (!form.checkValidity()) return;

        var pswd = document.getElementById('pswd');
        var confirm = document.getElementById('confirmPswd');
        if (confirm && pswd && pswd.value !== confirm.value) return;

        e.preventDefault();
        hidePageContent();

        var shimmerType = form.getAttribute('data-shimmer-type') || 'auth';
        showShimmer(shimmerType);

        requestAnimationFrame(function () {
          requestAnimationFrame(function () {
            form.submit();
          });
        });
      });
    });
  }

  function initNavigationShimmer() {
    document.addEventListener('click', function (e) {
      var link = e.target.closest('a');
      if (!link || link.target === '_blank') return;

      var href = link.getAttribute('href');
      if (!href || href === '#' || href.charAt(0) === '#') return;
      if (href.indexOf('javascript:') === 0) return;

      hidePageContent();
      showShimmer();
    });
  }

  function init() {
    window.__shimmerStart = Date.now();
    initFormShimmer();
    initNavigationShimmer();

    if (document.readyState === 'complete') {
      reveal();
    } else {
      window.addEventListener('load', reveal);
    }
  }

  window.ELMSShimmer = {
    show: showShimmer,
    hide: hideShimmer
  };

  document.addEventListener('DOMContentLoaded', init);
})();
