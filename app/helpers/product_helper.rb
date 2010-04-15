module ProductHelper

  def description_column(record)
    return unless record.description
    return record.description if record.description.length < 50
    "#{record.description.first(40)}..."
  end

end
