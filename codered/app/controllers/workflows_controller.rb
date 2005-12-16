class WorkflowsController < ApplicationController
require 'workflow'

  def index
    list
    render :action => 'list'
  end

  def list
    @workflow_pages, @workflows = paginate :workflows, :per_page => 10
  end

  def show
    @workflow = Workflow.find(params[:id])
  end

  def create
    @workflow = Workflow.new(params[:workflow])
	@ticket = Ticket.find(params[:ticket])
	@ticket.ticket_status = params[:post][:ticket_status]
    @ticket.save
    if params[:ticket_status] == 3
        @beschreibung = "Geschlossen weil " + params[:beschreibung].to_s
    end
    @workflow = Workflow.new
    @workflow.user_id = User.find(params[:user]).id  
    @workflow.ticket_id = params[:ticket]
    @workflow.workflow_text = params[:beschreibung]
    if @workflow.save
      redirect_to :action => 'ticket_list', :ticket => @ticket
    else
      render :text => "Hier ist ein Fehler aufgetreten"
    end	
  end


  def new
	 @ticket = Ticket.find(params[:ticket])
     @grund = params[:grund]
     render_partial 'form'
  end 
  
  def edit
    @workflow = Workflow.find(params[:id])
  end

  def update
    @workflow = Workflow.find(params[:id])
    if @workflow.update_attributes(params[:workflow])
      flash[:notice] = 'Workflow was successfully updated.'
      redirect_to :action => 'show', :id => @workflow
    else
      render :action => 'edit'
    end
  end

  def destroy
    Workflow.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

def ticket_list 
	unless @params[:ticket].nil?
		@ticket = Ticket.find(params[:ticket])
		@workflows = Workflow.find(:all, :conditions => ["ticket_id = (?)", @ticket.id] , :order => "created_on DESC")
    end
	render_partial 'workflow' 
end

def wf_text
     render_partial 'wf_text'
 end



end
