# frozen_string_literal: true

require 'json'

require 'page_views/processor'

RSpec.describe PageViews::Processor do
  subject(:results) { described_class.new.call(logs) }

  let(:logs) do
    [
      OpenStruct.new(page: '/help_page/1', ip_address: '126.318.035.038'),
      OpenStruct.new(page: '/home', ip_address: '184.123.665.067'),
      OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
      OpenStruct.new(page: '/help_page/1', ip_address: '929.398.951.889'),
      OpenStruct.new(page: '/about', ip_address: '444.701.448.104'),
      OpenStruct.new(page: '/help_page/1', ip_address: '722.247.931.582')
    ]
  end

  it 'returns the correct results' do
    expect(results).to eq([
      OpenStruct.new(page: '/help_page/1', count: 3),
      OpenStruct.new(page: '/home', count: 1),
      OpenStruct.new(page: '/about', count: 2)
    ])
  end
end
