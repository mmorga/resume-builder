# frozen_string_literal: true

require "data_block"
require "yaml_order"

class Skills < DataBlock
  attr_reader :title, :content

  extend YamlOrder

  output_yaml_order :title, :content

  def title=(str)
    @title = default_string(str, "Skills")
  end

  def content=(con)
    @content = default_hash_or_array(con)
  end
end
