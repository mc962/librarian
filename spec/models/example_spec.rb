# == Schema Information
#
# Table name: examples
#
#  id         :bigint           not null, primary key
#  command    :text             not null
#  output     :text
#  comment    :text
#  codelet_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Example, type: :model do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:command) }
    end

    context 'length' do 
      it { should validate_length_of(:command).is_at_most(500) }
      it { should validate_length_of(:output).is_at_most(500) }
      it { should validate_length_of(:comment).is_at_most(1000) }
    end
  end

  describe 'associations' do
    it { should belong_to(:codelet) }
  end

  describe 'publicly accessible examples' do
    it 'should only have public examples if codelet is public' do
      publicly_accessible_codelet = create(:codelet_with_examples, publicly_accessible: true)
      publicly_inaccessible_codelet = create(:codelet_with_examples, publicly_accessible: false)
  
      expect(publicly_accessible_codelet.examples.all?(&:publicly_accessible?)).to be true
      expect(publicly_inaccessible_codelet.examples.all?(&:publicly_accessible?)).to be false
    end
  end
end
