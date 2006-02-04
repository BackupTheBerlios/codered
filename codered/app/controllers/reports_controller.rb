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
	  render :inline => '<div>Das hat wohl funktioniert</div>', :layout => false
     # flash[:notice] = 'Report was successfully created.'
     # redirect_to :action => 'list'
	else
	  render :inline => '<div>Hier ist kein Text</div>', :layout => false
    end
  end

  def upload_status
    render :inline => '<div><%= upload_progress.completed_percent rescue 0 %> % complete Uploaded am <%= Time.now %></div>', :layout => false
  end
 
  def destroy
	if @session[:rechte] <= 2 || @report.user_id == @session[:user].id
    Report.find(params[:id]).destroy
    	redirect_to :action => 'list'
	else
    	redirect_to :action => 'list'
    end
  end
end
