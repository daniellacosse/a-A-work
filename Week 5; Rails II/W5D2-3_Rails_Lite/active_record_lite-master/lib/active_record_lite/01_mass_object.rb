# deprecated for Rails 4
require_relative '00_attr_accessor_object.rb'

class MassObject < AttrAccessorObject
  def self.attributes
    @attributes ||= {}
  end

  def initialize(params)

    _columns = self.class.columns
    @attributes = params.dup

    params.each do |attr_name, value|
      attr_sym = attr_name.to_sym
      raise "unknown attribute #{attr_name}" unless _columns.include?(attr_sym)
      self.send("#{attr_name}=", value)
    end

    @attributes.delete_if{|key, _| key.is_a?(String)}

  end
end
