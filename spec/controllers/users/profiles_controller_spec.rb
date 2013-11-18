require 'spec_helper'

describe Users::ProfilesController do
  let(:user) { FactoryGirl.create :user }
  before(:each) { stub_env_for_devise user }
end
