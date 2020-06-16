require 'rails_helper'

RSpec.describe MembersController, type: :controller do
    include Devise::Test::ControllerHelpers

    before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @current_user = FactoryBot.create(:user)
        sign_in @current_user
        @campaign = create(:campaign, user: @current_user)
    end

    describe "POST #create" do
        
        before(:each) do
            @member_attributes = attributes_for(:member, campaign: @campaign) 
            member_body = {member: {name: @member_attributes[:name], email: @member_attributes[:email], campaign_id: @campaign.id}}
            post :create, params: member_body, format: :json
        end

        it "member was included at campaign" do
            expect(Member.last.campaign).to eq(@campaign)
        end

        it "member was created" do
            expect(Member.last.name).to eq(@member_attributes[:name])
            expect(Member.last.email).to eq(@member_attributes[:email])
            expect(Member.last.open).not_to eq(true)
            expect(Member.last.id).to be >= 0
        end

    end

    describe "PUT #update" do

        before(:each) do
            @member = create(:member, campaign: @campaign)
            @member_attributes = attributes_for(:member, campaign: @campaign)
            member_body = {id: @member.id, member: {name: @member_attributes[:name], email: @member_attributes[:email]}}
            put :update, params: member_body, format: :json
        end

        it "returns http success" do
            expect(response).to have_http_status(:success)
        end

        it "member was updated" do
            expect(Member.last.name).to eq(@member_attributes[:name])
            expect(Member.last.email).to eq(@member_attributes[:email])
        end

    end

    describe "DELETE #destroy" do

        before(:each) do
            @member = create(:member, campaign: @campaign)
            delete :destroy, params: {id: @member.id}, format: :json
        end

        it "returns http success" do
            expect(response).to have_http_status(:success)
        end

        it "member was deleted" do
            expect(Member.find_by_id(@member.id)).to eq(nil)
        end

    end

    describe "GET #opened" do
        
        before(:each) do
            @member = create(:member, campaign: @campaign)
            @member.set_pixel
            headers = { "ACCEPT" => "*/*" }
            get :opened, params: {token: @member.token}, format: :text
            #corrigir chamada desse teste
        end

        it "member opened e-mail" do
            expect(Member.last.open).to eq(true)
        end

    end

end