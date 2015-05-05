module ApplicationHelper

  # use comment out html code server-side
  def comment
  end

  def link_with_icon(path, icon_name, text = '', options = {})
    if text.is_a? Hash
      options = text
      text = ''
    end
    content_tag(:a, text + fa_icon(icon_name), options.merge( href: url_for(path) ), false)
  end

  # icon mappers, for easy swapping
  def icon_overview
    "dashboard"
  end

  def icon_repositories
    "code-fork"
  end

  def icon_members
    "user"
  end

  def icon_groups
    "group"
  end

  def icon_expand_sidebar
    "angle-double-right"
  end

  def icon_shrink_sidebar
    "angle-double-left"
  end
  
end
