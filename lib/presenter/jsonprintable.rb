# frozen_string_literal: true

require 'json'

module Presenter
  module JSONPrintable
    private

    def reformat_to_hash(page_aggregates)
      page_aggregates.inject({}) do |page_aggregates_hash, page_aggregate|
        page_aggregates_hash.tap do |hash|
          hash[page_aggregate.page] = page_aggregate.count
        end
      end
    end

    def print_json(top_level_name, page_aggregates_hash)
      print JSON.generate({ top_level_name => page_aggregates_hash })
    end
  end
end
