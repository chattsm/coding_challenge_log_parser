# frozen_string_literal: true

require 'spec_helper'

require 'source/file'

RSpec.describe Source::File do
  subject(:parser) { described_class.new }

  context 'when the logs file can be found' do
    it 'returns the correct results' do
      parsed_logs = parser.call(fixture_path('example.log'))

      expect(parsed_logs).to eq([
        OpenStruct.new(page: '/help_page/1', ip_address: '126.318.035.038'),
        OpenStruct.new(page: '/home', ip_address: '184.123.665.067'),
        OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
        OpenStruct.new(page: '/help_page/1', ip_address: '929.398.951.889'),
        OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
        OpenStruct.new(page: '/help_page/1', ip_address: '722.247.931.582')
      ])
    end
  end

  context 'when the log file cannot be found' do
    it 'raises an error' do
      # TODO: raise own error wrapping SystemCallError
      expect { parser.call('foo/bar.log') }.to raise_error(SystemCallError)
    end
  end

  context 'when the log file is empty' do
    it 'returns an empty array' do
      parsed_logs = parser.call(fixture_path('empty.log'))

      expect(parsed_logs).to eq([])
    end
  end

  context 'when the log file contains data in an unknown format' do
    it 'returns only the data that it can parse' do
      allow($stderr).to receive(:puts)

      parsed_logs = parser.call(fixture_path('badly_formatted.log'))

      expect(parsed_logs).to eq([
        OpenStruct.new(page: '/about', ip_address: '444.701.448.104')
      ])
    end

    it 'prints useful errors to stdout' do
      expect {
        parser.call(fixture_path('badly_formatted.log'))
       }.to output(/in incorrect format/).to_stderr
    end
  end
end
