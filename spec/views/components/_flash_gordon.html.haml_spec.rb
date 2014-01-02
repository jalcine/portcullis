require 'spec_helper'

describe 'components/_flash_gordon.html.haml' do
  describe 'displaying flash messages' do
    [:notice, :alert, :error].each do | flash_type |
      let(:message) { "This is a #{flash_type.to_s} message." }
      before(:each) do
        flash[flash_type] = message
        allow(view).to receive(:resource_name).and_return(:user)
        render 'components/flash_gordon', locals: { }
      end

      it { expect(rendered).to have_selector ".flash_gordon > .#{flash_type}" }
      it { expect(rendered).to have_content message }
    end
  end
end
