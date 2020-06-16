class CampaignRaffleJob < ApplicationJob
  queue_as :emails

  def perform(campaign)
    begin
      results = RaffleService.new(campaign).call
      raise StandardError if results == false

      campaign.members.each {|m| m.set_pixel}
      results.each do |r|
        CampaignMailer.raffle(campaign, r.first, r.last).deliver_now
      end
      campaign.update(status: :finished)
    rescue
      ErrorNotifyMailer.notify_owner(campaign).deliver_now
    end

  end
end
