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

require 'rails_helper'

RSpec.describe Codelet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
