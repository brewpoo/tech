module InventoryHelper

  def add_manufacturer_link
    link_to_function image_tag('add.gif'), "new Ajax.Request('/inventory/new_manufacturer');"
  end

  def add_product_family_link
    link_to_function image_tag('add.gif'), "new Ajax.Request('/inventory/new_product_family?manufacturer='+$('active-inventory-item').down('.manufacturer')[$('active-inventory-item').down('.manufacturer').selectedIndex].value);"
  end

  def add_product_link
    link_to_function image_tag('add.gif'), "new Ajax.Request('/inventory/new_product?product_family='+$('active-inventory-item').down('.product-family')[$('active-inventory-item').down('.product-family').selectedIndex].value);"
  end

  def add_item_link(name)
    button_to_function "Add Item", "new Ajax.Request('/inventory/add_inventory_item?product='+$('active-inventory-item').down('.product')[$('active-inventory-item').down('.product').selectedIndex].value+'&count='+$('active-inventory-item').down('.count').value);"

  end

end
