# coding: utf-8
business_divisions = [
  {:code => "0", :name => "指定なし"},
  {:code => "1", :name => "第1種(卸売業)"},
  {:code => "3", :name => "第2種(小売業)"},
  {:code => "4", :name => "第3種(製造業)"},
  {:code => "5", :name => "第4種(その他)"},
  {:code => "6", :name => "第5種(サービス業)"}
]

business_divisions.each do |c|
  unless BusinessDivision.find_by(code: c[:code])
    puts "business_divisions: #{c[:code]}"
    BusinessDivision.create(c)
  end
end

state_codes = [
	{:code => 10, :division => 1, :bill => "手許" ,:ebill => "発生", :factoring => "手許", :cash_payment => "通知"},
	{:code => 11, :division => 2, :bill => "振出", :ebill => "発生", :factoring => "振出", :cash_payment => "通知"},
	{:code => 20, :division => 1, :bill => "裏書", :ebill => "譲渡", :factoring => "譲渡"},
	{:code => 30, :division => 1, :bill => "割引", :ebill => "割引", :factoring => "割引"},
	{:code => 40, :division => 1, :bill => "自社てん末", :ebill => "自社てん末"},
	{:code => 90, :division => 1, :bill => "返却", :ebill => "取消", :factoring => "組戻", :cash_payment => "組戻"},
        {:code => 50, :division => 1, :bill => "決済", :ebill => "決済", :factoring => "決済", :cash_payment => "決済"}, 
	{:code => 91, :division => 2, :bill => "返却", :ebill => "取消", :factoring => "組戻", :cash_payment => "組戻"},
	{:code => 93, :division => 1, :bill => "不渡", :ebill => "不渡"}
]

state_codes.each do |c|
  unless StateCode.find_by(code: c[:code])
    puts "state_code: #{c[:code]}"
    StateCode.create(c)
  end
end

if TaxRate.count == 0
  puts "税率作成"
  TaxRate.create([
    {code: "1", name: "標準", rate: "0", executed_on: "17530101", used: true}, 
    {code: "103", name: "3%固定", rate: "3", executed_on: "19890401", used: false}, 
    {code: "105", name: "5%固定", rate: "5", executed_on: "19970401", used: true}, 
    {code: "108", name: "8%固定", rate: "8", executed_on: "20140401", used: true}, 
    {code: "110", name: "10%固定", rate: "10", executed_on: "20151001", used: false}
  ])
end

if AnalysisDivision.count == 0
  puts "拡張補助区分作成"
  AnalysisDivision.create([
    {:name => "拡張補助1", :abbreviation => "拡張①", :used => false},
    {:name => "拡張補助2", :abbreviation => "拡張②", :used => false},
    {:name => "拡張補助3", :abbreviation => "拡張③", :used => false},
    {:name => "拡張補助4", :abbreviation => "拡張④", :used => false},
    {:name => "拡張補助5", :abbreviation => "拡張⑤", :used => false},
    {:name => "拡張補助6", :abbreviation => "拡張⑥", :used => false},
    {:name => "拡張補助7", :abbreviation => "拡張⑦", :used => false},
    {:name => "拡張補助8", :abbreviation => "拡張⑧", :used => false},
    {:name => "拡張補助9", :abbreviation => "拡張⑨", :used => false},
    {:name => "拡張補助10", :abbreviation => "拡張⑩", :used => false}
])
end
