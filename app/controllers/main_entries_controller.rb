class MainEntriesController < ApplicationController

  skip_before_action :auth, only: [:index, :show]

  def index
    @main_entries = MainEntry.
      with_order.
      include_unpublished(params[:unpublished]).
      by_title(params[:title]).
      by_location(params[:location]).
      by_creator(params[:creator]).
      by_inventory(params[:inventory]).
      pageit(params[:page], params[:per_page]).
      all
  end

  def show
    @main_entry = MainEntry.find(params[:id])
  end

  def create
    @main_entry = MainEntry.new(main_entry_params)
    
    if @main_entry.save
      render json: {'message' => 'Haupteintrag wurde angelegt'}
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
      render json: {'message' => 'Haupteintrag wurde geändert'}
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
    render status: 200, json: {'message' => 'Haupteintrag wurde gelöscht'}
  end


  protected

    def main_entry_params
      params.fetch(:main_entry, {}).permit(
        :title,
        :location,
        :sequence,
        :provenience,
        :historical_evidence,
        :literature,
        :description,
        :appreciation,
        :publish
      )
    end

end
