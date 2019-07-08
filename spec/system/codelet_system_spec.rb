require "rails_helper"

RSpec.describe "Codelet management", :type => :system do
    before do
        driven_by :selenium, using: :headless_chrome
    end

    it 'enables me to create codelets' do
        visit new_codelet_path
    end
end
