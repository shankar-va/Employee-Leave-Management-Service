/**
 * ELMS Employee Management – search UI & delete confirmation
 */
(function () {
  'use strict';

  window.setSearchType = function (type, btn) {
    var typeInput = document.getElementById('type');
    var keyword = document.getElementById('keyword');
    var label = document.getElementById('keywordLabel');
    if (!typeInput) return;

    typeInput.value = type;
    document.querySelectorAll('.search-type-tab').forEach(function (t) {
      t.classList.remove('active');
    });
    if (btn) btn.classList.add('active');

    if (type === 'dept') {
      if (label) label.innerHTML = '<i class="fa-solid fa-building me-1"></i> Department';
      if (keyword) keyword.placeholder = 'Enter department name...';
    } else {
      if (label) label.innerHTML = '<i class="fa-solid fa-user me-1"></i> Employee Name';
      if (keyword) keyword.placeholder = 'Enter employee name...';
    }
  };

  window.confirmDelete = function (url, name) {
    return confirmAction(
      url,
      'Are you sure you want to delete employee "' + name + '"? This action cannot be undone.'
    );
  };
})();
