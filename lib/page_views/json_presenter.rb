# frozen_string_literal: true

require 'json'

module PageViews
  class JSONPresenter
    def call(input)
      output = { 'page_views' => input }

      print JSON.generate(output)
    end
  end
end