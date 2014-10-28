class Journal < ActiveRecord::Base
  def sources
    JournalContinuationMap.where(target_journal_id: id)
  end

  def targets
    JournalContinuationMap.where(source_journal_id: id)
  end
end
