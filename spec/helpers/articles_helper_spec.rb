require 'rails_helper'
require 'spec_helper'

RSpec.describe ArticlesHelper, type: :helper do
  describe 'pagination_num' do
    subject { helper.pagination_num(offset, content_length) }

    context 'コンテンツがない場合' do
      let!(:offset) { 0 }
      let!(:content_length) { 0 }

      it { is_expected.to eq [] }
    end

    context 'コンテンツが10ページより少ない場合' do
      let!(:offset) { 10 }
      let!(:content_length) { 10 }

      it { is_expected.to eq [1] }
    end

    context '現在のページが最初のページと同じ場合' do
      let!(:offset) { 10 }
      let!(:content_length) { 100 }

      it { is_expected.to eq [1,2,3,4,10] }
    end

    context '現在のページが最初のページから2ページ以内の場合' do
      let!(:offset) { 30 }
      let!(:content_length) { 100 }

      it { is_expected.to eq [1,2,3,4,5,6,10] }
    end

    context '現在のページが最後のページから2ページ以内の場合' do
      let!(:offset) { 80 }
      let!(:content_length) { 100 }

      it { is_expected.to eq [1,7,8,9,10] }
    end

    context '現在のページが最後のページと同じ場合' do
      let!(:offset) { 90 }
      let!(:content_length) { 100 }

      it { is_expected.to eq [1,8,9,10] }
    end

    context '現在のページが最後のページよりも更に多い数が指定された場合' do
      let!(:offset) { 200 }
      let!(:content_length) { 100 }

      it { is_expected.to eq [] }
    end

    context '現在のページが最後のページよりも少ない数が指定された場合' do
      let!(:offset) { -100 }
      let!(:content_length) { 100 }

      it { is_expected.to eq [1,2,3,10] }
    end
  end
end