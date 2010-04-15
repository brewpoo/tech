class TaskController < ApplicationController

  def menu
    @tasks = Task.find(:all)
  end

end
