class CodeletsController < ApplicationController
  def index
    # TODO paginate codelets
    @codelets = Codelet.all

    render :index
  end

  def new
    @codelet = Codelet.new
    
    render :new
  end

  def create
    @codelet = Codelet.new(codelet_params)

    if @codelet.save
      redirect_to codelet_path(@codelet)
    else
      render :new
    end
  end

  def edit
    @codelet = Codelet.find(params[:id])

    render :edit
  end

  def update
    @codelet = Codelet.find(params[:id])
    
    if @codelet.update(codelet_params)
      redirect_to codelet_path(@codelet)
    else
      render :edit
    end
  end

  def destroy
    begin
      # NOTE: This just deletes with SQL, it will not touch ActiveRecord
      # and so will not call any ActiveRecord-related callbacks
      Codelet.delete(params[:id])
      redirect_to codelets_path
    rescue ActiveRecord::RecordNotFound => err
      Rails.logger.error("Codelet not found: #{params[:id]}")
      flash.error = "Codelet was not found"
    end
  end

  private

  def codelet_params
    params.require(:codelet).permit(:name, :description, :examples)
  end
end
