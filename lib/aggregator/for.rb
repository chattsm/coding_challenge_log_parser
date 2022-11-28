# frozen_string_literal: true

require 'aggregator/page_views'
require 'aggregator/unique_page_views'

module Aggregator
  class For
    def self.call(type)
      {
        'page_views' => PageViews,
        'unique_page_views' => UniquePageViews
      }.fetch(type).new
    end
  end
end
