# frozen_string_literal: true

require 'presenter/sortable'
require 'presenter/jsonprintable'

module Presenter
  class PageViews
    include Sortable
    include JSONPrintable

    def call(page_aggregates)
      page_aggregates.then { |aggregates| sort_descending(aggregates) }
                     .then { |aggregates| reformat_to_hash(aggregates) }
                     .then { |aggregates| print_json(:page_views, aggregates) }
    end
  end
end
