
NEWS_URL = "http://news.crisiscommons.org/rss/all/rss.xml"

class NewsController < ApplicationController
  def index
    @rss_items = RSS::Parser.parse(open(NEWS_URL).read, false).andand.items[0..15]
  end
end
