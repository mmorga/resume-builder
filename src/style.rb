# frozen_string_literal: true

require "partial"

class Style < Partial
  def initialize(resume)
    super("style/resume.css.erb", resume)
  end
end
