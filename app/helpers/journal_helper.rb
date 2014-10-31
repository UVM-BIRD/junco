module JournalHelper
  def build_trail(journal)
    trail = '<table><tr>'
    trail += "<td>#{build_source_trail(journal)}</td>\n" if journal.sources.any?
    trail += "<td class='trailItem'>#{render_journal(journal)}</td>\n"
    trail += "<td>#{build_target_trail(journal)}</td>\n" if journal.targets.any?
    trail += '</tr></table>'
    trail.html_safe
  end

  private

  def build_source_trail(journal)
    sources = journal.sources
    if sources.any?
      trail = '<table>'
      for i in 0 ... sources.size do
        trail += '<tr>'
        trail += "<td>#{build_source_trail(sources[i].source_journal)}</td>"
        trail += "<td class='trailItem'>#{render_journal(sources[i].source_journal)} <em>-#{sources[i].verb.name}-&gt;</em></td>"
        trail += '</tr>'
      end
      trail + '</table>'

    else
      ''
    end
  end

  def build_target_trail(journal)
    targets = journal.targets
    if targets.any?
      trail = '<table>'
      for i in 0 ... targets.size do
        trail += '<tr>'
        trail += "<td class='trailItem'><em>-#{targets[i].verb.name}-&gt;</em> #{render_journal(targets[i].target_journal)}</td>"
        trail += "<td>#{build_target_trail(targets[i].target_journal)}</td>"
        trail += '</tr>'
      end
      trail + '</table>'

    else
      ''
    end
  end

  def render_journal(journal)
    link_to journal.abbrv, "/journal/#{journal.nlm_id}"
  end
end
