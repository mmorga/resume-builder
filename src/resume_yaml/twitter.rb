# frozen_string_literal: true

module ResumeYaml
  class Twitter
    include YamlMapping

    yaml_attr :card
    yaml_attr :site
    yaml_attr :creator
    yaml_attr :domain
    yaml_attr :description
    yaml_attr :title
    yaml_attr :image
  end
end
