jQuery(function($){
  $('.photo_field').change(function(){
    $('<br />').appendTo('#photos')
    $(this).clone().change(arguments.callee).val('').appendTo('#photos')
    return false
  })
})