class MediaController < ApplicationController

  before_action do
    @sub_entry = SubEntry.find(params[:sub_entry_id])
  end

  def create
    @medium = @sub_entry.media.build(medium_params)
    
    if @medium.save
      @message = 'medium has been created'
    else
      @message = 'medium was not created'
      @errors = @medium.errors
      render status: 406
    end
  end

  def update
    @medium = @sub_entry.media.find(params[:id])

    if @medium.update(medium_params)
      render json: {'message' => 'medium has been updated'}
    else
      render status: 406, json: {
        'message' => 'medium was not updated',
        'errors' => @medium.errors
      }
    end
  end

  def destroy
    @medium = @sub_entry.media.find(params[:id])
    @medium.destroy
    @message = 'medium has been removed'
  end


  protected

    def medium_params
      params.fetch(:medium, {}).permit(
        :image
      )
    end

end
