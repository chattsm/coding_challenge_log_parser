# frozen_string_literal: true

class LogParser
  def initialize(source:, processor:, presenter:)
    @source = source
    @processor = processor
    @presenter = presenter
  end

  def call
    presenter.call(processor.call(source.call))
  end

  private

  attr_reader :source, :processor, :presenter
end
