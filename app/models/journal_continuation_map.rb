class JournalContinuationMap < ActiveRecord::Base
  belongs_to :source_journal, class_name: 'Journal'
  belongs_to :verb
  belongs_to :target_journal, class_name: 'Journal'
end
