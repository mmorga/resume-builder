# frozen_string_literal: true

require "data_block"
require "yaml_order"

class Twitter < DataBlock
  attr_accessor :card, :site, :creator, :domain, :description, :title, :image

  extend YamlOrder

  output_yaml_order :card, :site, :creator, :domain, :description, :title, :image
end
