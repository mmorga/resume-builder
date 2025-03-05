# frozen_string_literal: true

module ResumeYaml
  class Twitter
    include YamlMapping

    attr_accessor :card, :site, :creator, :domain, :description, :title, :image

    output_yaml_order :card, :site, :creator, :domain, :description, :title, :image
  end
end
