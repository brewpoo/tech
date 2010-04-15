class DomainName < ActiveRecord::Base

  belongs_to :nameable, :polymorphic => true
  belongs_to :domain
  has_many :domain_names, :as => :nameable, :dependent => :destroy

  validates_presence_of :domain

  validates_presence_of :hostname
  validates_format_of :hostname, :with => /\A([a-z]|[A-Z]|[0-9]|\-|_)+\z/i
  validates_uniqueness_of :hostname, :scope => 'domain_id'

  def to_label
    fqdn
  end

  def fqdn
    "#{name}.#{domain.fqdn}"
  end

  def name
    hostname.downcase.gsub(/_/,"-")
  end

  def forward_entry
    # alias CNAM
    return "#{name}\tIN CNAME\t#{nameable.fqdn}.\n"
  end

  def reverse_entry
    return nil
  end

end
