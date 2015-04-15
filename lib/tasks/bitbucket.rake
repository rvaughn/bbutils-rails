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
      added = 0
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
          added += 1
          updated -= 1
        end
        
        record.desc = r.description
        record.created_at = r.created_on
        record.updated_at = r.updated_on
        updated += 1
        record.save!
      end
      puts "#{updated} repositories updated"
      puts "#{added} repositories added"
    ensure
      ActiveRecord::Base.record_timestamps = true
    end
  end
  
  desc 'update member data from Bitbucket'
  task :update_members => [:environment] do
    ## TODO: make this delete removed members
    begin
      ActiveRecord::Base.record_timestamps = true
      bb = Bitbucket::Client.new(Rails.application.secrets.bitbucket_username, Rails.application.secrets.bitbucket_password)
      updated = 0
      added = 0
      bb.members.each do |m|
        record = Member.find_or_initialize_by(username: m.username) do |record|
          record.username = m.username
          added += 1
          updated -= 1
        end
      
        record.name = m.display_name
        updated += 1
        record.save!
      end
      puts "#{updated} members updated"
      puts "#{added} members added"
    ensure
      ActiveRecord::Base.record_timestamps = true
    end
  end
  
  desc 'update group data from Bitbucket'
  task :update_groups => [:environment] do
    ## TODO: make this delete removed members
    begin
      ActiveRecord::Base.record_timestamps = true
      bb = Bitbucket::Client.new(Rails.application.secrets.bitbucket_username, Rails.application.secrets.bitbucket_password)
      updated = 0
      added = 0
      bb.groups.each do |g|
        record = Group.find_or_initialize_by(slug: g.slug) do |record|
          record.slug = g.slug
          record.name = g.name
          added += 1
          updated -= 1
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
      puts "#{added} groups added"
    ensure
      ActiveRecord::Base.record_timestamps = true
    end
  end

end
