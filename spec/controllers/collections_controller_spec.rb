# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe CollectionsController, type: :controller do
  let(:valid_attributes) do
    FactoryBot.attributes_for(:collection)
  end

  let(:invalid_attributes) do
    {title: ''}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CollectionsController. Be sure to keep this updated too.
  let(:valid_session) do
    {user_id: user.id}
  end

  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:collection) { create(:collection, valid_attributes.merge(users: [user])) }

    it 'assigns all collections as @collections' do
      get :index, params: {}, session: valid_session
      expect(assigns(:collections)).to include collection
    end
  end

  describe 'GET #show' do
    let(:collection) { create(:collection, valid_attributes) }

    it 'assigns the requested collection as @collection' do
      get :show, params: {id: collection.to_param}, session: valid_session
      expect(assigns(:collection)).to eq(collection)
    end
  end

  describe 'GET #new' do
    it 'assigns a new collection as @collection' do
      get :new, params: {}, session: valid_session
      expect(assigns(:collection)).to be_a_new(Collection)
    end
  end

  describe 'GET #edit' do
    let(:collection) { create(:collection, valid_attributes.merge(users: [user])) }

    it 'assigns the requested collection as @collection' do
      get :edit, params: {id: collection.to_param}, session: valid_session
      expect(assigns(:collection)).to eq(collection)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Collection' do
        expect do
          post :create, params: {collection: valid_attributes}, session: valid_session
        end.to change(Collection, :count).by(1)
      end

      it 'assigns a newly created collection as @collection' do
        post :create, params: {collection: valid_attributes}, session: valid_session
        expect(assigns(:collection)).to be_a(Collection)
        expect(assigns(:collection)).to be_persisted
      end

      it 'redirects to the created collection' do
        post :create, params: {collection: valid_attributes}, session: valid_session
        expect(response).to redirect_to(collections_path)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved collection as @collection' do
        post :create, params: {collection: invalid_attributes}, session: valid_session
        expect(assigns(:collection)).to be_a_new(Collection)
      end

      it "re-renders the 'new' template" do
        post :create, params: {collection: invalid_attributes}, session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    let(:collection) { create(:collection, valid_attributes.merge(users: [user])) }

    context 'with valid params' do
      let(:new_attributes) do
        {title: 'new title'}
      end

      it 'updates the requested collection' do
        expect do
          put :update, params: {id: collection.to_param, collection: new_attributes}, session: valid_session
        end.to change { collection.reload.title }.to('new title')
      end

      it 'assigns the requested collection as @collection' do
        put :update, params: {id: collection.to_param, collection: valid_attributes}, session: valid_session
        expect(assigns(:collection)).to eq(collection)
      end

      it 'redirects to the collection' do
        put :update, params: {id: collection.to_param, collection: valid_attributes}, session: valid_session
        expect(response).to redirect_to(collections_path)
      end
    end

    context 'with invalid params' do
      it 'assigns the collection as @collection' do
        put :update, params: {id: collection.to_param, collection: invalid_attributes}, session: valid_session
        expect(assigns(:collection)).to eq(collection)
      end

      it "re-renders the 'edit' template" do
        put :update, params: {id: collection.to_param, collection: invalid_attributes}, session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:collection) { create(:collection, valid_attributes.merge(users: [user])) }

    it 'destroys the requested collection' do
      expect do
        delete :destroy, params: {id: collection.to_param}, session: valid_session
      end.to change(Collection, :count).by(-1)
    end

    it 'redirects to the collections list' do
      delete :destroy, params: {id: collection.to_param}, session: valid_session
      expect(response).to redirect_to(collections_url)
    end
  end
end
