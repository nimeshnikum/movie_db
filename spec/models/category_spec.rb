require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:movies) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
  end

end
