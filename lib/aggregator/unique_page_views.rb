# frozen_string_literal: true

require 'page_aggregate'

module Aggregator
  class UniquePageViews
    def call(logs)
      logs_grouped_by_page = logs.group_by(&:page)

      logs_grouped_by_page.map do |page, page_logs|
        unique_page_logs = page_logs.uniq(&:ip_address)

        PageAggregate.new(page:, count: unique_page_logs.count)
      end
    end
  end
end
