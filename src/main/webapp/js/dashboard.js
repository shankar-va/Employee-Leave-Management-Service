/**
 * ELMS Dashboard – Table filtering, search, statistics, and UI interactions
 */
(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function () {
    initTableSearch();
    initTableFilter();
    initStatBars();
    initRippleButtons();
    initDateValidation();
    initCharCounter();
    initPasswordStrength();
    initPasswordToggle();
    initConfirmPassword();
    initFloatingLabels();
  });

  /* ---- Table Search ---- */
  function initTableSearch() {
    var searchInput = document.getElementById('tableSearch');
    if (!searchInput) return;

    searchInput.addEventListener('input', function () {
      var query = this.value.toLowerCase().trim();
      var rows = document.querySelectorAll('.glass-table tbody tr[data-searchable]');
      rows.forEach(function (row) {
        var text = row.getAttribute('data-searchable').toLowerCase();
        row.style.display = text.indexOf(query) !== -1 ? '' : 'none';
      });
    });
  }

  /* ---- Table Status Filter ---- */
  function initTableFilter() {
    var filterSelect = document.getElementById('statusFilter');
    if (!filterSelect) return;

    filterSelect.addEventListener('change', function () {
      var status = this.value.toLowerCase();
      var rows = document.querySelectorAll('.glass-table tbody tr[data-status]');
      rows.forEach(function (row) {
        if (status === 'all') {
          row.style.display = '';
        } else {
          row.style.display = row.getAttribute('data-status').toLowerCase() === status ? '' : 'none';
        }
      });
    });
  }

  /* ---- Animated Stat Progress Bars ---- */
  function initStatBars() {
    var fills = document.querySelectorAll('.progress-fill[data-width]');
    fills.forEach(function (fill) {
      var target = fill.getAttribute('data-width');
      setTimeout(function () {
        fill.style.width = target + '%';
      }, 300);
    });
  }

  /* ---- Ripple Effect on Buttons ---- */
  function initRippleButtons() {
    document.querySelectorAll('.ripple').forEach(function (btn) {
      btn.addEventListener('click', function (e) {
        var rect = btn.getBoundingClientRect();
        var ripple = document.createElement('span');
        ripple.classList.add('ripple-effect');
        var size = Math.max(rect.width, rect.height);
        ripple.style.width = ripple.style.height = size + 'px';
        ripple.style.left = (e.clientX - rect.left - size / 2) + 'px';
        ripple.style.top = (e.clientY - rect.top - size / 2) + 'px';
        btn.appendChild(ripple);
        setTimeout(function () { ripple.remove(); }, 600);
      });
    });
  }

  /* ---- Date Validation (Apply Leave) ---- */
  function initDateValidation() {
    var startDate = document.getElementById('startDate');
    var endDate = document.getElementById('endDate');
    if (!startDate || !endDate) return;

    var today = new Date().toISOString().split('T')[0];
    startDate.setAttribute('min', today);

    startDate.addEventListener('change', function () {
      endDate.setAttribute('min', this.value);
      if (endDate.value && endDate.value < this.value) {
        endDate.value = this.value;
      }
      validateDates(startDate, endDate);
    });

    endDate.addEventListener('change', function () {
      validateDates(startDate, endDate);
    });
  }

  function validateDates(start, end) {
    var errorEl = document.getElementById('dateError');
    if (!errorEl) return;

    if (start.value && end.value && end.value < start.value) {
      errorEl.textContent = 'End date cannot be before start date.';
      errorEl.classList.add('visible');
      end.classList.add('is-invalid');
    } else {
      errorEl.classList.remove('visible');
      end.classList.remove('is-invalid');
    }
  }

  /* ---- Character Counter ---- */
  function initCharCounter() {
    var textarea = document.getElementById('reason');
    var counter = document.getElementById('charCounter');
    if (!textarea || !counter) return;

    var max = parseInt(textarea.getAttribute('maxlength'), 10) || 500;

    function update() {
      var len = textarea.value.length;
      counter.textContent = len + ' / ' + max;
      counter.classList.remove('warning', 'danger');
      if (len > max * 0.9) counter.classList.add('danger');
      else if (len > max * 0.75) counter.classList.add('warning');
    }

    textarea.addEventListener('input', update);
    update();
  }

  /* ---- Password Strength Meter ---- */
  function initPasswordStrength() {
    var pswd = document.getElementById('pswd');
    var fill = document.getElementById('strengthFill');
    var text = document.getElementById('strengthText');
    if (!pswd || !fill) return;

    pswd.addEventListener('input', function () {
      var val = this.value;
      var score = 0;
      if (val.length >= 6) score++;
      if (val.length >= 10) score++;
      if (/[A-Z]/.test(val)) score++;
      if (/[0-9]/.test(val)) score++;
      if (/[^A-Za-z0-9]/.test(val)) score++;

      fill.className = 'strength-fill';
      var labels = ['', 'weak', 'fair', 'good', 'strong'];
      var texts = ['', 'Weak', 'Fair', 'Good', 'Strong'];
      var idx = Math.min(Math.floor(score / 1.25), 4);
      if (val.length === 0) idx = 0;

      if (idx > 0) fill.classList.add(labels[idx]);
      if (text) text.textContent = val.length > 0 ? 'Strength: ' + texts[idx] : '';
    });
  }

  /* ---- Password Toggle ---- */
  function initPasswordToggle() {
    document.querySelectorAll('.password-toggle').forEach(function (toggle) {
      toggle.addEventListener('click', function () {
        var input = this.closest('.password-wrapper').querySelector('input');
        var isPassword = input.type === 'password';
        input.type = isPassword ? 'text' : 'password';
        this.querySelector('i').className = isPassword ? 'bi bi-eye-slash' : 'bi bi-eye';
      });
    });
  }

  /* ---- Confirm Password Validation ---- */
  function initConfirmPassword() {
    var pswd = document.getElementById('pswd');
    var confirm = document.getElementById('confirmPswd');
    var error = document.getElementById('confirmError');
    if (!pswd || !confirm) return;

    function validate() {
      if (confirm.value && pswd.value !== confirm.value) {
        if (error) {
          error.textContent = 'Passwords do not match.';
          error.classList.add('visible');
        }
        confirm.classList.add('is-invalid');
        return false;
      }
      if (error) error.classList.remove('visible');
      confirm.classList.remove('is-invalid');
      return true;
    }

    confirm.addEventListener('input', validate);
    pswd.addEventListener('input', validate);

    var form = confirm.closest('form');
    if (form) {
      form.addEventListener('submit', function (e) {
        if (!validate()) e.preventDefault();
      });
    }
  }

  /* ---- Floating Label Pre-fill Support ---- */
  function initFloatingLabels() {
    document.querySelectorAll('.form-floating-custom .form-control').forEach(function (input) {
      if (input.value) input.classList.add('has-value');
      input.addEventListener('input', function () {
        this.classList.toggle('has-value', this.value.length > 0);
      });
    });
  }

})();
