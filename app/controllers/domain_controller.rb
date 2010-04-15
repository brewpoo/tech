class DomainController < ApplicationController

  active_scaffold :domain do |config|
    columns.add :fqdn
    create.columns = update.columns = [:parent, :name, :description, :maintainer, :autodns, :generate_soa, :servers, :primary_server]
    list.columns = [:parent, :name, :fqdn, :description, :maintainer, :autodns, :servers]
    columns[:parent].form_ui=:select
    columns[:maintainer].form_ui=:select
    columns[:primary_server].form_ui=:select
    columns[:autodns].form_ui = :checkbox
    columns[:generate_soa].form_ui = :checkbox
    action_links.add('deploy', :label => 'Deploy AutoDNS', :type => :table,
                     :crud_type => :create, :inline => false)
  end

  def deploy
    Domain.deploy_autodns
    if ENV['RAILS_ENV']=='production'
      flash[:notice]="AutoDNS has been run, changes should be picked up in about 5 minutes"
    end
    redirect_to :action => 'list'
  end

end
