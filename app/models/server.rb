class Server < Device

  acts_as_reportable

  before_create :set_device_type

  belongs_to :primary_engineer, :class_name => "Contact",
    :foreign_key => "primary_engineer_id"
  belongs_to :operating_system

  has_and_belongs_to_many :domains
  has_many :application_servers

  def set_device_type
    self.device_class = DeviceClass.find_by_name("Server")
  end

end
