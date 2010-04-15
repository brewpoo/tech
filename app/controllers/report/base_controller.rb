class Report::BaseController < ApplicationController

  layout "report"

  def index
    @reports = Report.find_all_by_controller(controller_name).map{|r| [r.title, r.id]} || Report.new
  end

  def show
    render_flash("Must choose a report") and return if params[:id].nil?
    @report = Report.find(params[:id])
    @filters = @report.build_filters
    @description = @report.description
    render :update do |page|
      page.replace_html 'report-filters', :partial => 'report/report_filters', :locals => { :filters => @filters, :description => @description }
    end
  end

  def run
    render_flash("Must choose a report") and return if params[:report][:id].blank?
    @report = Report.find(params[:report][:id])
    # Render data based on
    report = (@report.controller.capitalize+"::"+@report.action.camelize+"Report").constantize
    case params[:output_format]
      when 'csv'
        send_data report.render_csv(params[:filter]), :type => "text/csv", :filename =>"#{@report.title.gsub(/\s/, '').underscore}.csv"
      when 'pdf'
        send_data report.render_pdf(params[:filter]), :type => "application/pdf", :filename => "#{@report.title.gsub(/\s/, '').underscore}.pdf"
      when 'html'
        #render :update do |page|
        #   page.replace_html :results,  report.render_html(params[:filter])
        #end
        send_data report.render_html(params[:filter]), :type => "text/html", :filename =>"#{@report.title.gsub(/\s/, '').underscore}.html"
    end
  end

end
