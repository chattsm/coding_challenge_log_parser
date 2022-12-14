# frozen_string_literal: true

require 'spec_helper'

require 'source/file'

RSpec.describe Source::File do
  subject(:parser) { described_class.new(log_file_path) }

  context 'when the logs file can be found' do
    let(:log_file_path) { fixture_path('example.log') }

    it 'returns the correct results' do
      expected_output = [
        Log.new(page: '/help_page/1', ip_address: '126.318.035.038'),
        Log.new(page: '/home', ip_address: '184.123.665.067'),
        Log.new(page: '/about', ip_address: '444.701.448.104'),
        Log.new(page: '/help_page/1', ip_address: '929.398.951.889'),
        Log.new(page: '/about', ip_address: '444.701.448.104'),
        Log.new(page: '/help_page/1', ip_address: '126.318.035.038')
      ]

      expect(parser.call).to eq(expected_output)
    end
  end

  context 'when the log file cannot be found' do
    let(:log_file_path) { 'foo/bar.log' }

    it 'prints a useful error to stdout' do
      expect do
        parser.call
      rescue SystemExit
        # Suppress error so other tests can run!
      end.to output(/Unable to read file/).to_stderr
    end

    it 'exits with a SystemExit error' do
      allow(Warning).to receive(:warn)

      expect { parser.call }.to raise_error(SystemExit)
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
      allow(Warning).to receive(:warn)

      expected_output = [
        Log.new(page: '/about', ip_address: '444.701.448.104')
      ]

      expect(parser.call).to eq(expected_output)
    end

    it 'prints useful errors to stdout' do
      expect { parser.call }.to output(/in incorrect format/).to_stderr
    end
  end
end
