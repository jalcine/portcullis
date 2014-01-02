module MiscelleanousSteps
  step 'I should see an error' do
    flash_gordon = find '#flash_gordon'
    expect(flash_gordon.first('.warning')).to be_nil
  end

  step 'I should see a message indicating :message' do | message |
    within '#flash_gordon' do
      expect(page).to_not have_content(message)
    end
  end

  step "I click on the :button button" do | button |
    click_button button
  end

  step "I click on the :link link" do | link |
    click_link link
  end

  step 'I should not see the text :content on the page' do | content |
    expect(page).to_not have_content(content)
  end

  step 'I should see the text :content on the page' do | content |
    expect(page).to have_content(content)
  end
end

RSpec.configure { |c| c.include MiscelleanousSteps }
