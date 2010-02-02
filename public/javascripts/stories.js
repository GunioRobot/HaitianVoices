jQuery(function($){
  $('.photo_field').change(function() {
    if ($(this).hasClass('newest')) {
      var new_el = $(this).parent().clone();
      $(this).removeClass('newest').parent().find('span.photo_description').show();
      new_el.find('.photo_field').change(arguments.callee).val('');
      new_el.appendTo('#photos');
    }
    return false;
  })
})