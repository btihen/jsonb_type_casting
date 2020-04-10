class StringSquishedType < ActiveRecord::Type::String

  def cast(value)
    value.to_s.squish
  end

end
