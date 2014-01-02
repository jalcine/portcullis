module MiscelleanousSteps
  step 'I see a :message_status message saying :message' do | state, message |
    expect(page.find(".flash_gordon > .#{state}")).to have_content(message)
  end

  step "I click the :button button" do | button |
    click_button button
  end

  step "I click the :link link" do | link |
    click_link link
  end

  step "I don't see the text :content on the page" do | content |
    expect(page).to_not have_content(content)
  end

  step 'I see the text :content on the page' do | content |
    expect(page).to have_content(content)
  end

  placeholder :message_status do
    match /(success|info|warning|error)/ do | state |
      state
    end
  end
end

RSpec.configure { |c| c.include MiscelleanousSteps }
