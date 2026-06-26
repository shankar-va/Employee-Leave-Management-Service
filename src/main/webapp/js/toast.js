/**
 * ELMS Toast Notification System
 */
(function () {
  'use strict';

  var container = null;
  var TOAST_DURATION = 4500;

  function getContainer() {
    if (!container) {
      container = document.getElementById('toastContainer');
      if (!container) {
        container = document.createElement('div');
        container.id = 'toastContainer';
        container.className = 'toast-container-custom';
        document.body.appendChild(container);
      }
    }
    return container;
  }

  function getIcon(type) {
    switch (type) {
      case 'success': return 'bi-check-circle-fill';
      case 'error':   return 'bi-x-circle-fill';
      case 'info':    return 'bi-info-circle-fill';
      default:        return 'bi-bell-fill';
    }
  }

  function showToast(message, type) {
    type = type || 'info';
    var el = document.createElement('div');
    el.className = 'toast-item toast-' + type;
    el.innerHTML =
      '<i class="bi ' + getIcon(type) + '"></i>' +
      '<span>' + escapeHtml(message) + '</span>';

    getContainer().appendChild(el);

    setTimeout(function () {
      el.classList.add('hiding');
      setTimeout(function () { el.remove(); }, 350);
    }, TOAST_DURATION);
  }

  function escapeHtml(str) {
    var div = document.createElement('div');
    div.appendChild(document.createTextNode(str));
    return div.innerHTML;
  }

  window.showToast = showToast;
  window.showSuccessToast = function (msg) { showToast(msg, 'success'); };
  window.showErrorToast = function (msg) { showToast(msg, 'error'); };
  window.showInfoToast = function (msg) { showToast(msg, 'info'); };

  /* Auto-show toasts from server session attributes */
  document.addEventListener('DOMContentLoaded', function () {
    var successMsg = document.getElementById('toastSuccess');
    var failureMsg = document.getElementById('toastFailure');
    var infoMsg = document.getElementById('toastMessage');

    if (successMsg && successMsg.value) {
      showToast(successMsg.value, 'success');
    }
    if (failureMsg && failureMsg.value) {
      showToast(failureMsg.value, 'error');
    }
    if (infoMsg && infoMsg.value) {
      showToast(infoMsg.value, 'info');
    }
  });
})();
