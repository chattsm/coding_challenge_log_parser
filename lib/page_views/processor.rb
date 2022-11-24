# frozen_string_literal: true

module PageViews
  class Processor
    def call(logs)
      grouped_logs = logs.group_by {|log| log.page }

      grouped_logs.map do |page, logs|
        OpenStruct.new(page: page, count: logs.count)
      end
    end
  end
end