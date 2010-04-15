module DollarConversions

  def to_currency(options={})
    options = options.stringify_keys
    precision = options.delete('precision') { 2 }
    unit = options.delete('unit') { '$' }
    fractional_unit = options.delete('fractional_unit') { '&cent;' }
    separator = options.delete('separator') { '.' }
    delimiter = options.delete('delimiter') { ',' }
    separator = '' unless precision > 0
    begin
        fraction = self.abs % 1.0
        body = self.floor
        if body != 0 || body == 0 && fraction == 0 then
            parts = with_precision(self, precision).split('.')
            unit + with_delimiter(parts[0], delimiter) + separator + parts[1].to_s
        else
            (fraction * 100).to_i.to_s + fractional_unit
        end
    rescue
        self
    end

  end

  def with_delimiter(number, delimiter=",", separator=".")
    begin
      parts = number.to_s.split('.')
      parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
      parts.join separator
    rescue
      number
    end
  end

  def with_precision(number, precision=3)
    begin
      "%01.#{precision}f" % number
    rescue
      number
    end
  end

end

class Float
  include DollarConversions
end

class BigDecimal
  include DollarConversions
end

class Fixnum
  include DollarConversions
end

class Bignum
  include DollarConversions
end

