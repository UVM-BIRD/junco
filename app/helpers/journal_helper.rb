module JournalHelper
  def build_trail(journal)
    current = find_current journal

    trail = '<table id=\'trail\'><tr>'
    trail += "<td>#{build_source_trail(journal, current)}</td>\n" if journal.sources.any?
    trail += "<td class='query'>#{render_query_journal(journal)}</td>\n"
    trail += "<td>#{build_target_trail(journal, current)}</td>\n" if journal.targets.any?
    trail += '</tr></table>'
    trail.html_safe
  end

  def find_current(journal)
    current = nil
    max_depth = -1

    find_current_helper(journal, 0).each do |hsh|
      if hsh[:depth] > max_depth
        max_depth = hsh[:depth]
        current = hsh[:journal]
      end
    end

    current
  end

  private

  def build_source_trail(journal, current)
    sources = journal.sources
    if sources.any?
      trail = '<table class=\'invis\'>'
      for i in 0 ... sources.size do
        trail += '<tr><td><table class=\'source\'><tr>'
        trail += "<td>#{build_source_trail(sources[i].source_journal, current)}</td>"
        trail += "<td class='source'>#{render_journal(sources[i].source_journal, current)} #{render_verb(sources[i].verb)}</td>"
        trail += '</tr></table></td></tr>'
      end
      trail + '</table>'

    else
      ''
    end
  end

  def build_target_trail(journal, current)
    targets = journal.targets
    if targets.any?
      trail = '<table class=\'invis\'>'
      for i in 0 ... targets.size do
        trail += '<tr><td><table class=\'target\'><tr>'
        trail += "<td class='target'>#{render_verb(targets[i].verb)} #{render_journal(targets[i].target_journal, current)}</td>"
        trail += "<td>#{build_target_trail(targets[i].target_journal, current)}</td>"
        trail += '</tr></table></td></tr>'
      end
      trail + '</table>'

    else
      ''
    end
  end

  def render_verb(verb)
    s = "<div class='verb'>"
    s += "<div class='label'>-#{verb.name}-&gt;</div>"
    s += '<div class=\'verbRef\'>'
    s += "<div class='verbRefName'>#{verb.name}</div>"
    s += "<div class='verbRefRdawId'>#{link_to(verb.rdaw_id, verb.url, target: '_blank')}</div>"
    s += "<div class='verbRefDesc'>#{verb.desc}</div>"
    s + '</div></div>'
  end

  def render_journal(journal, current)
    s = '<span'
    s += ' class=\'currentJournal\'' if journal.id == current.id
    s += ">#{link_to(journal.abbrv, controller: 'journal', action: 'show', nlm_id: journal.nlm_id)}</span> "
    s + "<span>(#{link_to(journal.nlm_id, journal.url, target: '_blank')})</span>"
  end

  def render_query_journal(journal)
    s = "<span class='queryJournal'>#{journal.abbrv}</span> "
    s + "<span>(#{link_to(journal.nlm_id, journal.url, target: '_blank')})</span>"
  end

  def find_current_helper(journal, depth)
    depth ||= 0

    if journal.targets.any?
      arr = []
      journal.targets.each do |t|
        arr << find_current_helper(t.target_journal, depth + 1).flatten
      end
      arr.flatten

    else
      [ { journal: journal, depth: depth } ]
    end
  end
end
