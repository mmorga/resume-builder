# frozen_string_literal: true

module ResumeYaml
  module YamlMapping
    module ClassMethods
      def from_hash(hash)
        hash ||= {}
        db = new

        db.public_methods(false)
          .select { |sym| sym.to_s.end_with?("=") }
          .each { |sym| db.send(sym, hash[sym.to_s[..-2]]) }

        warn_of_invalid_hash_keys(hash, db)

        db
      end

      def warn_of_invalid_hash_keys(hash, inst)
        ext = hash.keys - inst.instance_variables.map { |i| i.to_s[1..] }
        warn "#{inst.class.name} YAML instance had unexpected keys: #{ext}" unless ext.empty?
      end

      def yaml_attr(sym, &block)
        @yaml_order ||= []
        @yaml_order.push(sym)

        class_eval { attr_reader sym }
        if block_given?
          define_method("#{sym}=") do |arg|
            instance_variable_set(:"@#{sym}", block.call(arg))
          end
        else
          class_eval { attr_writer sym }
        end
      end

      def yaml_order
        return @yaml_order if instance_variable_defined?(:@yaml_order)

        []
      end

      def default_array(ary, cls = nil)
        array = blank?(ary) ? [] : Array(ary)
        return array unless cls

        array.map { |cp| cls.from_hash(cp) }
      end

      def blank?(str)
        str.nil? || str.empty?
      end

      def default_string(str, default)
        blank?(str) ? default : str
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def yaml_ast_of_array(obj)
      seq = Psych::Nodes::Sequence.new
      obj.each do |o|
        seq.children << yaml_ast_of(o)
      end
      seq
    end

    def yaml_ast_of_hash(obj)
      mapping = Psych::Nodes::Mapping.new
      obj.each do |k, v|
        mapping.children << yaml_ast_of(k)
        mapping.children << yaml_ast_of(v)
      end
      mapping
    end

    # rubocop:disable Metrics/MethodLength
    def yaml_ast_of(obj)
      case obj
      when Integer
        Psych::Nodes::Scalar.new(obj.to_s)
      when String, NilClass
        Psych::Nodes::Scalar.new(obj || "")
      when YamlMapping
        obj.to_yaml_ast
      when Array
        yaml_ast_of_array(obj)
      when Hash
        yaml_ast_of_hash(obj)
      else
        raise "Need to handle #{obj.class}\n#{obj.inspect}\n"
      end
    end
    # rubocop:enable Metrics/MethodLength

    def yaml_order
      self.class.yaml_order
    end

    def instance_variables_nil?
      instance_variables.all? { |i| instance_variable_get(i).nil? }
    end

    def instance_variables_blank?
      instance_variables.all? do |i|
        val = instance_variable_get(i)
        val.nil? || val.empty?
      end
    end

    def to_yaml_ast
      mapping = Psych::Nodes::Mapping.new
      yaml_order.each do |sym|
        mapping.children << Psych::Nodes::Scalar.new(sym.to_s)
        mapping.children << yaml_ast_of(send(sym))
      end
      mapping
    end
  end
end
