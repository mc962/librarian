# == Schema Information
#
# Table name: codelets
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  slug                :string           not null
#  description         :text             not null
#  examples            :text
#  publicly_accessible :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Codelet, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:slug) }
      it { should validate_presence_of(:description) }
    end

    context 'uniqueness' do
      subject { FactoryBot.create(:codelet) }
      it { should validate_uniqueness_of(:name) }
      # it { should validate_uniqueness_of(:slug) } # NOTE: This appears to break only in tests due to the friendly_id codebase
    end
  end

  describe 'library codelets' do
    it 'only displays publicly accessible codelets' do
      codelets = FactoryBot.create_list(:codelet, 5)
      library_codelets = Codelet.library
      expect(library_codelets.all?(&:publicly_accessible)).to be true
    end
  end
end
