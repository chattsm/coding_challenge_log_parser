# frozen_string_literal: true

module Processor
  class PageViews
    def call(logs_to_process)
      logs_grouped_by_page = logs_to_process.group_by(&:page)

      logs_grouped_by_page.map do |page, logs|
        OpenStruct.new(page: page, count: logs.count)
      end
    end
  end
end
