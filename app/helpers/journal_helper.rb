module JournalHelper
  def build_trail(journal)
    trail = '<table class=\'trail\'><tr>'
    trail += "<td>#{build_source_trail(journal)}</td>\n" if journal.sources.any?
    trail += "<td class='this trailItem'><span class='label'>#{journal.abbrv}</span></td>\n"
    trail += "<td>#{build_target_trail(journal)}</td>\n" if journal.targets.any?
    trail += '</tr></table>'
    trail.html_safe
  end

  private

  def build_source_trail(journal)
    sources = journal.sources
    if sources.any?
      trail = '<table class=\'invisible\'>'
      for i in 0 ... sources.size do
        trail += '<tr><td><table class=\'source\'><tr>'
        trail += "<td>#{build_source_trail(sources[i].source_journal)}</td>"
        trail += "<td class='source trailItem'><span class='label'>#{render_journal(sources[i].source_journal)}</span> <span class='verb'>-#{sources[i].verb.name}-&gt;</verb></td>"
        trail += '</tr></table></td></tr>'
      end
      trail + '</table>'

    else
      ''
    end
  end

  def build_target_trail(journal)
    targets = journal.targets
    if targets.any?
      trail = '<table class=\'invisible\'>'
      for i in 0 ... targets.size do
        trail += '<tr><td><table class=\'target\'><tr>'
        trail += "<td class='target trailItem'><span class='verb'>-#{targets[i].verb.name}-&gt;</span> <span class='label'>#{render_journal(targets[i].target_journal)}</span></td>"
        trail += "<td>#{build_target_trail(targets[i].target_journal)}</td>"
        trail += '</tr></table></td></tr>'
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
