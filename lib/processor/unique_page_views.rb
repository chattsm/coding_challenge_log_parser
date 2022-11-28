# frozen_string_literal: true

module Processor
  class UniquePageViews
    def call(logs)
      logs_grouped_by_page = logs.group_by(&:page)

      logs_grouped_by_page.map do |page, all_logs|
        unique_log = all_logs.uniq(&:ip_address)

        OpenStruct.new(page: page, count: unique_log.count)
      end
    end
  end
end
