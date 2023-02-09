class ArticlesController < ApplicationController
  include Microcms
  include Pagy::Backend

  def index
    @list = article_list
  end

  def show
    @list = article_list(params[:id], params[:draft_key])
  end
end
