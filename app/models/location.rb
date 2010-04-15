class Location < ActiveRecord::Base
#  before_save :geocode_address

  include TreeFunctions

  acts_as_tree 
  acts_as_reportable
  
  before_validation :set_depth
  before_validation :set_long_name
  after_update :update_children

  belongs_to :contact

  has_one :address
  has_many :equipment
  has_many :contacts
  has_many :pc01s
  has_and_belongs_to_many :circuits

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => "parent_id"
  validates_uniqueness_of :long_name

  validates_numericality_of :depth
  validates_numericality_of :latitude, :allow_nil => :true
  validates_numericality_of :longitude, :allow_nil => :true

  def set_depth
    here=self
    mydepth=0
    while here.parent
      mydepth+=1
      here=here.parent
    end
    self.depth=mydepth
  end

  def used_count
    return equipment_count+contacts_count+circuits_count+pc01s_count
  end

  def set_long_name
  # Set the long name here
  # instead of dynamically
  # greatly improves performance
    self.long_name=full_name(" ")
  end

  def update_children
    children.each do |child|
      child.update_attribute :long_name, full_name(" ")
      child.update_children if child.children
    end
  end

  def Location.fix_long_names
    max=Location.maximum(:depth)
    (1..max).each do |current_depth| 
      Location.find(:all, :conditions => ['depth=?',current_depth]).each do |location|
        location.update_attribute :long_name, location.full_name(" ")
      end
    end
  end

  def to_label
    long_name
  end

  def find_address
    here=self
    return here.address if here.address
    while here.parent
      here=here.parent
      return here.address if here.address
    end
    return "No address"
  end

  def geocode_address
    if address
      loc = $geo.locate address.to_label
      loc = loc.first
      latitude = loc.latitude
      longitude = loc.longitude
      save
    end
  end

  def Location.find_buildings
    Location.find(:all,:conditions=>"depth=1")
  end

  def Location.find_typical_locations
    Location.find(:all,:conditions=>"depth=2")
  end

  def Location.find_storage_locations
    Location.find(:all,:conditions=>"is_storage_location=1")
  end

  def Location.typical_location_select
    Location.find_typical_locations.map { |l| [l.long_name, l.id] }
  end

  def Location.find_delivery_locations
    Location.find(:all,:conditions=>"is_delivery_location=true")
  end

  def Location.delivery_location_select
    Location.find_delivery_locations.map { |l| ["#{l.long_name} (#{l.find_address.to_label})", l.id] }
  end

  # Cached Calls
  #
  def Location.used_locations
    Location.find(:all).select{|loc| loc.used?}.sort_by{|l|l.long_name}.map{|l| ["#{l.long_name}", l.id]}
  end

  def used?
    return equipment || contacts || circuits || pc01s
  end
  
  def Location.used_select
    used_locations = CACHE.get("used_locations")
    if used_locations == nil
      Location.run_precache
      used_locations = CACHE.get("used_locations")
    end
    return used_locations
  rescue
    return Location.used_locations
  end

  def Location.all_locations
    Location.find(:all).sort_by{|l|l.long_name}.map{|l| ["#{l.long_name} #{"***" if l.is_storage_location}", l.id]}
  end

  def Location.select_map
    all_locations = CACHE.get("all_locations")
    if all_locations == nil
      Location.run_precache
      all_locations = CACHE.get("all_locations")
    end
    return all_locations
  rescue
    return Location.all_locations
  end

  def Location.storage_locations
      Location.find(:all).select {|loc| loc.is_storage_location?}.map{|l| [l.long_name, l.id]}
  end

  def Location.storage_location_select
    storage_locations = CACHE.get("storage_locations")
    if storage_locations == nil
      Location.run_precache
      storage_locations = CACHE.get("storage_locations")
    end
    return storage_locations
  rescue
    return Location.storage_locations
  end

  def self.run_precache
    CACHE.set("used_locations",Location.used_locations)
    CACHE.set("all_locations",Location.all_locations)
    CACHE.set("storage_locations",Location.storage_locations)
  end

end
