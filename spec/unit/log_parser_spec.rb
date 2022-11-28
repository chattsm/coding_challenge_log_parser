# frozen_string_literal: true

require 'spec_helper'

require 'log_parser'

RSpec.describe LogParser do
  subject(:log_parser) do
    described_class.new.call(file_path:, output_type:)
  end

  describe 'page_views' do
    let(:output_type) { 'page_views' }

    context 'when file is not empty' do
      let(:file_path) { 'spec/support/fixtures/example.log' }

      it 'gives the correct response' do
        expected_output = {
          'page_views' => {
            '/help_page/1' => 3,
            '/about' => 2,
            '/home' => 1
          }
        }

        expect { log_parser }.to output(generate_json(expected_output)).to_stdout
      end
    end

    context 'when file is empty' do
      let(:file_path) { 'spec/support/fixtures/empty.log' }

      it 'gives the correct response' do
        expected_output = {
          'page_views' => {}
        }

        expect { log_parser }.to output(generate_json(expected_output)).to_stdout
      end
    end
  end

  describe 'unique_page_views' do
    let(:output_type) { 'unique_page_views' }

    context 'when file is not empty' do
      let(:file_path) { 'spec/support/fixtures/example.log' }

      it 'gives the correct response' do
        expected_output = {
          'unique_page_views' => {
            '/help_page/1' => 2,
            '/home' => 1,
            '/about' => 1
          }
        }

        expect { log_parser }.to output(generate_json(expected_output)).to_stdout
      end
    end

    context 'when file is empty' do
      let(:file_path) { 'spec/support/fixtures/empty.log' }

      it 'gives the correct response' do
        expected_output = {
          'unique_page_views' => {}
        }

        expect { log_parser }.to output(generate_json(expected_output)).to_stdout
      end
    end
  end
end
