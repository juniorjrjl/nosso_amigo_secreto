require 'rails_helper'

RSpec.describe CampaignRaffleJob, type: :job do
  
  let(:raffle_service) { instance_double(RaffleService) }

  before :each do
    ActiveJob::Base.queue_adapter = :test
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
    @campaign = create(:campaign)
    @members = create_list(:member, 4, campaign: @campaign)
    members_raffled = { @members[0] => @members[1], @members[1] => @members[2], @members[2] => @members[3], @members[3] => @members[0] }
    allow_any_instance_of(RaffleService).to receive(:call).and_return(members_raffled)
    allow_any_instance_of(CampaignMailer).to receive(:raffle)
    CampaignRaffleJob.perform_later(@campaign)
  end

  describe "#perform" do

    it "check if all members hava a pixel" do
      expect(Member.where(campaign_id: @campaign.id, token: nil).count).to eq(0)
    end

    it "check if the campaign is finished" do
      expect(Campaign.last.status).to eq("finished")
    end

  end

end
