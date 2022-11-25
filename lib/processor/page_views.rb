# frozen_string_literal: true

module Processor
  class PageViews
    def call(logs)
      logs_grouped_by_page = logs.group_by { |log| log.page }

      logs_grouped_by_page.map do |page, logs|
        OpenStruct.new(page: page, count: logs.count)
      end
    end
  end
end