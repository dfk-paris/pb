class MediaController < ApplicationController

  before_action do
    @main_entry = MainEntry.find(params[:main_entry_id])
    @sub_entry = @main_entry.sub_entries.find(params[:sub_entry_id])
  end

  def create
    @medium = @sub_entry.media.build(medium_params)
    
    if @medium.save
      render json: {'message' => 'medium has been created'}
    else
      render status: 406, json: {
        'message' => 'medium was not created',
        'errors' => @medium.errors
      }
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


  protected

    def medium_params
      params.fetch(:medium, {}).permit(
        :image
      )
    end

end
