# frozen_string_literal: true

require 'json'

require 'presenter/unique_page_views'

RSpec.describe Presenter::UniquePageViews do
  it 'prints a JSON formatted string' do
    input = [
      OpenStruct.new(page: '/help_page/1', count: 3),
      OpenStruct.new(page: '/home', count: 1),
      OpenStruct.new(page: '/about', count: 2)
    ]

    expected_output = JSON.generate({
      'unique_page_views' => {
        '/help_page/1' => 3,
        '/about' => 2,
        '/home' => 1
      }
    })

    expect { subject.call(input) }.to output(expected_output).to_stdout
  end
end
