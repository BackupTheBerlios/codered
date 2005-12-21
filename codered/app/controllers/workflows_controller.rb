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
	@ticket = Ticket.find(params[:ticket])
	if params[:grund] == '2' # Beim Schliessen
		@ticket.ticket_status = params[:workflow][:ticket_status]
	else 
		@ticket.ticket_status = params[:ticket_status]
	end
	if params[:grund] == '4'
		@ticket.betreuer_id = params[:betreuer_id]
	end
    @ticket.save
    @workflow = Workflow.new
    @workflow.user_id = User.find(params[:user]).id  
	@workflow.grund = params[:grund]
    @workflow.ticket_id = params[:ticket]
    @workflow.workflow_text = params[:beschreibung]
    if @workflow.save
        @workflows = Workflow.find(:all, :conditions => ["id=(?)",@workflow.id]) #sieht komisch aus, ist aber nötig (partials workflow will nen array mit workflows und "find(@workflow.id)" wuerde nur ein einzelnes objekt zurueckliefern)
		render_partial 'workflow' 
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
  def new_schliessen
	 @ticket = Ticket.find(params[:ticket])
     render_partial 'tmpl_schliessen'
  end 
  def new_freitext
	 @ticket = Ticket.find(params[:ticket])
     render_partial 'tmpl_freitext'
  end 
  def new_zurueckweisen
	 @ticket = Ticket.find(params[:ticket])
     render_partial 'tmpl_zurueckweisen'
  end 
  def new_zuweisen
	 @ticket = Ticket.find(params[:ticket])
     render_partial 'tmpl_zuweisen'
  end 
	
  	def search
	 	@betreuer = User.find(:all, :order => "user_name") #TODO: noch nach "user-klasse" filtern
		@phrase = request.raw_post || request.query_string
		@phrase = @phrase.chomp("&_=")
		matcher = Regexp.new(@phrase)
		@results = @betreuer.find_all { |betreuer| betreuer.user_name + betreuer.user_vorname + betreuer.login =~ matcher } 
		render(:layout => false)
	end
end
