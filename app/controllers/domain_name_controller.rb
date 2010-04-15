class DomainNameController < ApplicationController

  active_scaffold :domain_name do |config|
    columns.add :fqdn
    list.columns = [:fqdn, :domain, :domain_names]
    subform.columns = [:hostname, :domain, :publish_reverse, :domain_names];
    create.columns = update.columns = show.columns = [:hostname, :domain, :publish_reverse, :domain_names]
    columns[:domain].form_ui = :select
    columns[:publish_reverse].form_ui = :checkbox
    columns[:hostname].label = "Name"
    columns[:publish_reverse].label = "Include in Reverse DNS?"
    list.sorting = {:hostname => :asc}
    list.per_page = 50
    columns[:fqdn].sort_by :method => 'fqdn'
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :domain, {:label => "Domain", :association => [:domain]})
  end
end
