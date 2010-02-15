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
    this.tmp_title = this.title;
    this.title = "";
    var c = (this.tmp_title != "") ? "<br/>" + this.tmp_title : "";
    if( preview_img.length > 0 )  {
      $("body").append("<p id='imagepreviewer' style='max-width:" + preview_img.attr('width') + "px'><img src='"+ preview_img.attr('src') +"' alt='Image preview' />"+ c +"</p>");
      positionPreviewer(e);
    }
    else {
      $("body").append("<p id='imagepreviewer></p>");
      positionPreviewer(e);
      loadImage($(this).attr('pic_url'));
    }
  },
  function() {
    this.title = this.tmp_title;
    $("#imagepreviewer").remove();
  });

  $('.img_expand').mousemove(function(e) {
    // RWP: state logic for picture loading goes here
    positionPreviewer(e);
  });

  // calculates X offset: show pic right of cursor normally, or left of cursor if image would get clipped off
  // the right edge.
  xOffset = function(e) {
    var xDistanceFromRightEnd = window.innerWidth - e.pageX - $("#imagepreviewer").innerWidth() - 10;
    return (xDistanceFromRightEnd > 0) ? 10 : (-10 - $("#imagepreviewer").innerWidth());
  }

  // calculate Y offset: directly under cursor normally, or along bottom edge if image would get clipped
  // off the bottom edge.
  yOffset = function(e)  {
    var yDistanceFromBottom = window.innerHeight - e.pageY - $("#imagepreviewer").innerHeight() - 30;
    return (yDistanceFromBottom > 0) ? 30 : (30 + yDistanceFromBottom);
  }

  createPreviewer = function(parent_el_id, cap) {
    $("#imagepreviewer").append($('#' + parent_el_id).find('img').clone()).append(cap);
  }

  positionPreviewer = function(e) {
    $("#imagepreviewer").css("top",(e.pageY + yOffset(e)) + "px").css("left",(e.pageX + xOffset(e)) + "px");
  }

  loadImage = function(pic_url) {
    $.ajax({
      type: "GET",
      url: pic_url,
      dataType: "xml",
      success: parsePictureXml
    });
  }

  parsePictureXml = function(xml) {
    // find picture and append contents to image viewer
    $(xml).find("picture").each(function()
    {
      var parent_el_id = $(this).find("id").text();
      var photo_url = $(this).find("photo").text();
      var img = new Image();
  
      // run previewer-loading code after image loads
      $(img).load(function () {
	$('#' + parent_el_id).append($(this));
	createPreviewer( parent_el_id, $(this).find("caption").text() );
      }).attr('src', photo_url);
      
    });
  }

});