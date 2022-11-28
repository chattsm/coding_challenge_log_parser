# frozen_string_literal: true

class PageAggregate
  def initialize(page:, count:)
    @page = page
    @count = count
  end

  def ==(other)
    page == other.page && count == other.count
  end

  attr_reader :page, :count
end
