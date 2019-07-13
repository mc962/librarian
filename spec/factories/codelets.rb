# frozen_string_literal: true

# == Schema Information
#
# Table name: codelets
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  slug                :string           not null
#  description         :text             not null
#  publicly_accessible :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryBot.define do
  factory :codelet do
    name { Faker::JapaneseMedia::OnePiece.unique.character }
    slug { Faker::JapaneseMedia::OnePiece.unique.character.parameterize }
    description { Faker::TvShows::DrWho.catch_phrase }
    publicly_accessible { Faker::Boolean.boolean }

    factory :codelet_with_examples do
      # examples_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        examples_count { 3 }
      end

      # the after(:create) yields two values; the codelet instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the codelet is associated properly to the example
      after(:create) do |codelet, evaluator|
        create_list(:example, evaluator.examples_count, codelet: codelet)
      end
    end
  end
end
