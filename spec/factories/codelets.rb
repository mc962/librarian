# == Schema Information
#
# Table name: codelets
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :codelet do
    name { "MyString" }
    slug { "MyString" }
    body { "MyText" }
  end
end
