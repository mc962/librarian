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

FactoryBot.define do
  factory :example do
    command { Faker::TvShows::SiliconValley.invention }
    output { Faker::TvShows::SiliconValley.url }
    comment { Faker::TvShows::SiliconValley.quote }

    codelet
  end
end
