module OrderSteps
  step 'I see the price of the final transaction' do
    within '.order' do
      expect(page).to have_content 'Total Price:'
    end
  end
end

RSpec.configure { | c | c.include OrderSteps }
