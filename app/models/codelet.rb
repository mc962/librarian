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

class Codelet < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :history

  has_many :examples

  validates :name, :slug, :description, presence: true
  validates :name, :slug, uniqueness: true
  validates_length_of :name, maximum: 500
  validates_length_of :description, maximum: 750

  scope :library, -> { where(publicly_accessible: true) }

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
