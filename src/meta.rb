# frozen_string_literal: true

require "data_block"
require "twitter"
require "yaml_order"

class Meta < DataBlock
  attr_accessor :description, :keywords, :author, :copyright, :license,
                :canonical_link, :pdf_link, :created
  attr_reader :twitter

  extend YamlOrder

  output_yaml_order :description, :keywords, :author, :copyright, :license, :canonical_link, :pdf_link, :twitter

  def twitter=(obj)
    @twitter = Twitter.from_hash(obj)
  end
end
