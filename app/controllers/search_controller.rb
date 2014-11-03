class SearchController < ApplicationController
  require 'will_paginate/array'

  def search
    q = params[:query] == nil ?
        nil :
        params[:query].strip.downcase

    if q != nil
      arr = []
      Journal.all.each do |j|
        arr << j if matches(j, q)
      end

      @journals = arr.paginate page: params[:page], per_page: 20

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
