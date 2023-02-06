class ArticlesController < ApplicationController
  include Microcms

  def index
    @list = article_list
  end

  def show
    @list = article_list(params[:id], params[:draft_key])
  end
end
