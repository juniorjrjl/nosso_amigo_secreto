class ErrorNotifyMailer < ApplicationMailer

    def notify_owner(campaign)
        @campaign = campaign
        mail to: @campaign.user.email, subject: "Tivemos um problema no sorteio da campanha #{@campaign.title} :("
    end

end
