# frozen_string_literal: true

require 'page_views/processor'
require 'page_views/presenter'

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

  option :output_format,
    aliases: %w[f],
    desc: 'Output format',
    values: %w[json],
    default: 'json'

  def call(file_path:, **options)
    logs = PageViews::Processor.new.call([
      OpenStruct.new(page: '/help_page/1', ip_address: '126.318.035.038'),
      OpenStruct.new(page: '/home', ip_address: '184.123.665.067'),
      OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
      OpenStruct.new(page: '/help_page/1', ip_address: '929.398.951.889'),
      OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
      OpenStruct.new(page: '/help_page/1', ip_address: '722.247.931.582')
    ])

    PageViews::Presenter.new.call(logs)
  end
end
