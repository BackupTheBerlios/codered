class CostController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @cost_pages, @costs = paginate :costs, :per_page => 10
  end

  def show
    @cost = Cost.find(params[:id])
  end

  def new
    @cost = Cost.new
  end

  def create
    @cost = Cost.new(params[:cost])
    if @cost.save
      flash[:notice] = 'Cost was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @cost = Cost.find(params[:id])
  end

  def update
    @cost = Cost.find(params[:id])
    if @cost.update_attributes(params[:cost])
      flash[:notice] = 'Cost was successfully updated.'
      redirect_to :action => 'show', :id => @cost
    else
      render :action => 'edit'
    end
  end

  def destroy
    Cost.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
