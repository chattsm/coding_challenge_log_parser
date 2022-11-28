# frozen_string_literal: true

require 'dry/cli'

require 'source/file'
require 'aggregator/for'
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

  option :aggregator,
         aliases: %w[t],
         desc: 'Aggregator',
         values: %w[page_views unique_page_views],
         default: 'page_views'

  def call(file_path:, **options)
    source = Source::File.new(file_path)
    aggregator = Aggregator::For.call(options[:aggregator])
    presenter = Presenter::For.call(options[:aggregator])

    presenter.call(aggregator.call(source.call))
  end
end
