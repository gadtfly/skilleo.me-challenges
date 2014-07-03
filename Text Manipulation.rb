puts gets.gsub('Java', 'PHP').split(' ').map(&:capitalize).join(' ').split('.').map(&:strip).sort.join('.<br/>') << '.'
