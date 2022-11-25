# frozen_string_literal: true

require 'ostruct'

module Source
  class File
    LOG_FORMAT = /^\/[a-zA-Z0-9_\/]+\ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/.freeze

    def call(log_file_path)
      log_file = ::File.new(log_file_path)

      [].tap do |logs|
        log_file.each do |log_entry|
          next unless correct_log_format?(log_entry)

          page, ip_address = log_entry.split(/ /)

          logs << OpenStruct.new(page: page, ip_address: ip_address.strip)
        end
      end
    ensure
      log_file&.close
    end

    private

    def correct_log_format?(log_entry)
      return true if log_entry.match?(LOG_FORMAT)

      $stderr.puts "Log '#{log_entry.strip}' is in incorrect format"

      false
    end
  end
end
