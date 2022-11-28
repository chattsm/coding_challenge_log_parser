# frozen_string_literal: true

require 'page_aggregate'

module Aggregator
  class PageViews
    def call(logs_to_process)
      logs_grouped_by_page = logs_to_process.group_by(&:page)

      logs_grouped_by_page.map do |page, logs|
        PageAggregate.new(page:, count: logs.count)
      end
    end
  end
end
