require 'rake'
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'pp'
require 'andand'

namespace :web do
  desc "Uses hpricot to scrap some content"
  task :scrap_boston_globe_big_picture do

    articles = {}

    BOSTON_BIG_PICTURE_URLS = 
      [
      "http://www.boston.com/bigpicture/2010/01/faces_of_haiti.html",
      "http://www.boston.com/bigpicture/2010/01/earthquake_in_haiti.html",
      "http://www.boston.com/bigpicture/2010/01/haiti_48_hours_later.html",
      "http://www.boston.com/bigpicture/2010/01/haiti_six_days_later.html"     
    ]

    BOSTON_BIG_PICTURE_URLS.each { |url|
      img_src = []
      captions = []

      doc = Hpricot(open(url))

      head_div = doc.at('//div[@class="headDiv2"]')

      title = head_div.at('/h2/a').inner_text
      body = head_div.at('/div[2]').inner_text



      first_img = head_div.at('/div[3]/a[2]/img')
      splits = first_img.andand.get_attribute('src').split('/')


      img_src << splits[-1]
      image_folder = splits[-2]

      first_caption = head_div.at('/div[3]/div').inner_text
      captions << first_caption

     
      bp_boths = head_div.search('//div[@class="bpBoth"]')
      bp_boths.each { |b|

        img_elem = b.at('/img')
        if img_elem then
          img_src << img_elem.get_attribute('src').split('/')[-1]
          

          caption_div = b.at('/div[2]')
          caption_div.search('/div').remove #remove number
          captions << caption_div.inner_text
        end 
      }

      articles[title] = ["Boston Globe's Big Picture", image_folder, body, img_src, captions]
    }

    yaml_str = YAML::dump(articles)

    puts yaml_str
    
  end #task

  desc "Creates Story and pictures from Boston Globe's Big Picture YAML"
  task :bg do
    load 'config/environment.rb'
    
    #hack in a language, if we need to
    @language = Language.find_by_title('English') || Language.create(:title => 'English')
    
    bg_articles = YAML.load_file( RAILS_ROOT + '/content/boston_globe_big_picture_blog_posts.yml')
    
    Story.delete_all
    Picture.delete_all
    
    bg_articles.each_pair {|title, array|
      folder = array[1]
      tags = array[2]
      article_body = array[3]
      images = array[4]
      captions = array[5]
      
      if( images.length!=captions.length )
        puts "SOMEBODY WAS MESSING WITH THE YAML FILE!!!"
      else
        new_story = Story.create(:title => title, :body =>  article_body, :approved => true,
          :about => "Boston Globe's article", :language_id => @language.id )
        new_story.tag_list = tags

        captions.each_with_index { |e, i|         
          new_story.pictures.create(:caption => e, :photo_file_name=> "#{folder}/#{images[i]}" )
        }

        new_story.save
      end
      
    }

  end

end #namespace