class Journal < ActiveRecord::Base
  attr_accessor :id, :preferred, :nlm_id, :abbrv, :full, :issn_print, :issn_online,
                :start_year, :end_year

end
