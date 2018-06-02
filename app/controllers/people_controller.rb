class PeopleController < ApplicationController
  skip_before_action :auth

  def index
    render json: File.read(Rails.root.join 'config/people.json')
  end

  def autocomplete
    term = Regexp.escape(params[:term])
    @people = tagged.select{|v| v.match(/#{term}/i)}.first(10)
    render json: @people
  end

  protected

    def tagged
      dirty = (MainEntry.all_people + SubEntry.all_people)
      dirty.select{|v| v.present?}.sort.uniq
    end
end