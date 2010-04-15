class AddSoaToDomain < ActiveRecord::Migration
  def self.up
    add_column :domains, :generate_soa, :boolean
    add_column :domains, :soa_timer_section, :string
  end

  def self.down
  end
end
