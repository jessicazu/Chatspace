require 'rails_helper'

describe MessagesController do
  let(:user){ create(:user) }
  let(:group){ create(:group) }
  let(:message){ create(:message) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    before do
      get :index, group_id: group
    end

    it "assigns the requested current_groups to @groups" do
      groups = create_list(:group, 3)
      expect(assigns(:groups)).to match user.groups
    end

    it "assigns the requested group to @group" do
      expect(assigns(:group)).to eq group
    end

    it "assigns the requested messages to @messages" do
      messages = create_list(:message, 3)
      expect(assigns(:messages)).to match group.messages
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context "if message will save" do
      it "saves the message in the database" do
        expect{
          post :create, group_id: group, message: attributes_for(:message)
        }.to change(Message, :count).by(1)
      end
      it "renders the :index template" do
        get :index, group_id: group
        expect(response).to render_template :index
      end
    end

    context "if message will not save" do
      it "doesn't save the message in the database" do
        expect{
          post :create, group_id: group, message: attributes_for(:message, body: nil)
        }.to_not change(Message, :count)
      end
      it "renders the :index template" do
        get :index, group_id: group
        expect(response).to render_template :index
      end
    end
  end
end
