module ApplicationHelper

  # use comment out html code server-side
  def comment
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

  def group_icon(options = {})
    fa_icon(icon_groups, options)
  end

  def member_icon(options = {})
    fa_icon(icon_members, options)
  end

  def repository_icon(options = {})
    fa_icon(icon_repositories, options)
  end
  
end
