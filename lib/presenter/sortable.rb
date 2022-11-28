# frozen_string_literal: true

module Presenter
  module Sortable
    private

    def sort_descending(page_aggregates)
      page_aggregates.sort do |page_aggregate, other|
        other.count <=> page_aggregate.count
      end
    end
  end
end
