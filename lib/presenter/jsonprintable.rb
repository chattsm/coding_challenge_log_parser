# frozen_string_literal: true

require 'json'

module Presenter
  module JSONPrintable
    private

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