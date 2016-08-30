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
      render json: {'message' => 'Unterobjekt wurde angelegt'}
    else
      render status: 406, json: {
        'message' => 'Unterobjekt konnte nicht angelegt werden',
        'errors' => @sub_entry.errors
      }
    end
  end

  def update
    @sub_entry = SubEntry.find(params[:id])

    if @sub_entry.update_attributes(sub_entry_params)
      render json: {'message' => 'Unterobjekt wurde geändert'}
    else
      render status: 406, json: {
        'message' => 'Unterobjekt konnte nicht geändert werden',
        'errors' => @sub_entry.errors
      }
    end
  end

  def destroy
    @sub_entry = SubEntry.find(params[:id])
    @sub_entry.destroy
    render status: 200, json: {'message' => 'Unterobjekt wurde gelöscht'}
  end

  def autocomplete
    @strings = SubEntry.
      select(params[:column]).
      where("#{params[:column]} LIKE ?", "%#{params[:term]}%").
      distinct.
      limit(10)

    render :json => @strings.pluck(params[:column])
  end


  protected

    def sub_entry_params
      params.fetch(:sub_entry, {}).permit(
        :main_entry_id,
        :sequence, :inventory_ids, :inventory_id_list,
        :title, :description, 
        :creator, :location, :dating, 
        :height, :width, :depth, :diameter, :weight, 
        :height_with_socket, :width_with_socket, :depth_with_socket, 
        :markings, :material, :framing, :restaurations
      )
    end

end
