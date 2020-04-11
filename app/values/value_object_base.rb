# https://makandracards.com/alexander-m/43081-value-object
class ValueObjectBase
  include Comparable

  # if string, array or hash -- should be .frozen
  def initialize(attribs)
    raise NotImplemented
  end

  def to_s
    raise NotImplemented
  end

  def attributes
    raise NotImplemented
  end

  # convert attributes into an array of values
  def values_list
    attributes.values
  end

  # required by comparable
  def <=>(other)
    values_list <=> other.values_list
  end

  protected
  alias eql? ==
  # Hashing implementation (overrides the object_id comparison by comparable)
  # the value must remain constant during the life span of the process
  def hash
    values_list.hash
  end
end
