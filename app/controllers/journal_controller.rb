class JournalController < ApplicationController
  def show
    @journal = Journal.find_by_nlm_id params[:nlm_id]

    respond_to do |format|
      format.html
      format.json { render json: @journal }
    end
  end
end
