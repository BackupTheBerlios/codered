class WorkflowsController < ApplicationController
before_filter :login_required
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
    @user = @session[:user]
	@ticket = Ticket.find(params[:ticket])
	
	if @user.user_rule > 1 &&  @user.user_rule < 5 then
	# wenn ein User ungueltig oder administrator ist, hat er nix einzutragen!
		if @ticket.ticket_status == 0 then
			# wenn ticket neu
			if @user.user_rule == 2 then
				#Mentor
				if params[:grund] == "2" || params[:grund] == "4" then
					#darf 2schliessen 4zuweisen
					schreiben
				else 
					render :text => "Hier ist ein Fehler aufgetreten(0010)"
				end #darf
			elsif @user.user_rule == 3 then
				#Betreuer
				if params[:grund] == "5" then
					# er darf 5ticketübernehmen
					schreiben
				else
					render :text => "Hier ist ein Fehler aufgetreten(0011)"
				end # darf
			elsif @user.user_rule == 4 then
				#Kontakt
				if params[:grund] == "2" then
					# er darf 2schliessen
					schreiben
				else
					render :text => "Hier ist ein Fehler aufgetreten(0012)"
				end #darf
			else 
				render :text => "Hier ist ein Fehler aufgetreten(0016)"
			end #userstatus
		elsif @ticket.ticket_status == 1 then 
			# wenn ticket zugewiesen
			if @user.user_rule == 2 then 
				#Mentor
				if @user.id == @ticket.betreuer_id then
					#wenn das Ticket dem Betreuer(ein Mentor kann auch betreuer sein) zugewiesen wurde
					if params[:grund] > "0" && params[:grund] < "5" then
						# er darf 1freitext 2schliessen 3zurueckweisen 4zuweisen
						schreiben
					else
						render :text => "Hier ist ein Fehler aufgetreten(0006)"
					end #darf
				else
					if params[:grund] == "4" || params[:grund] == "1" || params[:grund] == "5" then
						# er darf 4zuweisen 1freitext 5ticketübernehmen
						schreiben
					else
						render :text => "Hier ist ein Fehler aufgetreten(0005)"
					end #darf
				end# zugewiesen an person
			elsif @user.user_rule == 3 then
				#Betreuer
				if @user.id == @ticket.betreuer_id then
					#wenn das Ticket dem Betreuer zugewiesen wurde
					if params[:grund] > "0" && params[:grund] < "4" then
						# er darf 1freitext 2schliessen 3zurueckweisen
						schreiben
					else
						render :text => "Hier ist ein Fehler aufgetreten(0007)"
					end #darf
				else
					render :text => "Hier ist ein Fehler aufgetreten(0004)"
				end	#zugewiesen an person
			elsif @user.user_rule == 4 then
				#Kontakt
				if @user.id == @ticket.betreuer_id then 
					#wenn das Ticket dem Kontakt zugewiesen wurde (was falsch ist)
					render :text => "Hier ist ein Fehler aufgetreten(0008)"
				else
					if params[:grund] > "0" && params[:grund] < "3" then 
						# er darf 1freitext 2schliessen
						schreiben
					else
						render :text => "Hier ist ein Fehler aufgetreten(0009)"
					end #darf
				end	#zugewiesen an person
			else
				render :text => "Hier ist ein Fehler aufgetreten(0017)"
			end #userstatus
		elsif @ticket.ticket_status == 2 then
			# wenn ticket vollzuggemeldet
			if @user.user_rule == 2 then
				#Mentor
				if params[:grund] == "4" || params[:grund] == "1" then
					# er darf 1freitext 4zuweisen
					schreiben
				else
					render :text => "Hier ist ein Fehler aufgetreten(0013)"
				end #darf
        	elsif @user.user_rule == 3 then
				#Betreuer
				if params[:grund] == "5" then
					# er darf 5ticketuebernehmen
					schreiben
				else
					render :text => "Hier ist ein Fehler aufgetreten(0014)"
				end #darf
			elsif @user.user_rule == 4 then
				#Kontakt
				if params[:grund] == "2" || params[:grund] == "3" then
					# er darf 2schliessen 3zurueckweisen
					schreiben
				else
					render :text => "Hier ist ein Fehler aufgetreten(0015)"
				end #darf
			else
				render :text => "Hier ist ein Fehler aufgetreten(0007)"
			end #userstatus
	  else
		render :text => 'Hier ist ein Fehler aufgetreten(0002)'
	  end#ticketstatus
    else
      render :text => "Hier ist ein Fehler aufgetreten(0001)"
	end# admin oder ungueltig bremse
 end


def schreiben
    @user = @session[:user]
	@ticket = Ticket.find(params[:ticket])
		if params[:grund] == '2' # Beim Schliessen
			@ticket.ticket_status = params[:workflow][:ticket_status]
		else 
			@ticket.ticket_status = params[:ticket_status]
		end
		if params[:grund] == '4'
			@ticket.betreuer_id = params[:betreuer_id]
		end
		if params[:grund] == '3'
			@ticket.betreuer_id = @ticket.betreuer_id  #TODO: muss auf einen freien Mentor zeigen
			@ticket.ticket_status = '0' 
		end
		@ticket.save
		@workflow = Workflow.new
		@workflow.user_id = User.find(params[:user]).id  
		@workflow.grund = params[:grund]
		@workflow.ticket_id = params[:ticket]
		@workflow.workflow_text = params[:beschreibung]
		if @workflow.save
			@workflows = Workflow.find(:all, :conditions => ["ticket_id=(?)",@workflow.ticket_id])
			render_partial 'workflow' 
		else
		  render :text => "Hier ist ein Fehler aufgetreten"
		end	
end

  def new
    @user = @session[:user]
	@ticket = Ticket.find(params[:ticket])
	#@regeln.new
	@regeln = []
	if @user.user_rule > 1 &&  @user.user_rule < 5 then
	# wenn ein User ungueltig oder administrator ist, hat er nix einzutragen!
		if @ticket.ticket_status == 0 then# wenn ticket neu
			if @user.user_rule == 2 then #Mentor
				@regeln = [2,4] #darf 2schliessen 4zuweisen
			elsif @user.user_rule == 3 then	#Betreuer
				@regeln = [5] # er darf 5ticketübernehmen
			elsif @user.user_rule == 4 then	#Kontakt
				@regeln = [2] # er darf 2schliessen
			end #userstatus
		elsif @ticket.ticket_status == 1 then # wenn ticket zugewiesen
			if @user.user_rule == 2 then #Mentor
				if @user.id == @ticket.betreuer_id then #wenn das Ticket dem Betreuer(ein Mentor kann auch betreuer sein) zugewiesen wurde
					@regeln = [1,2,3,4] # er darf 1freitext 2schliessen 3zurueckweisen 4zuweisen
				else
					@regeln = [1,4,5] # er darf 4zuweisen 1freitext 5ticketübernehmen
				end# zugewiesen an person
			elsif @user.user_rule == 3 then
				#Betreuer
				if @user.id == @ticket.betreuer_id then #wenn das Ticket dem Betreuer zugewiesen wurde
					@regeln = [1,2,3]	# er darf 1freitext 2schliessen 3zurueckweisen
				end	#zugewiesen an person
			elsif @user.user_rule == 4 then
				#Kontakt
				if @user.id == @ticket.betreuer_id then #wenn das Ticket dem Kontakt zugewiesen wurde (was falsch ist)
				else
					@regeln = [1,2]	# er darf 1freitext 2schliessen
				end	#zugewiesen an person
			end #userstatus
		elsif @ticket.ticket_status == 2 then # wenn ticket vollzuggemeldet
			if @user.user_rule == 2 then #Mentor
					@regeln = [1,4] # er darf 1freitext 4zuweisen
        	elsif @user.user_rule == 3 then	#Betreuer
					@regeln = [5]	# er darf 5ticketuebernehmen
			elsif @user.user_rule == 4 then	#Kontakt
					@regeln = [2,3] # er darf 2schliessen 3zurueckweisen
			end #userstatus
	  end#ticketstatus
	end# admin oder ungueltig bremse
	render_partial 'form'
  end 
  
  def edit
	if @session[:rechte] == 1
    	@workflow = Workflow.find(params[:id])
	end
  end

  def update
    @workflow = Workflow.find(params[:id])
	if @session[:rechte] == 1
    if @workflow.update_attributes(params[:workflow])
      flash[:notice] = 'Workflow was successfully updated.'
      redirect_to :action => 'show', :id => @workflow
    else
      render :action => 'edit'
	end
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
	if @session[:rechte] == 2
	 	@betreuer = User.find(:all, :order => "user_name") #TODO: noch nach "user-klasse" filtern
		@phrase = request.raw_post || request.query_string
		@phrase = @phrase.chomp("&_=")
		matcher = Regexp.new(@phrase)
		@results = @betreuer.find_all { |betreuer| betreuer.user_name + betreuer.user_vorname + betreuer.login =~ matcher } 
		render(:layout => false)
	else
		render(:layout => false)
	end
	end

end
