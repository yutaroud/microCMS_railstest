require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe '記事の一覧表示が可能か' do
    it '記事一覧を表示する' do
      get '/'
      expect(response.status).to eq 200
    end
  end
end
