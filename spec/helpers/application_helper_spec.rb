require 'spec_helper'

describe ApplicationHelper do
  describe '#is_in_beta?' do
    it 'determines beta state' do
      allow(Settings.toggles).to receive(:in_beta).and_return(true)
      expect(helper.is_in_beta?).to eql(true)
    end
  end

  describe '#page_title' do
    it 'obtains default page title' do
      expect(helper.page_title).to_not be_empty
    end

    it 'sets page title' do
      helper.page_title 'Cupcake'
      expect(helper.page_title).to eql('Cupcake - Vettio')
    end
  end

  describe '#page_classes' do
    before(:each) do
      params = {
        controller: Faker::Name.first_name.downcase,
        action: Faker::Name.first_name.downcase
      }
    end

    it 'helps with setting page classes' do
      expect(helper.page_classes(params)).to be_eql("#{params[:controller]} #{params[:action]} ")
    end

    it 'fixes funky controller names for page classes' do
      extra_params = {
        controller: "#{Faker::Name.first_name}/#{Faker::Name.last_name}-#{Faker::Name.first_name}",
        action: "#{Faker::Name.first_name}/#{Faker::Name.last_name}-#{Faker::Name.first_name}"
      }

      lethal_classes = "#{extra_params[:controller]} #{extra_params[:action]}"
      lethal_classes = lethal_classes.gsub('/', '_')
      lethal_classes = lethal_classes.gsub('-','_')
      lethal_classes = lethal_classes.downcase
      fzs = helper.page_classes(extra_params)
      expect(fzs).to be_eql("#{lethal_classes} ")
    end
  end
end
