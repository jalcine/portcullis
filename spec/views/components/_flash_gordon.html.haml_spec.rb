require 'spec_helper'

describe 'components/_flash_gordon.html.haml' do
  describe 'displaying flash messages' do
    [:notice, :alert, :error].each do | flash_type |
      before(:each) do
        flash[flash_type] = "This is a #{flash_type.to_s}."
        allow(view).to receive(:resource_name).and_return(:user)
        render template: 'layouts/application', locals: { }
      end

      it { expect(rendered).to have_selector 'body header.main[role=contentinfo] > .flash_gordon' }
      it { expect(rendered).to have_selector "body header.main[role=contentinfo] > .flash_gordon > .#{flash_type}" }
      it { expect(rendered).to match /This is a / }
      it { expect(rendered).to match flash_type.to_s }
    end
  end
end
