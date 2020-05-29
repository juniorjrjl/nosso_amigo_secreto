require 'rails_helper'

describe RaffleService do
    
    before :each do
        @campaign = create(:campaign, status: peding)
    end

    describe "#call" do
        
        context "when has more then two members" do

            before(:each) do
                create(:member, campaign: @campaign)    
                create(:member, campaign: @campaign)    
                create(:member, campaign: @campaign)    
                @campaign.reload

                @results = RaffleService.new(@campaign).call
            end

            it "result is hash" do
                expect(@result.class).to eq(Hash)
            end

            it "all members are in result as a member" do
                result_members = @result.map {|r| r.first}
                expect(result_members.sort).to eq(@campaign.members.sort)
            end

            it "all members are in result as a friend " do
                result_friends = @result.map {|r| r.last}
                expect(result_friends.sort).to eq(@campaign.members.sort)
            end

            it "a member don't get yourself" do
                @result.each do |r|
                    expect(r.first).not_to eq(r.last)
                end
            end

            it "a member x don't get a member y that get a member z" do
                #TODO desafio
            end

        end

        context "when don't has more then two members" do
            
            before(:each) do
                create(:member, campaign: @campaign)
                @campaign.reload

                @response = RaffleService.new(@campaign).call
            end

            it "return false" do
                expect(@response).to eq(false)
            end

        end

    end
end