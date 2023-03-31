# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

names = ['山田太郎', '鈴木次郎', '佐藤三郎', '高橋四郎', '田中五郎']

names.each_with_index do |name, i|
  User.create!(
    email: "test_user#{i + 1}@example.com",
    name: name,
    password: "password",
    password_confirmation: "password",
    uid: "test_user#{i + 1}@example.com",
    provider: "email",
    confirmed_at: DateTime.now
  )
end

# タイトルと本文を配列で定義
post_titles = ['タイトル1', 'タイトル2', 'タイトル3', 'タイトル4', 'タイトル5']
post_bodies = ['本文1', '本文2', '本文3', '本文4', '本文5']
image_urls = ['https://res.cloudinary.com/dxn30zcfs/image/upload/v1673108558/saison/p755ymn1dnufmepwsk7u.jpg', 'https://res.cloudinary.com/dxn30zcfs/image/upload/v1673108558/saison/p755ymn1dnufmepwsk7u.jpg', 'https://res.cloudinary.com/dxn30zcfs/image/upload/v1673108558/saison/p755ymn1dnufmepwsk7u.jpg', 'https://res.cloudinary.com/dxn30zcfs/image/upload/v1673108558/saison/p755ymn1dnufmepwsk7u.jpg', 'https://res.cloudinary.com/dxn30zcfs/image/upload/v1673108558/saison/p755ymn1dnufmepwsk7u.jpg']

# 5人のユーザーがそれぞれ1つずつ投稿する
User.all.each_with_index do |user, i|
  post = user.posts.create!(
    title: post_titles[i],
    body: post_bodies[i]
  )

  # イメージデータを各投稿に追加
  post.images.create!(
    url: image_urls[i]
  )
end
