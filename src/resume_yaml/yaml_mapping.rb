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
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def yaml_order
      self.class.yaml_order
    end

    def instance_variables_blank?
      instance_variables.all? do |i|
        val = instance_variable_get(i)
        val.nil? || (val.respond_to?(:empty?) && val.empty?)
      end
    end

    def to_yaml_ast
      mapping = Psych::Nodes::Mapping.new
      yaml_order.each do |sym|
        mapping.children << Psych::Nodes::Scalar.new(sym.to_s)
        mapping.children << send(sym).to_yaml_ast
      end
      mapping
    end
  end
end
