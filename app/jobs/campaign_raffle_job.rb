class CampaignRaffleJob < ApplicationJob
  queue_as :emails

  def perform(campaign)
    results = RaffleService.new(campaign).call

    campaign.members.each {|m| m.set_pixel}
    result.each do |r|
      CampaignMailer.raffle(campaign, r.first, r.last).delivery_now
    end
    campaign.update(status: :finished)

    #TODO fazer envio de email notificando sobre problemas    

  end
end
