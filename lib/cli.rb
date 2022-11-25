# frozen_string_literal: true

require 'source/file'
require 'processor/factory'
require 'presenter/factory'

class CLI < Dry::CLI::Command
  desc 'Command line tool for processing page view logs.

  Page view logs must be in the format :-
    [page_view] [ip_address]

  For example :-
    /home 184.123.665.067
    /about/2 444.701.448.104
    etc'

  argument :file_path,
    required: true,
    aliases: %w[f],
    desc: 'Path to log file'

  option :output_type,
    aliases: %w[t],
    desc: 'Output type',
    values: %w[page_views unique_page_views],
    default: 'page_views'

  def call(file_path:, **options)
    source_logs = Source::File.new.call(file_path)

    processed_logs = Processor::Factory.for(options[:output_type]).call(source_logs)

    Presenter::Factory.for(options[:output_type]).call(processed_logs)
  end
end
