
#NEWS_URL = "http://news.crisiscommons.org/rss/all/rss.xml"

NEWS_URL = "http://www.techmeme.com/index.xml"

class NewsController < ApplicationController
  def index
    @rss_items = RSS::Parser.parse(open(NEWS_URL).read, false).andand.items[0..15]
  end
end
