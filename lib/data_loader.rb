class DataLoader
  def load(filename)
    begin
      each_record(filename) do |r|
        save_record r
      end

      each_record(filename) do |r|
        save_continuation_map r
      end

    rescue Exception => e
      Rails.logger.error "caught #{e.class.name} processing continuation trail '#{trail}' - #{e.message}"
    end
  end

  private

  def each_record(filename)
    raise 'block required' unless block_given?

    file = File.new(filename)

    headers = nil
    file.each do |line|
      parts = line.split /\s*\|\s*/
      if headers == nil
        headers = parts.collect{ |p| p.downcase.strip.to_sym }

      else
        record = {}
        for i in 0 ... headers.size do
          record[headers[i]] = parts[i]
        end

        yield record
      end
    end
  end

  def save_record(r)
    pref_nlm_id = r[:preferred_nlmid]
    variant_nlm_id = r[:variant_nlmid]

    if pref_nlm_id == variant_nlm_id
      journal = Journal.find_by_nlm_id pref_nlm_id
      if journal == nil
        journal = Journal.new(preferred: true,
                              nlm_id: r[:preferred_nlmid],
                              abbrv: r[:preferred_abbrv],
                              full: r[:preferred_full],
                              issn_print: r[:preferred_issn_print],
                              issn_online: r[:preferred_issn_online],
                              start_year: r[:variant_start_year],
                              end_year: r[:variant_end_year])
        journal.save!
      end

    else
      journal = Journal.find_by_nlm_id variant_nlm_id
      if journal == nil
        journal = Journal.new(preferred: false,
                              nlm_id: r[:variant_nlmid],
                              abbrv: r[:variant_abbrv],
                              full: r[:variant_full],
                              issn_print: r[:variant_issn_print],
                              issn_online: r[:variant_issn_online],
                              start_year: r[:variant_start_year],
                              end_year: r[:variant_end_year])
        journal.save!
      end
    end

    def save_continuation_map(r)
      trail = r[:continuation_trail]

      return if trail.nil?

      # need to get the LAST instance of (\d+) from the left and right of -verb-> to handle, e.g. :
      #  Blah journal (2003) (37472817) -Continued by-> Blah blah journal (2) (2014) (47373622)
      # because this kind of stuff happens

      journals = []
      verbs = []
      verb_regex = /\s*-([a-zA-Z ]+)->\s*/
      id_regex = /\(([^)]+)\)\s*$/
      parts = trail.split verb_regex

      for i in 0 ... parts.size do
        if i % 2 == 0
          journals << Journal.find_by_nlm_id(parts[i][id_regex, 1])

        else
          verbs << Verb.find_by_name("is #{parts[i].downcase}")
        end
      end

      while journals.size >= 2 && verbs.any? do
        source_journal = journals.delete_at(0)
        verb = verbs.delete_at(0)
        target_journal = journals[0]      # do not delete - this will become the source journal on the next iteration

        map = JournalContinuationMap.find_by source_journal_id: source_journal.id,
                                             target_journal_id: target_journal.id

        if map.nil?
          map = JournalContinuationMap.new(source_journal_id: source_journal.id,
                                           verb_id: verb.id,
                                           target_journal_id: target_journal.id)
          map.save!

        elsif map.verb.id != verb.id
          raise "found conflicting verb connecting journal (#{source_journal.nlm_id}) with journal (#{target_journal.nlm_id}) for variant NLM ID #{r[:variant_nlmid]}"
        end
      end

      if journals.size > 1 || verbs.any?
        raise "found unprocessed journals and / or verbs processing record for variant NLM ID #{r[:variant_nlmid]}"
      end
    end
  end
end