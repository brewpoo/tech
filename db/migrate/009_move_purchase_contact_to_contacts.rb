class MovePurchaseContactToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :is_purchase_contact, :boolean
    Contact.reset_column_information
    Company.find(:all, :conditions => 'purchase_contact_id is not null').each do |company|
      company.purchase_contact.update_attribute(:is_purchase_contact,true)
    end
    remove_column :companies, :purchase_contact_id
  end

  def self.down
    add_column :companies, :purchase_contact_id
    Company.reset_column_information
    Contact.find(:all, :conditions => 'is_purchase_contact=1').each do |contact|
      contact.company.purchase_contact=contact
      contact.company.save
    end
    remove_column :contacts, :is_purchase_contact
  end
end
