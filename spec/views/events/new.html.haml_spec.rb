require 'spec_helper'

describe 'events/new.html.haml' do
  before(:each) do
    view.stub(:user_signed_in?).and_return(true)
    assign :event, FactoryGirl.build(:event)
  end

  xit 'has the right title' do
    render template: 'events/new'
    puts rendered
    expect(page).to have_title 'Create Event - Vettio'
  end

  describe 'form' do
    describe 'existence' do
      it 'has the description field' do
        render
        expect(rendered).to match /Description/
        expect(rendered).to have_selector 'label[for=event_description]'
      end
      describe 'date/time' do
        it 'has the start field' do
          render
          expect(rendered).to match /Start/
          expect(rendered).to have_selector 'label[for=event_date_start]'
        end
        it 'has the end field' do
          render
          expect(rendered).to match /End/
          expect(rendered).to have_selector 'label[for=event_date_end]'
        end
      end
    end
  end
end
