class AttrAccessorObject
  def self.my_attr_accessor(*names)

    names.each do |name|
      define_method("#{name}") do
        self.instance_variable_get("@attributes")[name]
      end
      define_method("#{name}=") do |val|
        attrib = self.instance_variable_get("@attributes")
        attrib[name] = val
        self.instance_variable_set("@attributes", attrib)
      end
    end

    define_method("attributes") do
      self.instance_variable_get("@attributes")
    end
  end
end
