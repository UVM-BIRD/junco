class JournalContinuationMap < ActiveRecord::Base
  belongs_to :source_journal
  belongs_to :verb
  belongs_to :target_journal
end
