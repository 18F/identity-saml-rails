require 'rails_helper'

describe 'Agency UI integration' do
  let(:agencies) { %w[ed irs sba state treasury uscis] }

  it 'has index page' do
    agencies.each do |agency|
      puts "GET #{agency}"
      get '/', params: { agency: agency }

      expect(response.status).to eq 200
    end
  end

  it 'responds with 404 when no such agency' do
    get '/', params: { agency: 'foobar' }

    expect(response.status).to eq 404
  end
end
