module SendgridClient
  class Contact

    def self.update(*args)
      @contact ||= new
      @contact.update(*args)
    end

    def self.delete(email)
      @contact ||= new
      @contact.delete(email)
    end

    def self.search(email)
      @contact ||= new
      @contact.search(email)
    end

    def update(params)
      params = params.is_a?(Array) ? params : [params]

      response = send_request(:patch, end_point, params.to_json)

      raise Errors::Contact, "#{response}" if error_in(response)
    end

    def delete(email)
      recipient_id = get_recipient_id_by(email)

      if recipient_id
        delete_url = "#{end_point}/#{recipient_id}"
        send_request(:delete, delete_url)
      end
    end

    def search(email)
      search_url = "#{end_point}/search"
      params = { params: { email: email } }

      send_request(:get, search_url, params)
    end

    private

    attr_reader :end_point

    def end_point
      @end_point ||= "https://#{SendgridClient.configuration.username}:#{SendgridClient.configuration.password}@api.sendgrid.com/v3/contactdb/recipients"
    end

    def error_in(response)
      return false unless response

      status = JSON.parse(response)

      status['error_count'] > 0
    end

    def get_recipient_id_by(email)
      response = JSON.parse(search(email))

      response['recipients'].first['id'] if response['recipients'].any?
    end

    def send_request(action, url, params = nil)
      RestClient.send(action, url, params) unless SendgridClient.configuration.test_mode
    end
  end
end
