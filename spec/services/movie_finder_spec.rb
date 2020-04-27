require 'rails_helper'

RSpec.describe MovieFinder, type: :service do
  let(:user) { create(:user) }

  describe '#initialize' do
    context 'initializes instance variables with args sent' do
      #TODO
    end
  end

  describe '#get' do
    context 'without any params' do
      #TODO
    end

    context '#filter_by_search' do
      #TODO
    end

    context '#filter_by_categories' do
      #TODO
    end

    context '#filter_by_ratings' do
      #TODO
    end

    context '#build_category_groups' do
      #TODO
    end

    context '#build_rating_groups' do
      #TODO
    end
  end
end
