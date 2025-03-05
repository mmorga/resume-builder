# frozen_string_literal: true

require "data_block"
require "yaml_order"

class Degree < DataBlock
  attr_accessor :degree, :field, :year, :school, :location

  extend YamlOrder

  output_yaml_order :degree, :field, :year, :school, :location
end
