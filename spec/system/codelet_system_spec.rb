require 'rails_helper'

RSpec.describe 'Codelet management', type: :system do
  before do
    driven_by :selenium, using: :headless_chrome
  end

  it 'creates new codelets' do
    visit new_codelet_path

    codelet_name = Faker::Ancient.unique.god
    codelet_description = Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote
    codelet_examples = Faker::ChuckNorris.fact

    # attempt to unsuccessfully create a new codelet
    within('#new_codelet') do
      fill_in 'Name', with: codelet_name
      click_button 'Create Codelet'
    end

    # expect front-end validations to prevent form from submitting without required field
    expect(page.has_content?('Please describe the code')).to be true

    # successfully create a new codelet
    within('#new_codelet') do
      fill_in 'Describe the Code', with: codelet_description
      fill_in 'Examples', with: codelet_examples

      check 'codelet_publicly_accessible'

      click_button 'Create Codelet'
    end

    # expect redirected to codelet show path, with successful flash
    assert page.has_content? 'Codelet successfully created'
  end

  it 'updates codelets' do
    codelet = FactoryBot.create(:codelet)

    visit edit_codelet_path(codelet.name.parameterize)
    # attempt to unsuccessfully update a new codelet
    within("#edit_codelet_#{codelet.id}") do
      fill_in 'Name', with: ''
      click_button 'Update Codelet'
    end

    # expect front-end validations to prevent form from submitting without required field
    expect(page.has_content?('Please describe the code')).to be true

    # successfully update a codelet
    codelet_updated_description = Faker::Movies::StarWars.quote
    within("#edit_codelet_#{codelet.id}") do
      fill_in 'Name', with: codelet.name
      fill_in 'Describe the Code', with: codelet_updated_description
      click_button 'Update Codelet'
    end

    # should be redirected to codelet #show path
    expect(page.current_path == codelet_path(codelet.name.parameterize)).to be true
    # codelet should display updated content
    assert page.has_content? 'Codelet successfully updated'
  end

  it 'deletes codelets' do
    codelet = FactoryBot.create(:codelet)

    visit codelet_path(codelet.name.parameterize)
    # attempt to unsuccessfully delete a codelet
    page.dismiss_confirm 'Do you want to DELETE this codelet?' do
      click_on 'Delete Codelet'
    end

    # codelet should still exist after rejecting confirm alert
    expect(Codelet.exists?(codelet.slug)).to be true

    # successfully delete a codelet
    page.accept_confirm 'Do you want to DELETE this codelet?' do
      click_on 'Delete Codelet'
    end

    # expect to be redirected to codelet #index path
    expect(page.current_path).to eq(codelets_path)

    # expect codelet to no longer exist
    expect { Codelet.find(codelet.slug) }.to raise_error(ActiveRecord::RecordNotFound)

    # codelet should display updated content
    assert page.has_content? 'Codelet successfully deleted'
  end
end
