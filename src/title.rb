# frozen_string_literal: true

require "data_block"
require "yaml_order"

class Title < DataBlock
  attr_accessor :name
  attr_reader :address

  extend YamlOrder

  output_yaml_order :name, :address

  def address=(addr)
    @address = default_array(addr)
  end
end
