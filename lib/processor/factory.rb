require 'processor/page_views'
require 'processor/unique_page_views'

module Processor
  class Factory
    def self.for(type)
      {
        'page_views' => PageViews,
        'unique_page_views' => UniquePageViews
      }.fetch(type).new
    end
  end
end