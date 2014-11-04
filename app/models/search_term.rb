class SearchTerm < ActiveRecord::Base
  has_many :term_journal_maps, :foreign_key => 'term_id'
  has_many :journals, :through => :term_journal_maps
end
