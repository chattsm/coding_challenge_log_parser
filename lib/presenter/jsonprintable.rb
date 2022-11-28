# frozen_string_literal: true

require 'json'

module Presenter
  module JSONPrintable
    private

    def reformat_to_hash(logs_to_reformat)
      logs_to_reformat.inject({}) do |logs_hash_memo, log|
        logs_hash_memo.tap { |logs_hash| logs_hash[log.page] = log.count }
      end
    end

    def print_json(top_level_name, logs_hash)
      print JSON.generate({ top_level_name => logs_hash })
    end
  end
end
