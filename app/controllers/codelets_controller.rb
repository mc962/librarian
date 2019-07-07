class CodeletsController < ApplicationController
  def index
    # TODO paginate codelets
    @codelets = Codelet.library.page(params[:page])

    render :index
  end

  def show
    @codelet = Codelet.find(params[:id])
    
    render :show
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
      flash.now[:danger] = @codelet.errors.full_messages
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
      flash.now[:danger] = @codelet.errors.full_messages
      render :edit
    end
  end

  def destroy
      begin
        Codelet.destroy(params[:id])        
      rescue ActiveRecord::RecordNotFound => error
        message = "Couldn't find Codelet with 'slug'=#{params[:id]} to delete"
        Rails.logger.error message
        flash.now[:danger] = "Codelet was not found, therefore nothing was deleted"
      end

      redirect_to codelets_path
  end

  private

  def codelet_params
    params.require(:codelet).permit(:name, :description, :examples, :publicly_accessible)
  end
end
