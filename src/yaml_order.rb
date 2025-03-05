# frozen_string_literal: true

module YamlOrder
  def output_yaml_order(*attrs)
    @yaml_order = attrs
  end

  def yaml_order
    @yaml_order || instance_variables
  end
end
