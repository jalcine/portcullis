ActionDispatch::Callbacks.after do
  return unless Rails.env.test?

  unless FactoryGirl.factories.blank? # first init will load factories,
    FactoryGirl.factories.clear
    FactoryGirl.find_definitions
  end
end
