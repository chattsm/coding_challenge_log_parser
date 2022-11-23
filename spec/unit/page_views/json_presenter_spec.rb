# frozen_string_literal: true

require 'json'

require 'page_views/json_presenter'

RSpec.describe PageViews::JSONPresenter do
  it 'prints a JSON formatted string' do
    input = {
      '/help_page/1' => 3,
      '/about' => 2,
      '/home' => 1
    }

    expected_output = JSON.generate({
      'page_views' => {
        '/help_page/1' => 3,
        '/about' => 2,
        '/home' => 1
      }
    })

    expect { subject.call(input) }.to output(expected_output).to_stdout
  end
end
