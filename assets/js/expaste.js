$(document).ready(function() {
  $('#share').on('click', function(e) {
    e.preventDefault();

    var url = window.location.href + '?l=' + $('#session').val();
    copyToClipboard(url);

    $('.alert-info').html('Sharable URL copied to your clipboard!');

    return;
  });
});

function copyToClipboard(value) {
  const area = document.createElement('textarea');
  document.body.appendChild(area);


  area.value = value;
  area.textContent = value;

  area.select();
  document.execCommand('copy');
  document.body.removeChild(area);
}

// vim: set ts=2 sw=2 et:
