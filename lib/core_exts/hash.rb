require 'ostruct'

class Hash
  def to_ostruct
    OpenStruct.new(self.each_with_object({}) do |(key, val), memo|
      memo[key] = val.is_a?(Hash) ? val.to_ostruct : val
    end)
  end
  
end