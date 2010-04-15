class PlsRequisition < ActiveRecord::Base

    def self.get_purchase_order(requisition)
      establish_connection :pls
      con = connection()
      pls_req = con.execute("select req_id, po_id from req_line
                          where req_id='#{requisition.requisition_number}'").fetch
      remove_connection

      # this connects me back to the default rails database
      establish_connection configurations[RAILS_ENV]
      return pls_req
    end

end
