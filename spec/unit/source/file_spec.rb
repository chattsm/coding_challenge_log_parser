# frozen_string_literal: true

require 'spec_helper'

require 'source/file'

RSpec.describe Source::File do
  subject(:parser) { described_class.new(log_file_path) }

  context 'when the logs file can be found' do
    let(:log_file_path) { fixture_path('example.log') }

    it 'returns the correct results' do
      expected_output = [
        OpenStruct.new(page: '/help_page/1', ip_address: '126.318.035.038'),
        OpenStruct.new(page: '/home', ip_address: '184.123.665.067'),
        OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
        OpenStruct.new(page: '/help_page/1', ip_address: '929.398.951.889'),
        OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
        OpenStruct.new(page: '/help_page/1', ip_address: '126.318.035.038')
      ]

      expect(parser.call).to eq(expected_output)
    end
  end

  context 'when the log file cannot be found' do
    let(:log_file_path) { 'foo/bar.log' }

    it 'raises an error' do
      expect { parser.call }.to raise_error(SystemCallError)
    end
  end

  context 'when the log file is empty' do
    let(:log_file_path) { fixture_path('empty.log') }

    it 'returns an empty array' do
      expect(parser.call).to eq([])
    end
  end

  context 'when the log file contains data in an unknown format' do
    let(:log_file_path) { fixture_path('badly_formatted.log') }

    it 'returns only the data that it can parse' do
      allow($stderr).to receive(:puts)

      expected_output = [
        OpenStruct.new(page: '/about', ip_address: '444.701.448.104')
      ]

      expect(parser.call).to eq(expected_output)
    end

    it 'prints useful errors to stdout' do
      expect { parser.call }.to output(/in incorrect format/).to_stderr
    end
  end
end
