<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Confirmation Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content glass-card" style="background: rgba(15, 23, 42, 0.85); border: 1px solid rgba(255,255,255,0.12);">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title text-white" id="confirmModalLabel">
          <i class="bi bi-exclamation-triangle text-warning me-2"></i>Confirm Action
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p class="text-secondary mb-0" id="confirmModalBody">Are you sure you want to proceed?</p>
      </div>
      <div class="modal-footer border-0 pt-0">
        <button type="button" class="btn btn-glass-outline ripple" data-bs-dismiss="modal">Cancel</button>
        <a href="#" id="confirmModalAction" class="btn btn-glass ripple">Confirm</a>
      </div>
    </div>
  </div>
</div>
<script>
  function confirmAction(url, message) {
    document.getElementById('confirmModalBody').textContent = message || 'Are you sure you want to proceed?';
    document.getElementById('confirmModalAction').href = url;
    var modal = new bootstrap.Modal(document.getElementById('confirmModal'));
    modal.show();
    return false;
  }
</script>
