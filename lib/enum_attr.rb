module EnumAttr
  def self.included(base)
    base.instance_variable_set '@__ENUM_ATTR_MAP', {}
    base.extend ClassMethods
  end

  def enum_map 
    self.class.__enum_map
  end

  module ClassMethods
    
    def enums attr_name
      k = __enum_map[attr_name.to_sym].keys
      k.delete :__seq
      k
    end

    def __enum_map
      instance_variable_get '@__ENUM_ATTR_MAP'
    end

    def enum_val attr_name, enum_name
      __enum_map[attr_name.to_sym][enum_name.to_sym]
    end

    def enum_attr(attr_name, enum_name)

      attr_name = attr_name.to_sym
      enum_name = enum_name.to_sym

      raise Exception.new ":__seq is a reserved enum_name" if enum_name == :__seq

      if __enum_map[attr_name].nil?
        __enum_map[attr_name] = {}
        __enum_map[attr_name][:__seq] = 0

        send(:define_method, attr_name.to_s) do
          if defined? super 
            _val = super()
          else
            _val = instance_variable_get "@#{attr_name}"
          end

          self.class.__enum_map[attr_name].each do |k,v|
            if v == _val
              return k
            end
          end

          nil
        end

        send(:define_method, "#{attr_name.to_s}=") do |key|
          _val = self.class.__enum_map[attr_name][key.to_sym]
          if defined? super 
            super _val 
          else
            instance_variable_set "@#{attr_name}", _val
          end

          _val
        end
      end

      seq = __enum_map[attr_name][:__seq]
      __enum_map[attr_name][:__seq] = seq+1

      __enum_map[attr_name][enum_name] = seq

    end
  end

end