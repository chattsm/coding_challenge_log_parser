# frozen_string_literal: true

require 'log'

module Source
  class File
    LOG_FORMAT = %r{^/[a-zA-Z0-9_/]+\ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$}

    def initialize(log_file_path)
      @log_file = ::File.new(log_file_path)
    rescue SystemCallError => e
      warn "Unable to read file - #{e}"
      exit 1
    end

    def call
      [].tap do |logs|
        log_file.each do |log_entry|
          next unless correct_log_format?(log_entry)

          page, ip_address = log_entry.split(/ /)

          logs << Log.new(page:, ip_address: ip_address.strip)
        end

        log_file.close
      end
    end

    private

    attr_reader :log_file

    def correct_log_format?(log_entry)
      return true if log_entry.match?(LOG_FORMAT)

      warn "Log '#{log_entry.strip}' is in incorrect format"

      false
    end
  end
end
