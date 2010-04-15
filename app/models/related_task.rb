class RelatedTask < ActiveRecord::Base
  belongs_to :task
  belongs_to :related_task,
    :class_name => 'Task',
    :foreign_key => 'related_task_id'

  def to_label
    related_task.full_name
  end

end
