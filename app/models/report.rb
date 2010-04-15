class Report < ActiveRecord::Base

  def build_filters
    # Builds filters from string of format
    # name[label],order_by  
    this_model = model.classify.constantize
    output = []
    filters.each do |filter|
      # Separate the field from the ordering
      field1,field2 = filter.split(",") if filter.include? ","
      field1 = filter if field1.nil?
      # Check for a label override
      if field1 =~ /(\w+)\[(\w+)\]/
        this_field = $1.chomp.to_sym
        label = $2.chomp.to_sym
      else
        this_field = field1.chomp.to_sym
        label = "to_label"
      end
      order_by = field2.chomp if field2

      association = this_model.reflect_on_all_associations(:belongs_to).select { |field| field.name == this_field }
      if !association.empty?
        # Build options
        output << { :name => association.first.primary_key_name, :type => 'select', :class => association.first.class_name,
                    :order => order_by, :label => label, :conditions => association.first.options[:conditions] }
      else
        output << { :name => filter.chomp, :type => 'text' }
      end
    end
    return output
  end


end
