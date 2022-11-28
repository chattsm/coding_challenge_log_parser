# frozen_string_literal: true

require 'presenter/for'

RSpec.describe Presenter::For do
  subject(:presenter) { described_class.call(type) }

  describe 'for page_views type' do
    let(:type) { 'page_views' }

    it 'returns an instance of the PageViews class' do
      expect(presenter).to be_an_instance_of(Presenter::PageViews)
    end
  end

  describe 'for unique_page_views type' do
    let(:type) { 'unique_page_views' }

    it 'returns an instance of the UniquePageViews class' do
      expect(presenter).to be_an_instance_of(Presenter::UniquePageViews)
    end
  end

  describe 'for unknown type' do
    let(:type) { 'foobar' }

    it 'throws a KeyError' do
      expect { presenter }.to raise_error(KeyError)
    end
  end
end
