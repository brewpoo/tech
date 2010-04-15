class LinkController < ApplicationController

  active_scaffold :link do |config|
    list.columns = [:link_category, :title, :url]
    show.columns = create.columns = update.columns = [:link_category, :title, :url]
    list.sorting = {:title => :desc}
    columns[:link_category].form_ui = :select
  end

end
