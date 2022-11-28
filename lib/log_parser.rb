# frozen_string_literal: true

require 'dry/cli'

require 'source/file'
require 'processor/for'
require 'presenter/for'

class LogParser < Dry::CLI::Command
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
    source = Source::File.new(file_path)
    processor = Processor::For.call(options[:output_type])
    presenter = Presenter::For.call(options[:output_type])

    presenter.call(processor.call(source.call))
  end
end
