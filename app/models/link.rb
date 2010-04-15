class Link < ActiveRecord::Base

  belongs_to :linkable, :polymorphic => true
  belongs_to :link_category

  validates_presence_of :url

  def to_label
    return title if linkable.methods.include? 'description' and !linkable.description.nil?
    return linkable.description
  end

end
