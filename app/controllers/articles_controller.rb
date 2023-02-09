class ArticlesController < ApplicationController
  include Microcms

  before_action :offset, only: :index

  def index
    @list = article_list(params[:offset])
  end

  def show
    @list = article_list(nil, params[:id], params[:draft_key])
  end

  private
    def offset
      @offset = params[:offset].to_i || 0
    end
end
