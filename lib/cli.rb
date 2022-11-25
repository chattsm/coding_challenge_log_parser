# frozen_string_literal: true

require 'source/file'
require 'processor/factory'
require 'presenter/factory'
require 'log_parser'

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
    LogParser.new(
      source: Source::File.new(file_path),
      processor: Processor::Factory.for(options[:output_type]),
      presenter: Presenter::Factory.for(options[:output_type])
    ).call
  end
end
