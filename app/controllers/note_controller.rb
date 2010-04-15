class NoteController < ApplicationController

  active_scaffold :note do |config|
    actions.exclude :create, :update, :delete, :search
    subform.columns = [:body]
  end

end
