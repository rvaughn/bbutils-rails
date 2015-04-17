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

    def get_and_parse(url)
      text = get(url)
      obj = JSON.parse(text)
      Hashie::Mash.new(obj)
    end

    def get_and_map(url)
      text = get(url)
      list = JSON.parse(text)
      list.map { |o| Hashie::Mash.new(o) }
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
      get_and_map("#{BB_API1_BASE}/groups/#{@user}")
    end

    def privs
      get_and_map("#{BB_API1_BASE}/privileges/#{@user}")
    end

    def group_privs(group_slug)
      get_and_map("#{BB_API1_BASE}/group-privileges/#{@user}/#{@user}/#{group_slug}")
    end

    def group_privs_for_repo(username, repo_slug)
      get_and_map("#{BB_API1_BASE}/group-privileges/#{username}/#{repo_slug}")
    end

    # this takes the slug only
    def hooks_for_repo(repo_slug)
      get_and_map("#{BB_API1_BASE}/repositories/#{@user}/#{repo_slug}/services")
    end

    def set_hook_url(repo_slug, hook_id, url)
      get_and_parse("#{BB_API1_BASE}/repositories/#{@user}/#{repo_slug}/services/#{hook_id}", "URL=#{url}")
    end
  end

end
