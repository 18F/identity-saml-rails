require 'rails_helper'

describe 'Agency UI integration' do
  let(:agencies) { %w(uscis ed sba) }

  it 'has index page' do
    agencies.each do |agency|
      puts "GET #{agency}"
      get '/', agency: agency

      expect(response.status).to eq 200
    end
  end

  it 'responds with 404 when no such agency' do
    get '/', agency: 'foobar'

    expect(response.status).to eq 404
  end
end
