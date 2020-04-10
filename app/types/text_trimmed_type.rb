class TextTrimmedType < ActiveRecord::Type::String

  def cast(value)
    value.to_s.strip
  end

end
