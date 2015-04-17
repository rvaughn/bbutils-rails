require 'bitbucket'

namespace :bb do
  desc 'update repository data from Bitbucket'
  task :update_repos => [:environment] do
    ## TODO: make this delete removed repos
    begin
      ActiveRecord::Base.record_timestamps = false
      bb = Bitbucket::Client.new(Rails.application.secrets.bitbucket_username, Rails.application.secrets.bitbucket_password)
      repos = bb.repos
      updated = 0
      repos.each do |r|
        ## simple create:
        # Repository.create(
        #   name: r.name,
        #   slug: r.slug,
        #   desc: r.description,
        #   owner: r.owner_username,
        #   created_at: r.created_on,
        #   updated_at: r.updated_on
        #  )
        record = Repository.find_or_initialize_by(slug: r.slug, owner: r.owner_username) do |record|
          record.name = r.name
          record.slug = r.slug
          record.owner = r.owner_username
        end
        
        record.desc = r.description
        record.created_at = r.created_on
        record.updated_at = r.updated_on
        updated += 1
        record.save!
      end
      puts "#{updated} repositories updated"
    ensure
      ActiveRecord::Base.record_timestamps = true
    end
  end
  
  desc 'update member data from Bitbucket'
  task :update_members => [:environment] do
    ## TODO: make this delete removed members
    bb = Bitbucket::Client.new(Rails.application.secrets.bitbucket_username, Rails.application.secrets.bitbucket_password)
    updated = 0
    bb.members.each do |m|
      record = Member.find_or_initialize_by(username: m.username) do |record|
        record.username = m.username
      end
      
      record.name = m.display_name
      updated += 1
      record.save!
    end
    puts "#{updated} members updated"
  end
  
  desc 'update group data from Bitbucket'
  task :update_groups => [:environment] do
    ## TODO: make this delete removed members
    bb = Bitbucket::Client.new(Rails.application.secrets.bitbucket_username, Rails.application.secrets.bitbucket_password)
    updated = 0
    bb.groups.each do |g|
      record = Group.find_or_initialize_by(slug: g.slug) do |record|
        record.slug = g.slug
        record.name = g.name
      end
      
      record.permission = g.permission
      updated += 1
      record.save!

      ## TODO: this won't update.
      g.members.each do |m|
        member = Member.find_by_username(m.username)
        record.members << member
      end
    end
    puts "#{updated} groups updated"
  end

  desc 'updates member permission data from Bitbucket'
  task :update_member_perms => [:environment] do
    bb = Bitbucket::Client.new(Rails.application.secrets.bitbucket_username, Rails.application.secrets.bitbucket_password)
    updated = 0
    bb.privs.each do |priv|
      repo = Repository.find_by(slug: priv.repository.slug)
      member = Member.find_by(username: priv.user.username)
      MemberPermission.create(member: member, repository: repo, permission: priv.privilege)
      updated += 1
    end
    puts "#{updated} member permissions updated"
  end

  desc 'updates group permission data from Bitbucket'
  task :update_group_perms => [:environment] do
    bb = Bitbucket::Client.new(Rails.application.secrets.bitbucket_username, Rails.application.secrets.bitbucket_password)
    updated = 0
    ## fewer roundtrips to Bitbucket, but larger replies
    # Group.find_each do |group|
    #   bb.group_privs(group.slug).each do |priv|
    #     repo = Repository.find_by(slug: priv.repository.slug)
    #     GroupPermission.create(group: group, repository: repo, permission: priv.privilege)
    #     updated += 1
    #   end
    # end
    ## many roundtrips, smaller replies
    Repository.find_each do |repo|
      bb.group_privs_for_repo(repo.owner, repo.slug).each do |priv|
        group = Group.find_by(slug: priv.group.slug)
        GroupPermission.create(group: group, repository: repo, permission: priv.privilege)
        updated += 1
      end
    end
    puts "#{updated} group permissions updated"
  end

  desc 'delete all imported Bitbucket data'
  task :drop => [:environment] do
    Group.destroy_all
    Member.destroy_all
    Repository.destroy_all
  end

  desc 'reloads all data from Bitbucket'
  task :reload => [:drop, :update_repos, :update_members, :update_groups, :update_member_perms, :update_group_perms]
  
end
