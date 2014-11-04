class SearchController < ApplicationController
  require 'will_paginate/array'

  def search
    terms = params[:query] == nil ?
        [] :
        params[:query].strip.downcase.gsub(/[^a-z0-9 ]/, ' ').split(/\s+/).uniq.reject { |t| t.empty? }

    terms -= %w(journal j)

    arr = nil

    # check for exact NLM ID match first
    terms.each do |t|
      j = Journal.find_by_nlm_id t
      if j != nil
        arr = arr == nil ? [j.id] : arr & [j.id]
        terms.delete t
      end
    end

    # find journals matching specified search terms, or ensure that any journals matched using NLM ID matching above
    # ALSO match the specified search terms.  all returned journals must match all specified terms.
    terms.each do |t|
      st = SearchTerm.find_by_term(t)

      if st.nil?
        arr = nil                 # no journals matched the specified term!  we can stop searching now -
        break

      else
        if arr.nil?
          arr = st.term_journal_maps.collect { |m| m.journal_id }

        else
          arr = arr & st.term_journal_maps.collect { |m| m.journal_id }
        end

        break if arr.empty?
      end
    end

    arr ||= []

    arr.map! { |id| Journal.find(id) }
    arr.sort! { |a, b| a.full <=> b.full }

    @journals = arr.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html
      format.json { render json: @journals }
    end
  end

  private

  def matches(j, q)
    j.nlm_id == q ||
        j.abbrv.downcase.include?(q) ||
        j.full.downcase.include?(q)
  end
end
