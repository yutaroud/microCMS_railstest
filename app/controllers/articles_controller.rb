class ArticlesController < ApplicationController
  include Microcms
  def index
    @list = article_list
  end
end
