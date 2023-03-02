Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:8080','https://saison-app.vercel.app', 'http://localhost:8081'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete], expose: ['access-token', 'uid', 'client'] # 追加
  end
end
