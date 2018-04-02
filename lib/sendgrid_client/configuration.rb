module SendgridClient
  class Configuration
    attr_writer :username, :password, :test_mode

    def initialize
      @username = nil
      @password = nil
      @test_mode = false
    end

    def username
      raise Errors::Configuration, 'please configure username' unless @username
      @username
    end

    def password
      raise Errors::Configuration, 'please configure password' unless @password
      @password
    end

    def test_mode
      @test_mode
    end
  end
end
