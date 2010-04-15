module ProjectTrackerHelper

  def Kproject_status_column(record)
    @record = record # active_scaffold_input_select needs @record
    column = active_scaffold_config.columns[:project_status]
    id_options = {:id => record.id.to_s, :action => 'update_column', :name => column.name} # update_column will replace html for this element
    script = remote_function(:method => 'POST', :url => {:controller => params_for[:controller], :action => "update_column", 
      :id => record.id.to_s, :eid => params[:eid]}, :with => "'column=#{column.name}&value='+this.value")
    content_tag :span, (record.project_status.name || 'select one') + active_scaffold_input_select(column, 
      active_scaffold_input_options(column).merge({:onchange => script})), :id => element_cell_id(id_options)
  end
end
