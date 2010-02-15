jQuery(function($){
  // called when user adds a photo to a new story
  $('.photo_field').change(function() {
    if ($(this).hasClass('newest')) {
      var new_el = $(this).parent().clone();
      $(this).removeClass('newest').parent().find('span.photo_description').show();
      new_el.find('.photo_field').change(arguments.callee).val('');
      new_el.appendTo('#photos');
    }
    return false;
  })

  // called when the user hovers over a photo thumbnail
  $('.img_expand').hover(function(e) {
    var preview_img =  $(this).next('span').find('img');
    this.tmp_title = this.title;
    this.title = "";
    if( preview_img.length > 0 )  {
      $("body").append("<p id='imagepreviewer' style='max-width:" + preview_img.attr('width') + "px'> \
                        <img src='"+ preview_img.attr('src') +"' alt='Image preview' /><br />"+ this.tmp_title +"</p>");
      positionPreviewer(e);
    }
    else {
      $("body").append("<p id='imagepreviewer' style='display:none;'></p>");
      loadImage(e, $(this).attr('pic_url') + '?size=' + getSize(window.innerHeight, window.innerWidth));
    }
  },
  function() {
    this.title = this.tmp_title;
    $("#imagepreviewer").remove();
  });

  // repositions previewer
  $('.img_expand').mousemove(function(e) {
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

  // creating body of previewer
  createPreviewer = function(parent_el_id, cap) {
    img = $('#' + parent_el_id).find('img');
    $("#imagepreviewer").append(img.clone()).append('<br />' + cap).css("max-width",img.attr('width') + "px");
  }

  // positioning previewer based on X and Y offset from cursor
  positionPreviewer = function(e) {
    $("#imagepreviewer").css("top",(e.pageY + yOffset(e)) + "px").css("left",(e.pageX + xOffset(e)) + "px");
  }

  // get image size based on dimensions
  getSize = function(h, w) {
    if ((h > 480) && (w > 1440)) { return "L"; }
    else if ((h > 360) && (w > 960)) { return "M"; }
    else { return "S"; }
  }

  // getting parameters for loading image via XML
  loadImage = function(e, pic_url) {
    $.ajax({
      type: "GET",
      url: pic_url,
      dataType: "xml",
      success: function(xml) { return parsePictureXml(e, xml) }
    });
  }

  // saving image into DOM then loading previewer
  parsePictureXml = function(e, xml) {
    // find picture and append contents to image viewer
    $(xml).find("picture").each(function()
    {
      var parent_el_id = $(this).find("id").text();
      var photo_url = $(this).find("photo").text();
      var photo_cap = $(this).find("caption").text();
      var img = new Image();
  
      // run previewer-loading code after image loads
      $(img).load(function () {
        $('#' + parent_el_id).append($(this));
        createPreviewer( parent_el_id, photo_cap );
        positionPreviewer( e );
	$("#imagepreviewer").show()
      }).attr('src', photo_url);
      
    });
  }

});