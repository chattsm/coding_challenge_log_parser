# frozen_string_literal: true

require 'presenter/page_views'
require 'presenter/unique_page_views'

module Presenter
  class For
    def self.call(type)
      {
        'page_views' => PageViews,
        'unique_page_views' => UniquePageViews
      }.fetch(type).new
    end
  end
end
