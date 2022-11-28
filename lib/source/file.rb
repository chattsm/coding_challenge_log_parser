# frozen_string_literal: true

require 'log'

module Source
  class File
    LOG_FORMAT = %r{^/[a-zA-Z0-9_/]+\ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$}

    def initialize(log_file_path)
      @log_file_path = log_file_path
    end

    def call
      log_file = ::File.new(log_file_path)

      [].tap do |logs|
        log_file.each do |log_entry|
          next unless correct_log_format?(log_entry)

          page, ip_address = log_entry.split(/ /)

          logs << Log.new(page:, ip_address: ip_address.strip)
        end
      end
    ensure
      log_file&.close
    end

    private

    attr_reader :log_file_path

    def correct_log_format?(log_entry)
      return true if log_entry.match?(LOG_FORMAT)

      warn "Log '#{log_entry.strip}' is in incorrect format"

      false
    end
  end
end
