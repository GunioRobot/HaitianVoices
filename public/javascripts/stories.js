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

  $('.img_expand').hover(function(e) {
    var xOffset = 10; /* default values for offset from cursor */
    var yOffset = 30;
    this.tmp_title = this.title;
    this.title = "";
    var c = (this.tmp_title != "") ? "<br/>" + this.tmp_title : "";
/*    $("body").append("<p id='imageview' style='position:absolute;'><img src='"+ this.src +"' alt='Image preview' />"+ c +"</p>"); */
    $("body").append("<p id='imagepreviewer'><img src='"+ $(this).next('span').find('img').attr('src') +"' alt='Image preview' />"+ c +"</p>");
    $("#imagepreviewer").css("top",(e.pageY - xOffset) + "px").css("left",(e.pageX + yOffset) + "px").fadeIn("fast");      
  },
  function() {
    this.title = this.tmp_title;
    $("#imagepreviewer").remove();
  });

  $('.img_expand').mousemove(function(e) {
    var xOffset = 10; /* default values for offset from cursor */
    var yOffset = 30;
    $("#imagepreviewer").css("top",(e.pageY - xOffset) + "px").css("left",(e.pageX + yOffset) + "px");
  });


})