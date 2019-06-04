require 'rails_helper'

describe 'Default SP landing page' do
  context '/' do
    it 'has an index page' do
      get '/'

      expect(response.status).to eq 200
    end

    it 'underlines IAL1 link by default' do
      get '/'

      expect(response.body).to include(
        '<a href="?ial=1"><span class="text-underline">IAL1</span></a>'
      )
      expect(response.body).to include(
        '<a href="?ial=2"><span class="">IAL2</span></a>'
      )
    end

    it 'underlines IAL1 link when IAL1 is selected' do
      get '/?ial=1'

      expect(response.body).to include(
        '<a href="?ial=1"><span class="text-underline">IAL1</span></a>'
      )
      expect(response.body).to include(
        '<a href="?ial=2"><span class="">IAL2</span></a>'
      )
    end

    it 'underlines IAL2 link when IAL2 is selected' do
      get '/?ial=2'

      expect(response.body).to include(
        '<a href="?ial=2"><span class="text-underline">IAL2</span></a>'
      )
      expect(response.body).to include(
        '<a href="?ial=1"><span class="">IAL1</span></a>'
      )
    end
  end
end
