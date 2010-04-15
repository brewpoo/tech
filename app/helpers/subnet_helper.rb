module SubnetHelper

  def vlan_column(record)
    if record.virtual_lan
      return link_to h(record.virtual_lan.vlanid), :controller => '/virtual_lan', :action => 'show', :id => record.virtual_lan.id
    else
      return record.vlanid
    end
  end

end
