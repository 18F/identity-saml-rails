require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'with the ial param set to 1' do
      it 'renders a link for an ial 1 sign in' do
        get :index, params: { ial: '1' }

        expect(response.body).to include('/auth/saml?ial=1')
      end
    end

    context 'with the ial param set to 2' do
      it 'renders a link for an ial 1 sign in' do
        get :index, params: { ial: '2' }

        expect(response.body).to include('/auth/saml?ial=2')
      end
    end

    context 'with the ial param nil' do
      it 'renders a link for an ial 1 sign in' do
        get :index, params: { ial: '1' }

        expect(response.body).to include('/auth/saml?ial=1')
      end
    end
  end
end
