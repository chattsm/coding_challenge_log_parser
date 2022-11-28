# frozen_string_literal: true

module Presenter
  module Sortable
    private

    def sort_descending(logs)
      logs.sort do |log, log_compare|
        log_compare.count <=> log.count
      end
    end
  end
end
