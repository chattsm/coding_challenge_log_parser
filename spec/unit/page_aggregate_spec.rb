# frozen_string_literal: true

require 'spec_helper'

require 'page_aggregate'

RSpec.describe PageAggregate do
  subject(:page_aggregate) do
    described_class.new(page: '/help_page/1', count: 3)
  end

  describe '#page' do
    it 'returns the correct value' do
      expect(page_aggregate.page).to eq('/help_page/1')
    end
  end

  describe '#count' do
    it 'returns the correct value' do
      expect(page_aggregate.count).to eq(3)
    end
  end

  describe '#==' do
    context 'when #page and #count are the same' do
      it 'returns true' do
        page_aggregate_compare = described_class.new(
          page: '/help_page/1',
          count: 3
        )

        expect(page_aggregate).to eq(page_aggregate_compare)
      end
    end

    context 'when #page and #ip_address are not the same' do
      it 'returns true' do
        page_aggregate_compare = described_class.new(
          page: '/foo/bar',
          count: 2
        )

        expect(page_aggregate).not_to eq(page_aggregate_compare)
      end
    end
  end
end
