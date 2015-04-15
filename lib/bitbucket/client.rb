require 'rest_client'
require 'json'
require 'hashie/mash'

module Bitbucket
  
  BB_API1_BASE = "https://bitbucket.org/api/1.0"
  BB_API2_BASE = "https://bitbucket.org/api/2.0"

  class Client
    def initialize(user, pass)
      @user = user
      @pass = pass
    end

    def get(url)
      resource = RestClient::Resource.new(url, @user, @pass)
      resource.get
    end

    def put(url, payload)
      resource = RestClient::Resource.new(url, @user, @pass)
      resource.put(payload)
    end

    def get_repos(url)
      return [] unless url
      
      repo_text = get(url)
      obj = JSON.parse(repo_text)
      next_url = obj['next']
      obj['values'].map { |r| Repo.new(r) } + get_repos(next_url)
    end

    def repos
      get_repos("#{BB_API2_BASE}/repositories/#{@user}?pagelen=20")
    end

    def get_members(url)
      return [] unless url

      text = get(url)
      obj = JSON.parse(text)
      next_url = obj['next']
      obj['values'].map { |o| Hashie::Mash.new(o) } + get_members(next_url)
    end

    def members
      get_members("#{BB_API2_BASE}/teams/#{@user}/members")
    end

    def groups
      group_text = get("#{BB_API1_BASE}/groups/#{@user}")
      obj = JSON.parse(group_text)
      # obj.map { |g| Group.new(g) }
      obj.map { |g| Hashie::Mash.new(g) }
    end

    def privs
      repo_text = get("#{BB_API1_BASE}/privileges/#{@user}")
      obj = JSON.parse(repo_text)
      obj.map { |r| Hashie::Mash.new(r) }
    end

    # this takes the "full name", i.e. user + slug
    def group_privs_for_repo(repo)
      repo_text = get("#{BB_API1_BASE}/group-privileges/#{repo}")
      obj = JSON.parse(repo_text)
      obj.map { |r| Hashie::Mash.new(r) }
    end

    # this takes the slug only
    def hooks_for_repo(repo_slug)
      hook_text = get("#{BB_API1_BASE}/repositories/#{@user}/#{repo_slug}/services")
      obj = JSON.parse(hook_text)
      obj.map { |h| Hashie::Mash.new(h) }
    end

    def set_hook_url(repo_slug, hook_id, url)
      text = put("#{BB_API1_BASE}/repositories/#{@user}/#{repo_slug}/services/#{hook_id}", "URL=#{url}")
      obj = JSON.parse(text)
      Hashie::Mash.new(obj)
    end
  end

end
