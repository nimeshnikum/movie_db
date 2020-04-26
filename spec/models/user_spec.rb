require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:ratings) }
    it { is_expected.to have_many(:movies) }
  end

  context 'validations' do
    #TODO
  end
end
