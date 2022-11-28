# frozen_string_literal: true

require 'json'

require 'processor/page_views'

RSpec.describe Processor::PageViews do
  subject(:results) { described_class.new }

  it 'returns the correct results' do
    logs = [
      OpenStruct.new(page: '/help_page/1', ip_address: '126.318.035.038'),
      OpenStruct.new(page: '/home', ip_address: '184.123.665.067'),
      OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
      OpenStruct.new(page: '/help_page/1', ip_address: '929.398.951.889'),
      OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
      OpenStruct.new(page: '/help_page/1', ip_address: '722.247.931.582')
    ]

    expected_output = [
      OpenStruct.new(page: '/help_page/1', count: 3),
      OpenStruct.new(page: '/home', count: 1),
      OpenStruct.new(page: '/about', count: 2)
    ]

    expect(results.call(logs)).to eq(expected_output)
  end
end
