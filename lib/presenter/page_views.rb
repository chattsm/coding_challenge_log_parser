# frozen_string_literal: true

require 'json'

module Presenter
  class PageViews
    def call(logs)
      logs.then { |logs| sort_descending(logs) }
          .then { |logs| reformat_to_hash(logs) }
          .then { |logs| print_json(:page_views, logs) }
    end

    private

    def sort_descending(logs)
      logs.sort do |log, log_compare|
        log_compare.count <=> log.count
      end
    end

    def reformat_to_hash(logs)
      logs.inject({}) do |logs_hash, log|
        logs_hash.tap { |logs_hash| logs_hash[log.page] = log.count }
      end
    end

    def print_json(top_level_name, logs)
      print JSON.generate({ top_level_name => logs })
    end
  end
end