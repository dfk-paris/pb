class SubEntriesController < ApplicationController

  skip_before_action :auth, only: [:index, :show]

  def index
    @sub_entries = SubEntry.includes(:main_entry, :inventory_ids).all
  end

  def show
    @sub_entry = SubEntry.find(params[:id])
  end

  def create
    @sub_entry = SubEntry.new(sub_entry_params)
    
    if @sub_entry.save
      render json: {'message' => 'sub entry has been created'}
    else
      render status: 406, json: {
        'message' => 'sub entry was not created',
        'errors' => @sub_entry.errors
      }
    end
  end

  def update
    @sub_entry = SubEntry.find(params[:id])

    if @sub_entry.update_attributes(sub_entry_params)
      render json: {'message' => 'sub entry has been updated'}
    else
      render status: 406, json: {
        'message' => 'sub entry was not updated',
        'errors' => @sub_entry.errors
      }
    end
  end

  def destroy
    @sub_entry = SubEntry.find(params[:id])
    @sub_entry.destroy
    render status: 200, json: {'message' => 'sub entry has been deleted'}
  end


  protected

    def sub_entry_params
      params.fetch(:sub_entry, {}).permit(
        :title,
        :description,
        :sequence
      )
    end

end
