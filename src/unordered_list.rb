# frozen_string_literal: true

require "partial"

class UnorderedList < Partial
  attr_reader :ary

  def initialize(resume, ary)
    super("erb/unordered-list.html.erb", resume)
    @ary = ary
  end
end
