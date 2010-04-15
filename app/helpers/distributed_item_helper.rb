module DistributedItemHelper

  def order_item_column(record)
    "#{record.order_item.item_details} (#{record.order_item.order.to_label})" 
  end

end
