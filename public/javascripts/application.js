$(document).ready(function() {
  $('#filter').change(function(){
    query = $.query.set('filter', $(this).val());
    window.location = window.location.pathname + query;
  });

  $('.sort').click(function(){
    sort = $.query.get('sort');
    if(sort == 'desc'){
      sort = 'asc';
    } else {
      sort = 'desc';
    }
    query = $.query.set('sort', sort);
    window.location = window.location.pathname + query;
    return false;
  });
});

