require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

NewsItem.blueprint do
  title          { "Post #{sn}" }
  author         { "Author #{sn}" }
  synopsis       { "Synopsis #{sn}" }
  created_at     { Time.now }
end

Member.blueprint do
  eligibility_clause     { "life_member" }
  payment_method         { "paypal" }
  given_name             { "John" }
  family_name            { "Smith" }
  gender                 { "Male" }
  email                  { "someone@somewhere.com" }
  date_of_birth          { "01/04/1990" }
  phone_number_mobile    { "0411 123 456" }
  phone_number_other     { "9600 1234" }
  amount_paid            { "110" }
end

Newsletter.blueprint do
  title          { "Dribbling Balls 2017 - Volume 30 edition #{sn}" }
  author         { "Author #{sn}" }
  synopsis       { "Synopsis #{sn}" }
  dribbling_balls_link { "https://s3.amazonaws.com/mubc/dribbling_balls/2017_04_24_volume_30_issue_002.pdf" }
  created_at     { Time.now }
end
