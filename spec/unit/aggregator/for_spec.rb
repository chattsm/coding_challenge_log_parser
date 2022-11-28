# frozen_string_literal: true

require 'aggregator/for'

RSpec.describe Aggregator::For do
  subject(:aggregator) { described_class.call(type) }

  describe 'for page_views type' do
    let(:type) { 'page_views' }

    it 'returns an instance of the PageViews class' do
      expect(aggregator).to be_an_instance_of(Aggregator::PageViews)
    end
  end

  describe 'for unique_page_views type' do
    let(:type) { 'unique_page_views' }

    it 'returns an instance of the UniquePageViews class' do
      expect(aggregator).to be_an_instance_of(Aggregator::UniquePageViews)
    end
  end

  describe 'for unknown type' do
    let(:type) { 'foobar' }

    it 'throws a KeyError' do
      expect { aggregator }.to raise_error(KeyError)
    end
  end
end
