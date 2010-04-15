class BaseReport < Ruport::Controller

  Ruport::Formatter::Template.create(:default) do |format|
    format.page = {
      :size   => "LETTER",
      :layout => :landscape
    }
    format.text = {
      :font_size => 16
    }
    format.table = {
      :font_size      => 12,
      :show_headings  => true,
      :width          => 30
    }
    format.grouping = {
      :style => :separated
    }
  end


  class Ruport::Formatter
    attr_writer :filters

    def filters_to_text(filters)
      output = ""
      filters.each do |key, value|
        output << ", " if output.length > 0 unless value.blank?
        output << "#{key.humanize} -- #{value}" unless value.blank?
      end
      return output
    end

    def format_date(date)
      date.strftime("%m/%d/%Y")
    end

  end

end

