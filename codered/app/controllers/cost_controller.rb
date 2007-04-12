class CostController < ApplicationController
  def index
    render :action => 'start'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
#    @cost_pages, @costs = paginate :costs, :per_page => 10
    @cost = Cost.find(:first)
  end

  def show
    @cost = Cost.find(:first)
  end

  def edit
    @cost = Cost.find(1)
  end
 
  def update
    @cost = Cost.find(:first)
    if @cost.update_attributes(params[:cost])
      flash[:notice] = 'Cost was successfully updated.'
      redirect_to :action => 'edit', :id => @cost
    else
      render :action => 'edit'
    end
  end

end
