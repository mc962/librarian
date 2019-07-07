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

    validates :name, :slug, :description, presence: true

    def self.library_codelets
       Codelet.where(publicly_accessible: true) 
    end
end
