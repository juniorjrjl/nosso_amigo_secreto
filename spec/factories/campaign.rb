FactoryBot.define do

    factory :capaign do
        title { FFaker::Lorem.word}
        description { FFaker::Lorem.sentence}
        user
    end
    
end