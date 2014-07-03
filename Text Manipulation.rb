puts gets.gsub(/java/i, 'PHP').split(' ').map(&:capitalize).join(' ').split('.').map(&:strip).sort.join('.<br/>') << '.'
