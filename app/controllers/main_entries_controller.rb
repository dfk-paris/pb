class MainEntriesController < ApplicationController

  skip_before_action :auth, only: [:index, :show]

  def index
    @main_entries = MainEntry.all
  end

  def show
    @main_entry = MainEntry.find(params[:id])
  end

  def create
    @main_entry = MainEntry.new(main_entry_params)
    
    if @main_entry.save
      render json: {'message' => 'main entry has been created'}
    else
      render status: 406, json: {
        'message' => 'main entry was not created',
        'errors' => @main_entry.errors
      }
    end
  end

  def update
    @main_entry = MainEntry.find(params[:id])

    if @main_entry.update(main_entry_params)
      render json: {'message' => 'main entry has been updated'}
    else
      render status: 406, json: {
        'message' => 'main entry was not updated',
        'errors' => @main_entry.errors
      }
    end
  end

  def destroy
    @main_entry = MainEntry.find(params[:id])
    @main_entry.destroy
    render status: 200, json: {'message' => 'main entry has been deleted'}
  end


  protected

    def main_entry_params
      params.fetch(:main_entry, {}).permit(
        :title,
        :location,
        :group,
        :sequence
      )
    end

end
