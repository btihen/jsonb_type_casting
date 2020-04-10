class ValueObject
  include Comparable
  attr_reader :value, :unit

  # if string, array or hash -- should be .frozen
  def initialize(attribs)
    @value = case attribs
            when Hash
              attribute = attribs.with_indifferent_access
              attribute[:value]
            else
              attribs
            end
    @unit = case attribs
            when Hash
              attribute = attribs.with_indifferent_access
              attribute[:unit]
            else
              nil
            end
  end

  def attributes
    {"value" => value, "unit" => unit}
  end

  # override as needed
  def to_s
    return "#{value}" if unit.blank?

    "#{value} #{unit}"
  end

  # required by comparable
  def <=>(other)
    value <=> other.value
  end

  protected
  alias eql? ==
  # Hashing implementation (overrides the object_id comparison by comparable)
  # the value must remain constant during the life span of the process
  def hash
    value.hash
  end

end
