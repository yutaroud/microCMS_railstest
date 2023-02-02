module Microcms
  extend ActiveSupport::Concern
  require 'httpclient'

  def article_list    
    client = HTTPClient.new
    response = client.get(
      "https://#{Rails.application.credentials.microcms[:domain]}.microcms.io/api/v1/blogs/",
      header: { "X-MICROCMS-API-KEY": Rails.application.credentials.microcms[:key] }
    )
    
    return nil unless response.status == 200

    JSON.parse(response.body, symbolize_names: true)
  end
end
