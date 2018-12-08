# coding: utf-8

if Administrator.count == 0
  puts "管理ユーザ作成"
  user = Administrator.new do |u|
    u.name = "管理者"
    u.email = "admin@example.jp"
    u.password = "password1234"
    u.password_confirmation = "password1234"
  end
  user.save!
end


state_codes = [
	{:code => 10, :division => 1, :bill => "手許" ,:ebill => "発生", :factoring => "手許", :cash_payment => "通知"},
	{:code => 11, :division => 2, :bill => "振出", :ebill => "発生", :factoring => "振出", :cash_payment => "通知"},
	{:code => 20, :division => 1, :bill => "裏書", :ebill => "譲渡", :factoring => "譲渡"},
	{:code => 30, :division => 1, :bill => "割引", :ebill => "割引", :factoring => "割引"},
	{:code => 40, :division => 1, :bill => "自社てん末", :ebill => "自社てん末"},
	{:code => 90, :division => 1, :bill => "返却", :ebill => "取消", :factoring => "組戻", :cash_payment => "組戻"},
	{:code => 91, :division => 2, :bill => "返却", :ebill => "取消", :factoring => "組戻", :cash_payment => "組戻"},
	{:code => 93, :division => 1, :bill => "不渡", :ebill => "不渡"}
]

state_codes.each do |c|
  unless StateCode.find_by(code: c[:code])
    puts "state_code: #{c[:code]}"
    StateCode.create(c)
  end
end
