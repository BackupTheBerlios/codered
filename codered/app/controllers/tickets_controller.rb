class TicketsController < ApplicationController
before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  def list
    @ticket_pages, @tickets = paginate :ticket, :per_page => 5
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to :action => 'show', :id => @ticket
    else
      render :action => 'edit'
    end
  end

  def destroy
    Ticket.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

 def add_workflow
	@ticket = Ticket.find(params[:id])
	@ticket.ticket_status = params[:ticket][:ticket_status]
	@ticket.save
 	if params[:ticket][:ticket_status] == 3
		@beschreibung = "Geschlossen weil " + params[:beschreibung].to_s
	end
	@workflow = Workflow.new
	@workflow.user_id = 1 
	@workflow.ticket_id = 1
	@workflow.workflow_text = params[:beschreibung]
	@workflow.save
	render_partial 'wf_list', @ticket
 end	 

 def show_nw_wf 
     @id = Ticket.find(params[:id])
	 @grund = params[:grund]
	 render_partial 'form_nw_wf'
 end

 def wf_text
	 render_partial 'wf_text'
 end
 
end
