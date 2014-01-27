require 'spec_helper'

describe 'events/show' do
  let(:event) { create(:event) }
  before(:each) do
    view.stub(:user_signed_in?).and_return(true)
    assign :event, event
  end

  describe 'attributes' do
    before(:each) { render }
    it { expect(rendered).to have_content(event.name) }
    it { expect(rendered).to have_content(event.description) }
  end
end
