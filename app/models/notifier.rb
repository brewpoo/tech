class Notifier < ActionMailer::Base
    include ActionController::UrlWriter
    default_url_options[:host] = 'nots.lirr.org'

  def order_created(recipient,order)
    recipients recipient.email
    from "nots@lirr.org"
    subject "An order has been created"
    content_type 'text/html'
    body :contact => recipient, :order => order
  end

  def outstanding_approvals(recipient,orders)
    recipients recipient.email
    from "nots@lirr.org"
    subject "Outstanding orders for approval"
    content_type 'text/html'
    body :contact => recipient, :orders => orders
  end

  def order_approved(recipient,order)
    recipients recipient.email
    from "nots@lirr.org"
    subject "An order has been approved"
    content_type 'text/html'
    body :contact => recipient, :order => order
  end

  def order_notify(recipient,order)
    recipients recipient.email
    from "nots@lirr.org"
    subject "An order has been approved"
    content_type 'text/html'
    body :contact => recipient, :order => order
  end

  def notify_received(recipient,items)
    recipients recipient.email
    from "nots@lirr.org"
    subject "Order items have arrived"
    content_type 'text/html'
    body :contact => recipient, :items => items
  end

  def notify_distributed(recipient,contact,items)
    recipients recipient.email
    from "nots@lirr.org"
    subject "Order items have been picked up"
    content_type 'text/html'
    body :recipient => recipient, :contact => contact, :items => items
  end

  def request_bid(purchase_contact,requisition)
    recipients purchase_contact.email
    from "porfnots@lirr.org"
#    from requisition.processor.email
#    cc requisition.processor.email
    subject "Request for Bid"
    content_type 'text/html'
    body :requisition => requisition, :purchase_contact => purchase_contact
  end
  
  def request_bid_sent(recipient, requisition, purchase_contacts)
    recipients recipient.email
    from "nots@lirr.org"
    subject "Request for Bid has been sent"
    content_type 'text/html'
    body :requisition => requisition, :purchase_contacts => purchase_contacts
  end

  def bad_reqs(contact, missing_reqs, mismatched_reqs, updated_reqs)
    recipients contact.email
    from "nots@lirr.org"
    subject "Incorrect/Missing Reqs Report"
    content_type 'text/html'
    body :contact => contact, :missing_reqs => missing_reqs, :mismatched_reqs => mismatched_reqs, :updated_reqs => updated_reqs
  end

  def send_message(recipients,message)
    recipients recipients
    from "nots@lirr.org"
    subject "Message from NOTS"
    content_type 'text/html'
    body :message => message
  end

end
