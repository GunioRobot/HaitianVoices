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
    var preview_img =  $(this).next('span').find('img');
    /* default values for offset from cursor */
    var xOffset = 10;
    /* calculating Y offset from cursor, adjusting for bottom of window */
    var yDistanceFromBottom = window.innerHeight - e.pageY - preview_img.attr('height') - 30;
    var yOffset = (yDistanceFromBottom > 0) ? 30 : (30 + yDistanceFromBottom);
    this.tmp_title = this.title;
    this.title = "";
    var c = (this.tmp_title != "") ? "<br/>" + this.tmp_title : "";
    $("body").append("<p id='imagepreviewer'><img src='"+ preview_img.attr('src') +"' alt='Image preview' />"+ c +"</p>");
    $("#imagepreviewer").css("top",(e.pageY + yOffset) + "px").css("left",(e.pageX + xOffset) + "px").fadeIn("fast");      
  },
  function() {
    this.title = this.tmp_title;
    $("#imagepreviewer").remove();
  });

  $('.img_expand').mousemove(function(e) {
    /* default values for offset from cursor */
    var xOffset = 10; 
    /* calculating Y offset from cursor, adjusting for bottom of window */
    var yDistanceFromBottom = window.innerHeight - e.pageY - $("#imagepreviewer").innerHeight() - 30;
    var yOffset = (yDistanceFromBottom > 0) ? 30 : (30 + yDistanceFromBottom);
    $("#imagepreviewer").css("top",(e.pageY + yOffset) + "px").css("left",(e.pageX + xOffset) + "px");
  });

})