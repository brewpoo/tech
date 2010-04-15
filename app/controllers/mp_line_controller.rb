class MpLineController < ApplicationController

  active_scaffold :mp_line do |config|
    list.label = "Multi-Point Lines"
    list.per_page = 50
    columns[:device].form_ui = :select
    columns[:circuit].form_ui = :select
    columns[:circuit].association.reverse = :mp_line
    nested.add_link('Circuit',[:circuit])
  end

end
