class ApiService
  def initialize
    @conn = Faraday.new("http://localhost:3000/") do |faraday|
      faraday.adapter(Faraday.default_adapter)
      faraday.basic_auth(ENV[API_LOGIN], ENV[API_PASS])
    end
  end

end
