# frozen_string_literal: true

require 'presenter/sortable'
require 'presenter/jsonprintable'

module Presenter
  class PageViews
    include Sortable
    include JSONPrintable

    def call(logs)
      logs.then { |logs| sort_descending(logs) }
          .then { |logs| reformat_to_hash(logs) }
          .then { |logs| print_json(:page_views, logs) }
    end
  end
end