class SearchController < ApplicationController
  def search
    q = params[:query] == nil ?
        nil :
        params[:query].strip.downcase

    @journals = []
    if q != nil
      Journal.all.each do |j|
        @journals << j if matches(j, q)
      end

      respond_to do |format|
        format.html
        format.json { render json: @journals }
      end
    end
  end

  private

  def matches(j, q)
    j.nlm_id == q ||
        j.abbrv.downcase.include?(q) ||
        j.full.downcase.include?(q)
  end
end
