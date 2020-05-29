class CampaignRaffleJob < ApplicationJob
  queue_as :emails

  def perform(campaign)
    results = RaffleService.new(campaign).call
  end
end
