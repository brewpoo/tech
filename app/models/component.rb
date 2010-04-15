class Component < ActiveRecord::Base

  belongs_to :parent,
    :class_name => "Component",
    :foreign_key => "parent_id"

  validates_associated :parent

end
