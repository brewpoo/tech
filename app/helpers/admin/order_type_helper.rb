module Admin::OrderTypeHelper

  def processor_form_column(record,input_name)
    select :record, :processor, User.purchase_processor_select, :name => input_name, :prompt => 'Choose processor'
  end

end
