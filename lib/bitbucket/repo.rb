require 'time'

module Bitbucket
  
  # see also https://github.com/intridea/hashie
  class Repo

    def initialize(data)
      @data = data
    end

    def method_missing(name, *args, &block)
      @data[name.to_s]
    end

    def full_name
      @data['full_name']
    end

    def name
      @data['name']
    end

    def slug
      full_name.split('/')[1]
    end

    def owner_username
      @data['owner']['username']
    end

    def ssh_url
      @data['links']['clone'].find { |h| h['name'] == 'ssh' }['href']
    end

    def http_url
      @data['links']['clone'].find { |h| h['name'] == 'https' }['href']
    end

    def updated_on
      Time.iso8601(@data['updated_on'])
    end

    def created_on
      Time.iso8601(@data['created_on'])
    end

    def has_wiki
      @data['has_wiki']
    end

    def has_issues
      @data['has_issues']
    end
    
  end
  
end
