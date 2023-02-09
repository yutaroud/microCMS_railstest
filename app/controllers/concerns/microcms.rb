module Microcms
  extend ActiveSupport::Concern
  require 'httpclient'

  PAGE_LIMIT = 10.freeze
  CMS_API_PATH = "https://#{Rails.application.credentials.microcms[:domain]}.microcms.io/api/v1/blogs/"

  def article_list(offset=nil)
    client = HTTPClient.new
    response = client.get(CMS_API_PATH, header: cms_header, query: list_query)

    return raise StandardError.new("リクエストが失敗しました。#{response.body}") unless response.status == 200

    JSON.parse(response.body, symbolize_names: true)
  end

  def article_show(id, draft_key=nil)
    client = HTTPClient.new
    response = client.get("#{CMS_API_PATH}#{id}", header: cms_header, query: show_query(draft_key))
    
    return raise StandardError.new("リクエストが失敗しました。#{response.body}") unless response.status == 200

    JSON.parse(response.body, symbolize_names: true)
  end

  private
    def cms_header
      { "X-MICROCMS-API-KEY": Rails.application.credentials.microcms[:key] }
    end

    def list_query
      { offset: offset }
    end

    def show_query(draft_key)
      { draftKey: draft_key }
    end
end
