# frozen_string_literal: true

require 'json'

require 'presenter/page_views'

RSpec.describe Presenter::PageViews do
  subject(:page_views) { described_class.new }

  it 'prints a JSON formatted string' do
    input = [
      OpenStruct.new(page: '/help_page/1', count: 3),
      OpenStruct.new(page: '/home', count: 1),
      OpenStruct.new(page: '/about', count: 2)
    ]

    expected_output = {
      'page_views' => {
        '/help_page/1' => 3,
        '/about' => 2,
        '/home' => 1
      }
    }

    expect do
      page_views.call(input)
    end.to output(generate_json(expected_output)).to_stdout
  end
end
