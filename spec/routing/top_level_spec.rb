require 'spec_helper'

describe 'top level page routes' do
  it 'routes / to the landing redirector' do
    expect(get: '/').to be_routable
    expect(get: '/').to route_to(
      controller: 'home',
      action: 'landing'
    )
  end

  it 'routes /about to the about page' do
    expect(get: '/about').to be_routable
    expect(get: '/about').to route_to(
      controller: 'home',
      action: 'about'
    )
  end
end
