# frozen_string_literal: true

require 'processor/factory'

RSpec.describe Processor::Factory do
  subject(:processor) { described_class.for(type) }

  describe 'for page_views type' do
    let(:type) { 'page_views' }

    it 'returns an instance of the PageViews class' do
      expect(processor).to be_an_instance_of(Processor::PageViews)
    end
  end

  describe 'for unique_page_views type' do
    let(:type) { 'unique_page_views' }

    it 'returns an instance of the UniquePageViews class' do
      expect(processor).to be_an_instance_of(Processor::UniquePageViews)
    end
  end

  describe 'for unknown type' do
    let(:type) { 'foobar' }

    it 'throws a KeyError' do
      expect { processor }.to raise_error(KeyError)
    end
  end
end
