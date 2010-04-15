module ContactHelper

  def manager_form_column(record,input_name)
#    text_field :record, :manager_name, :name => input_name, :disabled => true
  end

#  def employer_form_column(record,input_name)
#    select :record, :employer, Company.map_select, { :name => input_name, :prompt => 'Choose employer'},
#      { :onchange => "new Ajax.Request('/contact/employer_changed/' + this[this.selectedIndex].value,
#    { asynchronous:true, evalScripts:true});", :class => 'employer'} 
#  end

#  def department_form_column(record,input_name)
#    here = select :record, :department, Department.find(:all, :order=>'name',:conditions=>['company_id=?',record.employer_id]).map {|m| [m.name, m.id]}, { :name => input_name, :prompt => 'Choose department' }
#    return "<span id='department-select'>" + here + "</span>"
#  end

end
