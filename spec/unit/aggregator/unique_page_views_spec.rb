# frozen_string_literal: true

require 'spec_helper'

require 'log'
require 'aggregator/unique_page_views'

RSpec.describe Aggregator::UniquePageViews do
  subject(:unique_page_views) { described_class.new }

  it 'returns the correct results' do
    logs = [
      Log.new(page: '/help_page/1', ip_address: '126.318.035.038'),
      Log.new(page: '/home', ip_address: '184.123.665.067'),
      Log.new(page: '/about', ip_address: '444.701.448.104'),
      Log.new(page: '/help_page/1', ip_address: '929.398.951.889'),
      Log.new(page: '/about', ip_address: '444.701.448.104'),
      Log.new(page: '/help_page/1', ip_address: '126.318.035.038')
    ]

    expected_output = [
      PageAggregate.new(page: '/help_page/1', count: 2),
      PageAggregate.new(page: '/home', count: 1),
      PageAggregate.new(page: '/about', count: 1)
    ]

    expect(unique_page_views.call(logs)).to eq(expected_output)
  end
end
