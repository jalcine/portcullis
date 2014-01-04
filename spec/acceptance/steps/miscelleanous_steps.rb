module MiscelleanousSteps
  step 'I see a :state message saying :message' do | state, message |
    within '.flash_gordon' do
      expect(page).to have_content(message)
    end
  end

  step "I click the :button button" do | button |
    click_button button.to_s
  end

  step "I click the :link link" do | link |
    click_link link.to_s
  end

  step "I don't see the text :content on the page" do | content |
    expect(page).to_not have_content(content)
  end

  step 'I see the text :content on the page' do | content |
    expect(page).to have_content(content)
  end
end

RSpec.configure { |c| c.include MiscelleanousSteps }
