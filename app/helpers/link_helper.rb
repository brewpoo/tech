module LinkHelper

  def link_category_form_column(record,input_name)
    selected = record.link_category ? record.link_category.id : nil
    select :record, :link_category, tree_select_map(LinkCategory.find(:all,:conditions=>'parent_id is null',:order=>'name'),0),
        :name => input_name, :selected => selected
  end

end
