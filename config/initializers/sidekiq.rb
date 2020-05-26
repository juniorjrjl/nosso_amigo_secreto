Sidekiq.configure_server do | c |
    c.redis = { url: 'redis://redis:6379/0'}
end

Sidekiq.configure_client do | c |
    c.redis = { url: 'redis://redis:6379/0'}
end