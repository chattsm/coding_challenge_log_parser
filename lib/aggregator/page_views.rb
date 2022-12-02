# frozen_string_literal: true

require 'page_aggregate'

module Aggregator
  class PageViews
    def call(logs)
      logs_grouped_by_page = logs.group_by(&:page)

      logs_grouped_by_page.map do |page, page_logs|
        PageAggregate.new(page:, count: page_logs.count)
      end
    end
  end
end
