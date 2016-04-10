require 'json'
require 'open-uri'
class ContacterApi
  def initialize(host)
    @host = host
  end

  def get_user_contacts(id)
    parse "#{@host}/users/#{id}/contacts.json"
  end

  def get_contact(id)
    parse "#{@host}/contacts/#{id}.json"
  end

  private
    def parse(url)
      JSON.parse(open(url).read)
    end

end
