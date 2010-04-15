class MpPvcController < ApplicationController

  active_scaffold :mp_pvc do |config|
    list.label = "Multi-Point Line Mappings"
    list.per_page = 50
    #columns[:dlci_a].form_ui = :select
    #columns[:dlci_b].form_ui = :select
    columns[:dlci_a].association.reverse = :mp_b_pvc
    columns[:dlci_b].association.reverse = :mp_a_pvc
    nested.add_link('DLCI A',[:dlci_a])
    nested.add_link('DLCI B',[:dlci_b])
  end

end
