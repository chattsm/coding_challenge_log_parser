# frozen_string_literal: true

require 'spec_helper'

require 'open3'

RSpec.describe './log_parser' do
  context 'with default --aggregator' do
    it 'gives the correct response' do
      output = `./log_parser spec/support/fixtures/example.log`

      expected_output = {
        'page_views' => {
          '/help_page/1' => 3,
          '/about' => 2,
          '/home' => 1
        }
      }

      expect(output).to eq(generate_json(expected_output))
    end
  end

  context 'with --aggregator=unique_page_views' do
    it 'gives the correct response' do
      output = `./log_parser --aggregator=unique_page_views spec/support/fixtures/example.log`

      expected_output = {
        'unique_page_views' => {
          '/help_page/1' => 2,
          '/home' => 1,
          '/about' => 1
        }
      }

      expect(output).to eq(generate_json(expected_output))
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
end
