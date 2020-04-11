class FormObjectBase

  # ActiveModel provides validations & form_for tools
  include ActiveModel::Model
  include ActiveModel::Dirty
  include ActiveModel::Attributes
  # include ActiveSupport::Callbacks  # discouraged using callbacks!

  def persisted?
    false
  end

  # attr_reader :root_model

  # def initialize(root_model)
  #   @root_model   = root_model
  # end

end
