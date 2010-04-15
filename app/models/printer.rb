class Printer < Device

  before_save :set_device_type

  has_many :print_daemons

  def location
    self.equipment.location.long_name if self.equipment and self.equipment.location
  end

  def set_device_type
    self.device_class = DeviceClass.find_by_name("Printer")
  end

end
