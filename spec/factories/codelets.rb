# frozen_string_literal: true

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

FactoryBot.define do
  factory :codelet do
    name { Faker::JapaneseMedia::OnePiece.unique.character }
    slug { Faker::JapaneseMedia::OnePiece.unique.character.parameterize }
    description { Faker::TvShows::DrWho.catch_phrase }
    examples { Faker::TvShows::DrWho.quote }
    publicly_accessible { Faker::Boolean.boolean }
  end
end
