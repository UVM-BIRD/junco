class Journal < ActiveRecord::Base
  def sources
    if @sources.nil?
      @sources = JournalContinuationMap.where(target_journal_id: id)
    end
    @sources
  end

  def targets
    if @targets.nil?
      @targets = JournalContinuationMap.where(source_journal_id: id)
    end
    @targets
  end
end
