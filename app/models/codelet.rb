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

class Codelet < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :history

    validates :name, :slug, :description, presence: true
end
