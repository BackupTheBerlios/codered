class ReportsController < ApplicationController
before_filter :login_required
upload_status_for :create

 def index
    list
    render :action => 'list'
  end

  def list
    @report_pages, @reports = paginate :reports, :per_page => 10
  end
  
  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new
	@report.beschreibung = params[:report][:beschreibung]
	@report.client_id = params[:client_id]
	@report.user_id = User.find(params[:user]).id
	@report.datei = params[:report][:datei]
    upload_progress.message = "Upload ..."
    if @report.save
      		flash[:notice] = 'Datei wurde erfolgreich hinzugefügt'
      		redirect_to :action => 'show', :controller => 'clients' , :id => params[:client_id]
	else
      		flash[:notice] = 'Datei muss eine Beschreibung haben, und ein pdf, doc, pps, zip sein.'
      		redirect_to :action => 'show', :controller => 'clients' , :id => params[:client_id]

    end
  end

  def upload_status
    render :inline => '<div><%= upload_progress.completed_percent rescue 0 %> % complete Uploaded am <%= Time.now %></div>', :layout => false
  end
 
  def destroy
  	@report = Report.find(params[:id])
	if @session[:rechte] <= 2 || @report.user_id == @session[:user].id
    Report.find(params[:id]).destroy
    	redirect_to :controller => 'clients', :action => 'show' , :id => Client.find(params[:client]).id
	else
    	redirect_to :action => 'list'
    end
  end
end
