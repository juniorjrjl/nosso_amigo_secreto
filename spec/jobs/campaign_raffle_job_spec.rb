require 'rails_helper'

RSpec.describe CampaignRaffleJob, type: :job do
  
  before :each do
    @campaign = create(:campaign)
    @members = create_list(:member, 8, campaign: @campaign)
    #CampaignRaffleJob.new.perform(@campaign)
    #expect(CampaignMailer).to receive(:raffle).and_call_original
  end

  it "check if all members hava a pixel" do
    expect(Member.count).to eq(Member.where.not(token: nil).count)
  end

  it "check if the campaign is finished" do
    expect(Campaign.last.status).to eq(:finished)
  end

end
