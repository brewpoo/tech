module Pc01Helper

  def submitted_by_form_column(record,input_name)
    selected = record.submitted_by ? record.submitted_by.id : nil
    "<span id='submitted-by-select'>
      #{select :record, :submitted_by, Contact.company_contacts_select(this_user.contact.employer),
              :name => input_name, :prompt => "Choose One", :selected => selected }
      #{add_contact_link('submitted-by-select','pc01/submitted_by_select') } 
      </span>"

  end

  def approved_by_form_column(record,input_name)
    selected = record.approved_by ? record.approved_by.id : nil
    "<span id='approved-by-select'>
     #{select :record, :approved_by, Contact.company_contacts_select(this_user.contact.employer),
              :name => input_name, :prompt => "Choose One", :selected => selected }
     #{add_contact_link('approved-by-select','pc01/approved_by_select') }
    </span>" 
  end

  def order_title(count)
    case count
      when 0
        'No Orders Created'
      when 1
        'One Order Created'
      when 1...99
        'Multiple Orders Created'
    end
  end
    
end

