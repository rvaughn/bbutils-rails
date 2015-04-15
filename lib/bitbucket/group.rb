module Bitbucket
  
  # see also https://github.com/intridea/hashie
  class Group

    def initialize(data)
      @data = data
    end

    def method_missing(name, *args, &block)
      @data[name.to_s]
    end
    
  end
  
end
