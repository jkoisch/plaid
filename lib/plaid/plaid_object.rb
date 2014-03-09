class PlaidObject

  def initialize(hash)
    hash.keys.each do |key|
      self.class.send(:define_method, "#{key}") do
        instance_variable_get("@#{key}")
      end

      if hash[key].is_a? Array
        arr = []
        hash[key].each do |chunk|
          if chunk.is_a? Hash
            arr <<  PlaidObject.new(chunk)
          else
            arr << chunk
          end
        end
        instance_variable_set("@#{key}", arr)
      else
        if hash[key].is_a? Hash
          h = hash[key]
          instance_variable_set("@#{key}", h)
        else
          eval("@#{key} = '#{encode(hash[key].to_s)}'")
        end
      end
    end

  end

  def encode(str)
    str.gsub("'", "")
  end

end