require 'spec_helper'

describe Event do
  subject { FactoryGirl.create :event }
  it { expect(subject).to have(:no).errors_on(:name) }
  it { expect(subject).to have(:no).errors_on(:description) }
  it { expect(subject).to have(:no).errors_on(:user) }
  it { expect(subject).to have(:no).errors_on(:date_start) }
  it { expect(subject).to have(:no).errors_on(:date_end) }
end
