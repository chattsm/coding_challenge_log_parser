# frozen_string_literal: true

require 'json'
require 'open3'

RSpec.describe './log_parser' do
  context 'with valid arguments' do
    it 'gives the correct response' do
      output = `./log_parser spec/support/fixtures/example.log`

      expect(output).to eq(JSON.generate({
        'page_views' => {
          '/help_page/1' => 3,
          '/about' => 2,
          '/home' => 1
        }
      }))
    end
  end

  context 'without any arguments' do
    it 'shows a useful error' do
      _, stderr, = Open3.capture3('./log_parser')

      expect(stderr).to include(
        'ERROR: "log_parser" was called with no arguments'
      )
    end
  end

  context 'with invalid arguments' do
    it 'shows a useful error' do
      _, stderr, = Open3.capture3('./log_parser --foo-bar=baz')

      expect(stderr).to include(
        'ERROR: "log_parser" was called with arguments "--foo-bar=baz"'
      )
    end
  end

  context 'with help flag' do
    it 'shows the usage instructions' do
      output = `./log_parser -h`

      expected_output = <<~OUTPUT
      Command:
        log_parser

      Usage:
        log_parser FILE_PATH

      Description:
        Command line tool for processing page view logs.

        Page view logs must be in the format :-
          [page_view] [ip_address]

        For example :-
          /home 184.123.665.067
          /about/2 444.701.448.104
          etc

      Arguments:
        FILE_PATH                         # REQUIRED Path to log file

      Options:
        --output-type=VALUE, -t VALUE     # Output type: (page_views/unique_page_views), default: "page_views"
        --output-format=VALUE, -f VALUE   # Output format: (json), default: "json"
        --help, -h                        # Print this help
      OUTPUT

      expect(output).to eq(expected_output)
    end
  end
end
