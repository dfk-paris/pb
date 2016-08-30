class MediaController < ApplicationController

  before_action do
    @sub_entry = SubEntry.find(params[:sub_entry_id])
  end

  def create
    @medium = @sub_entry.media.build(medium_params)
    
    if @medium.save
      @message = 'medium wurde erstellt'
    else
      @message = 'medium konnte nicht erstellt werden'
      @errors = @medium.errors
      render status: 406
    end
  end

  def update
    @medium = @sub_entry.media.find(params[:id])

    if @medium.update(medium_params)
      render json: {'message' => 'medium wurde geändert'}
    else
      render status: 406, json: {
        'message' => 'medium konnte nicht geändert werden',
        'errors' => @medium.errors
      }
    end
  end

  def destroy
    @medium = @sub_entry.media.find(params[:id])
    @medium.destroy
    @message = 'medium wurde gelöscht'
  end


  protected

    def medium_params
      params.fetch(:medium, {}).permit(
        :image, :caption, :publish, :sequence
      )
    end

end
