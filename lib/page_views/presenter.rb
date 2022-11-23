# frozen_string_literal: true

require 'json'

module PageViews
    class Presenter
      def call
        output = {
          'page_views' => {
            '/help_page/1' => 3,
            '/about' => 2,
            '/home' => 1
          }
        }

        print JSON.generate(output)
      end
    end
  end