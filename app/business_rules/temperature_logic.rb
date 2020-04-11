# https://ruby-doc.org/stdlib-2.2.1/libdoc/delegate/rdoc/Delegator.html
# Use Decorator Pattern to add Logical Rules to a ValueObject
class TemperatureLogic < Delegator
  def initialize(objekt)
    super                   # pass obj to Delegator constructor, required
    @temperature = objekt   # store obj for future use
  end

  def __getobj__
    @temperature # return object we are delegating to, required
  end

  def __setobj__(objekt)
    @temperature = objekt # change delegation object,
                          # a feature we're providing
  end

  def initialize(temperature)
    @temperature = temperature
  end

  # logical rules
  def hot?
    self >= HOT_THRESHOLD
  end

  def cool?
    self <= COOL_THRESHOLD
  end

  def cold?
    self <= COLD_THRESHOLD
  end

  protected
  HOT_THRESHOLD  = new(25)
  COOL_THRESHOLD = new(15)
  COLD_THRESHOLD = new(5)

end
