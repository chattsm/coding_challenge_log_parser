# frozen_string_literal: true

class Log
  def initialize(page:, ip_address:)
    @page = page
    @ip_address = ip_address
  end

  def ==(other)
    page == other.page && ip_address == other.ip_address
  end

  attr_reader :page, :ip_address
end
