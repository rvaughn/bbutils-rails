require 'bitbucket/client'
require 'bitbucket/repo'
require 'bitbucket/group'

module Bitbucket

  class << self
    
    def new(user, pass)
      Bitbucket::Client.new(user, pass)
    end

  end

end
