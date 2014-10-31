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

  def url
    "http://www.ncbi.nlm.nih.gov/nlmcatalog/?term=#{nlm_id}[nlmid]"
  end
end
