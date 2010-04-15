class CreateRequisitionStatuses < ActiveRecord::Migration
  def self.up
      create_table :requisition_statuses do |t|
        t.column :name, :string
        t.column :value, :integer
      end
      RequisitionStatus.create(:name => 'Initial', :value => Requisition::INITIAL)
      RequisitionStatus.create(:name => 'Created', :value => Requisition::CREATED)
      RequisitionStatus.create(:name => 'Bidding', :value => Requisition::BIDDING)
      RequisitionStatus.create(:name => 'Awarded', :value => Requisition::AWARDED)
      RequisitionStatus.create(:name => 'Purchased', :value => Requisition::PURCHASED)
      RequisitionStatus.create(:name => 'Shipping', :value => Requisition::SHIPPING)
      RequisitionStatus.create(:name => 'Closed', :value => Requisition::CLOSED)
      rename_column :requisitions, :requisition_status, :requisition_status_old
      add_column :requisitions, :requisition_status_id, :integer
      Requisition.reset_column_information
      Requisition.find_all.each do |req|
        req.update_attribute :requisition_status, RequisitionStatus.find_by_value(req.requisition_status_old)
      end
  end

  def self.down
    drop_table :requisition_statuses
    rename_column :requisitions, :requisition_status_old, :requisition_status
    remove_column :requisitions, :requisition_status_id
  end
end

