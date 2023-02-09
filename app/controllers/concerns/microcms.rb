module Microcms
  extend ActiveSupport::Concern
  require 'httpclient'

  PAGE_LIMIT = 10.freeze

  def article_list(offset=nil, id=nil, draft_key=nil)
    client = HTTPClient.new
    response = client.get(
      "https://#{Rails.application.credentials.microcms[:domain]}.microcms.io/api/v1/blogs/#{id.present? ? id : ''}",
      header: { "X-MICROCMS-API-KEY": Rails.application.credentials.microcms[:key] },
      query: { draftKey: draft_key, offset: offset }
    )
    
    return nil unless response.status == 200

    JSON.parse(response.body, symbolize_names: true)
  end
end
