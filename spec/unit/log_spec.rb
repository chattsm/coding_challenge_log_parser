# frozen_string_literal: true

require 'spec_helper'

require 'log'

RSpec.describe Log do
  subject(:log) do
    described_class.new(page: '/help_page/1', ip_address: '126.318.035.038')
  end

  describe '#page' do
    it 'returns the correct value' do
      expect(log.page).to eq('/help_page/1')
    end
  end

  describe '#ip_address' do
    it 'returns the correct value' do
      expect(log.ip_address).to eq('126.318.035.038')
    end
  end

  describe '#==' do
    context 'when #page and #ip_address are the same' do
      it 'returns true' do
        log_compare = described_class.new(
          page: '/help_page/1',
          ip_address: '126.318.035.038'
        )

        expect(log).to eq(log_compare)
      end
    end

    context 'when #page and #ip_address are not the same' do
      it 'returns true' do
        log_compare = described_class.new(
          page: '/foo/bar',
          ip_address: '035.126.318.038'
        )

        expect(log).not_to eq(log_compare)
      end
    end
  end
end
