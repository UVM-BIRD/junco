class TermJournalMap < ActiveRecord::Base
  belongs_to :term, :class_name => 'SearchTerm'
  belongs_to :journal
end
