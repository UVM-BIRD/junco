class DataLoader
  def load(filename)
    headers = nil

    f = File.new(filename)
    f.each do |line|
      parts = line.split /\s*\|\s*/
      if headers == nil
        headers = parts.collect{ |p| p.downcase.to_sym }

      else
        record = {}
        for i in 0 ... headers.size do
          record[headers[i]] = parts[i]
        end
        save_record record
      end
    end
  end

  private

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

        save_continuation_map r
      end
    end

    def save_continuation_map(r)
      trail = r[:continuation_trail]
      regex = /[^(]+\((\d+)\)\s*-([^-]+)->[^(]+\((\d+)\)/

      while true do
        md = regex.match trail

        break if md == nil

        source = Journal.find_by_nlm_id md[1]
        target = Journal.find_by_nlm_id md[3]
        verb = Verb.find_by_name "is #{md[2].downcase}"

        map = JournalContinuationMap.new(source_journal: source,
                                         verb: verb,
                                         target_journal: target)

        map.save!

        trail = trail[(trail.index('->') + 2)..-1].lstrip
      end
    end
  end
end