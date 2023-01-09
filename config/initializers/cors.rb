Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put], expose: ['access-token', 'uid', 'client'] # 追加
  end
end
