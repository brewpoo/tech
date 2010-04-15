module MpDlciHelper

  def interface_column(record)
    record.interface.device_label if record.interface
  end

end
