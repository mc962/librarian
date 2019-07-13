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

class Example < ApplicationRecord
    belongs_to :codelet

    validates :command, presence: true
    validates_length_of :command, maximum: 500
    validates_length_of :output, maximum: 500
    validates_length_of :comment, maximum: 1000

    def publicly_accessible?
        codelet.publicly_accessible?
    end
end
