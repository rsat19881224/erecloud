# coding: utf-8

if Administrator.count == 0
  puts "管理ユーザ作成"
  Administrator.create([
    {:name => "管理者", :email => "admin@example.jp", :administrator_type => Administrator.administrator_type.union_admin , :password => "password1234", :password_confirmation => "password1234"},
    {:name => "Ope池角", :email => "mikesu@tatujin.co.jp", :administrator_type => Administrator.administrator_type.union_admin , :password => "mikesu1234", :password_confirmation => "mikesu1234"},
    {:name => "Dev佐藤", :email => "rsato@tatujin.co.jp", :administrator_type => Administrator.administrator_type.union_admin , :password => "rsato1234", :password_confirmation => "rsato1234"}
  ])
end

if BusinessDivision.count == 0
  puts '事業区分作成'
  BusinessDivision.create([
    {:code => "0", :name => "指定なし"},
    {:code => "1", :name => "第1種(卸売業)"},
    {:code => "2", :name => "第2種(小売業)"},
    {:code => "3", :name => "第3種(製造業)"},
    {:code => "4", :name => "第4種(その他)"},
    {:code => "5", :name => "第5種(サービス業)"},
    {:code => "6", :name => "第6種(不動産業)"}
  ])
end

if StateCode.count == 0
  puts "顛末作成"
  StateCode.create([
    {:code => 10, :division => 1, :bill => "手許",:ebill => "発生", :factoring => "手許", :cash_payment => "通知"},
    {:code => 11, :division => 2, :bill => "振出", :ebill => "発生", :factoring => "振出", :cash_payment => "通知"},
    {:code => 12, :division => 1, :bill => "取立"},
    {:code => 13, :division => 1, :bill => "担保"},
    {:code => 20, :division => 1, :bill => "裏書", :ebill => "譲渡", :factoring => "譲渡"},
    {:code => 30, :division => 1, :bill => "割引", :ebill => "割引", :factoring => "割引"},
    {:code => 40, :division => 1, :bill => "自社てん末", :ebill => "自社てん末"},
    {:code => 50, :division => 1, :bill => "決済", :ebill => "決済", :factoring => "決済", :cash_payment => "決済"},
    {:code => 52, :division => 1, :bill => "決済", ebill: "決済(譲渡)"},
    {:code => 53, :division => 1, :bill => "決済", ebill: "決済(割引)"},
    {:code => 55, :division => 1, :bill => "決済", :ebill => "決済", :factoring => "決済", :cash_payment => "決済"},
    {:code => 90, :division => 1, :bill => "返却", :ebill => "取消", :factoring => "組戻", :cash_payment => "組戻"},
    {:code => 91, :division => 2, :bill => "返却", :ebill => "取消", :factoring => "組戻", :cash_payment => "組戻"},
    {:code => 93, :division => 1, :bill => "不渡", :ebill => "不渡"}
  ])
end

if ManagementDivision.count == 0
  puts "管理区分作成"
  ManagementDivision.create([
    {:code => "1", :name => "UNION管理"},
    {:code => "0", :name => "その他"}
  ])
end

if Company.count == 0
  puts "契約企業作成"
  Company.create([
    {:management_division_id => 1, :number => 1509000, :affiliated => 0, :demanded => false, :name => "ユニオンソフト商事株式会社", :postal_code => "853-8154", :address => "長崎県長崎市住吉町3-18", :tel => "095-848-7778", :fax => "095-813-0035"},
    {:management_division_id => 1, :number => 1509001, :affiliated => 0, :demanded => false, :name => "ユニオン商事株式会社", :postal_code => "853-8154", :address => "長崎県長崎市住吉町3-18", :tel => "095-848-7778", :fax => "095-813-0035"}
  ])
end

if User.count == 0
  puts "一般ユーザー作成"
  User.create([
    {:company_id => 1, :code => 1, :name => "admin" , :password => "password1234", :email => "admin@sample.jp", :contact_mail => "admin@sample.jp", :user_type => User.user_type.user_admin, :password_unlimited => false, :next_login_time_password_changed => false, :locked => false},
    {:company_id => 2, :code => 1, :name => "mikesu" , :password => "mikesu1234", :email => "mikesu@tatujin.co.jp", :contact_mail => "mikesu@tatujin.co.jp", :user_type => User.user_type.user_admin, :password_unlimited => false, :next_login_time_password_changed => false, :locked => false}
  ])
end

if Menu.count == 0
  puts "メニュー作成"
  Menu.create([
    {code: 0, name: "製品登録",               manager_division: "system_admin",  product_category: "system",            approval_setting_used: false, extend_type: "no_extend"},
    {code: 1, name: "メニュー管理",           manager_division: "system_admin",  product_category: "system",            approval_setting_used: false, extend_type: "no_extend"},
    {code: 2, name: "取引先登録",             manager_division: "general",       product_category: "common",            approval_setting_used: false, extend_type: "no_extend"},
    {code: 3, name: "部門登録",               manager_division: "general",       product_category: "common",            approval_setting_used: false, extend_type: "no_extend"},
    {code: 4, name: "運用設定",               manager_division: "general",       product_category: "common",            approval_setting_used: true, extend_type: "no_extend"},
    {code: 5, name: "ユーザー登録",           manager_division: "admin",         product_category: "common",            approval_setting_used: true, extend_type: "no_extend"},
    {code: 6, name: "受取手形入力",           manager_division: "general",       product_category: "bill_credit",       approval_setting_used: true, extend_type: "no_extend"},
    {code: 7, name: "支払手形入力",           manager_division: "general",       product_category: "bill_debit",        approval_setting_used: true, extend_type: "no_extend"},
    {code: 8, name: "電子記録債権入力",       manager_division: "general",       product_category: "ebill_credit",      approval_setting_used: true, extend_type: "no_extend"},
    {code: 9, name: "電子記録債務入力",       manager_division: "general",       product_category: "ebill_debit",       approval_setting_used: true, extend_type: "no_extend"},
    {code: 10, name: "ファクタリング債権入力", manager_division: "general",       product_category: "factoring_credit",  approval_setting_used: true, extend_type: "no_extend"},
    {code: 11, name: "ファクタリング債務入力", manager_division: "general",       product_category: "factoring_debit",   approval_setting_used: true, extend_type: "no_extend"},
    {code: 12, name: "売掛金入力",             manager_division: "general",       product_category: "account_receivable", approval_setting_used: true, extend_type: "no_extend"},
    {code: 13, name: "買掛金入力",             manager_division: "general",       product_category: "account_payable",   approval_setting_used: true, extend_type: "no_extend"}
  ])
end

if Product.count == 0
  puts "製品作成"
  Product.create([
    {code: "150000", name: "債権債務の達人クラウド体験版", ebill_credit_used: true, ebill_debit_used: true},
    {code: "150001", name: "債権債務の達人クラウド", bill_credit_used: true, bill_debit_used: true, ebill_credit_used: true, ebill_debit_used: true,
     print_option_used: true},
    {code: "0", name: "手形", bill_credit_used: true, bill_debit_used: true},
    {code: "1", name: "電子記録債権", ebill_credit_used: true, ebill_debit_used: true},
    {code: "2", name: "ファクタリング", factoring_credit_used: true, factoring_debit_used: true},
    {code: "3", name: "フルパック", bill_credit_used: true, bill_debit_used: true, ebill_credit_used: true, ebill_debit_used: true,
     factoring_credit_used: true, factoring_debit_used: true, account_receivable_used: true, account_payable_used: true}
  ])
end

if License.count == 0
  company = Company.first
  now_time = Time.now
  licenses = [{company_id: company.id, product_id: Product.first.id, number_of_license: 3, use_starting_date: now_time, use_end_date: now_time+30, period_of_service: 30, license_type: License.license_type.trial},
              {company_id: company.id, product_id: Product.second.id, number_of_license: 3, use_starting_date: now_time+10, use_end_date: now_time+20, period_of_service: 10, license_type: License.license_type.demo},
              {company_id: company.id, product_id: Product.third.id, number_of_license: 3, use_starting_date: now_time, use_end_date: now_time+60, period_of_service: 60, license_type: License.license_type.operation}]
  licenses.each do |sd|
    l = License.create(sd)
    ApprovalSettingsController.create_approval_setting(l.company_id, Product.find_by_id(l.product_id))
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

if RecordingInstitution.count == 0
  puts "電子債権記録機関作成"
  RecordingInstitution.create([
                                {code: "0000", name: "株式会社全銀電子債権ネットワーク", abbreviation: "でんさい（全銀電子債権ネットワーク）", recording_number_digit: 20, user_number_digit: 9},
                                {code: "0005", name: "日本電子債権機構株式会社", abbreviation: "電手（日本電子債権機構）", recording_number_digit: 13, user_number_digit: 7},
                                {code: "0001", name: "みずほ電子債権記録株式会社", abbreviation: "電ペイ（みずほ電子債権記録）", recording_number_digit: 20, user_number_digit: 9},
                                {code: "0009", name: "SMBC電子債権記録株式会社", abbreviation: "SMBC電債権記録", recording_number_digit: 20, user_number_digit: 9}
  ])
end

if CompanyBank.count == 0
  puts "会社銀行作成"
  company = Company.first
  CompanyBank.create([
    {company_id: company.id, code: "001", name: "みずほ銀行東京営業部", bank_code: "0001", bank_name: "みずほ銀行", bank_kana: "ﾐｽﾞﾎ", branch_code: "001",
      branch_name: "東京営業部", branch_kana: "ﾄｳｷﾖｳ", account_type: 1, account_number: "1000001", account_name_kana: "ﾃｽﾄ", client_code: "2000000002"},
    {company_id: company.id, code: "0000000100", name: "ＡＢＣ銀行千葉支店（当座）2000100", bank_code: "0008", bank_name: "ＡＢＣ銀行", bank_kana: "ｴｰﾋﾞｰｼｰ",
      branch_code: "004", branch_name: "千葉支店", branch_kana: "ﾁﾊﾞ", account_type: 2, account_number: "1000002", account_name_kana: "ﾕﾆｵﾝｼﾖｳｼﾞ(ｶ", client_code: "1000000001"},
    {company_id: company.id, code: "005", name: "三菱東京UFJ銀行本店", bank_code: "0005", bank_name: "三菱東京ＵＦＪ銀行", bank_kana: "ﾐﾂﾋﾞｼﾄｳｷﾖｳUFJ",
      branch_code: "001", branch_name: "本店", branch_kana: "ﾎﾝﾃﾝ", account_type: 9, account_number: "2222222", account_name_kana: "ﾕﾆｵﾝｼﾖｳｼﾞ(ｶ", client_code: "1000000001"}
  ])
end

module CsvFormat
  ISBANK = '1'
  ISBRANCH = '2'
end

if Bank.count == 0 && Branch.count == 0
  puts "銀行作成 銀行支店作成"
  require "csv"

  CSV
    .foreach('db/ginkositen.txt', encoding: "Shift_JIS:UTF-8")
    .map {|bank_code, branch_code, kana, name, bank_or_branch|
    {
      code: bank_code,
      branch_code: branch_code,
      name: name,
      kana: kana,
      isbank: bank_or_branch == CsvFormat::ISBANK
    }
  }
    .group_by{|h| h[:code]}
    .each do |_, one_bank|
    bank = one_bank
           .find{|h| h[:isbank] }
           .slice(:code, :name, :kana)

    bank_branch = one_bank.select{|h| !h[:isbank]}.map do |branch|
      branch
        .tap{|h| h[:code] = h[:branch_code]}
        .slice(:code, :name, :kana)
    end

    Bank.create(bank)
      .branchs
      .build(bank_branch)
      .each(&:save)
  end
end

if Trader.count == 0
  puts "取引先作成"
  company = Company.first
  Trader.create([
    {company_id: company.id, code: 1,  name1: "太平洋販売株式会社",     kana: "ﾀｲﾍｲﾖｳﾊﾝﾊﾞｲｶﾌﾞｼｷｶﾞｲｼﾔ",    short_name: "太平洋販売株式会社"   },
    {company_id: company.id, code: 2,  name1: "株式会社岩手産業",       kana: "ｶﾌﾞｼｷｶﾞｲｼﾔｲﾜﾃｻﾝｷﾞﾖｳ",     short_name: "株式会社岩手産業"     },
    {company_id: company.id, code: 3,  name1: "株式会社茨城電機",       kana: "ｶﾌﾞｼｷｶﾞｲｼﾔｲﾊﾞﾗｷﾃﾞﾝｷ",     short_name: "株式会社茨城電機"     },
    {company_id: company.id, code: 4,  name1: "群馬事務機株式会社",     kana: "ｸﾞﾝﾏｼﾞﾑｷｶﾌﾞｼｷｶﾞｲｼﾔ",       short_name: "群馬事務機株式会社"   },
    {company_id: company.id, code: 5,  name1: "埼玉商事株式会社",       kana: "ｻｲﾀﾏｼﾖｳｼﾞｶﾌﾞｼｷｶﾞｲｼﾔ",      short_name: "埼玉商事株式会社"     },
    {company_id: company.id, code: 6,  name1: "株式会社千葉デンキ",     kana: "ｶﾌﾞｼｷｶﾞｲｼﾔﾁﾊﾞﾃﾞﾝｷ",       short_name: "株式会社千葉デンキ"   },
    {company_id: company.id, code: 7,  name1: "東京事務機販売株式会社", kana: "ﾄｳｷﾖｳｼﾞﾑｷﾊﾝﾊﾞｲｶﾌﾞｼｷｶﾞｲｼﾔ", short_name: "東京事務機販売株式会社"},
    {company_id: company.id, code: 8,  name1: "神奈川物産株式会社",     kana: "ｶﾅｶﾞﾜﾌﾞﾂｻﾝｶﾌﾞｼｷｶﾞｲｼﾔ",   short_name: "神奈川物産株式会社"   },
    {company_id: company.id, code: 9,  name1: "新潟工業株式会社",       kana: "ﾆｲｶﾞﾀｺｳｷﾞﾖｳｶﾌﾞｼｷｶﾞｲｼﾔ",  short_name: "新潟工業株式会社"     },
    {company_id: company.id, code: 10, name1: "石川販売株式会社",       kana: "ｲｼｶﾜﾊﾝﾊﾞｲｶﾌﾞｼｷｶﾞｲｼﾔ",    short_name: "石川販売株式会社"     }
  ])
end

if TraderBankAccount.count == 0
  puts "取引先銀行作成"
  Trader.all.each do |trader|
    bank = Bank.all.sample
    branch = Branch.search(bank_id_eq: bank.id).result.sample
    TraderBankAccount.create(
      trader_id: trader.id,
      bank_code: bank.code,
      bank_name: bank.name,
      bank_kana: bank.kana,
      branch_code: branch.code,
      branch_name: branch.name,
      branch_kana: branch.kana
    )
  end
end

if Department.count == 0
  puts "部門作成"
  company = Company.first
  Department.create([
    {company_id: company.id, code: "100", name: "第一営業部", name_kana: "ﾀﾞｲｲﾁｴｷﾞｮｳﾌﾞ", abbreviation: "第一"},
    {company_id: company.id, code: "200", name: "第二営業部", name_kana: "ﾀﾞｲﾆｴｲｷﾞｮﾌﾞ",  abbreviation: "第二"},
    {company_id: company.id, code: 3, name: "札幌支店",  name_kana: "サッポロ",          abbreviation: "札幌支店"},
    {company_id: company.id, code: "300", name: "関西支店",  name_kana: "ｶﾝｻｲｼﾃﾝ",          abbreviation: "関西"},
    {company_id: company.id, code: "400", name: "九州支店",  name_kana: "ｷｭｳｼｭｳｼﾃﾝ",          abbreviation: "九州"},
    {company_id: company.id, code: "900", name: "共通"}
  ])
end

if Remark.count == 0
  puts "備考作成"
  company = Company.first
  Remark.create([
    {company_id: company.id, code: 1, content: "売掛金入金"},
    {company_id: company.id, code: 2, content: "未収金入金"},
    {company_id: company.id, code: 3, content: "買掛金支払"},
    {company_id: company.id, code: 4, content: "未払金支払"}
  ])
end

if Account.count == 0
  puts "勘定科目作成"
  company = Company.first
  Account.create([
    {company_id: company.id, code: "110", name: "当座預金", tax_division_id: 1, tax_display: 2, tax_rate_id: 4, round: 1, business_division_id: 1, fund_division: 1, 
      tax_subject_division: 1, trader_shared: 1, department_input: 1, trader_input_division: 1, analysis1_input: 0, analysis2_input: 0, analysis3_input: 0, analysis4_input: 0, 
      analysis5_input: 0, analysis6_input: 0, analysis7_input: 0, analysis8_input: 0, analysis9_input: 0, analysis10_input: 0},
    {company_id: company.id, code: "111", name: "普通預金", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "1", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "130", name: "受取手形", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "1", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "131", name: "電子記録債権", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "132", name: "取立手形", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "133", name: "ファクタリング債権", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "134", name: "期日現金（債権）", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "135", name: "売掛金", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "136", name: "担保手形", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "182", name: "仮払消費税", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "300", name: "支払手形", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "301", name: "電子記録債務", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "305", name: "買掛金", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "2", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "306", name: "割引手形", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "307", name: "裏書手形", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "308", name: "ファクタリング債務", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "309", name: "期日現金（債務）", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "310", name: "割引電子記録債権", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "311", name: "譲渡電子記録債権", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "330", name: "仮受消費税", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "2", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "753", name: "支払手数料", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "2", trader_shared: "1", department_input: "3", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "832", name: "手形売却損", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "2", trader_shared: "1", department_input: "3", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "841", name: "電子記録債権売却損", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "2", trader_shared: "1", department_input: "3", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "900", name: "諸口", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"},
    {company_id: company.id, code: "901", name: "資金諸口", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1", fund_division: "1", 
      tax_subject_division: "1", trader_shared: "1", department_input: "1", trader_input_division: "1", analysis1_input: "0", analysis2_input: "0", analysis3_input: "0", analysis4_input: "0", 
      analysis5_input: "0", analysis6_input: "0", analysis7_input: "0", analysis8_input: "0", analysis9_input: "0", analysis10_input: "0"}  
  ])
end

if SubAccount.count == 0
  puts "補助科目作成"
  SubAccount.create([
    {account_id: 1, code: "001", name: "みずほ銀行丸の内支店", kana: "ﾐｽﾞﾎﾏﾙﾉｳﾁ", tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1"},
    {account_id: 1, code: "002", name: "三菱東京UFJ銀行本店", kana: "ﾐﾂﾋﾞｼ",    tax_division_id: "1", tax_rate_id: "4", tax_display: "2", round: "1", business_division_id: "1"}
  ])
end

if AnalysisDivision.count == 0
  puts "拡張補助区分作成"
  company = Company.first
  AnalysisDivision.create([
    {company_id: company.id, name: "銀行",  abbreviation: "銀行",  used: "0", input_division: "3", division_no: "1"},
    {company_id: company.id, name: "取引先", abbreviation: "取引先", used: "0", input_division: "2", division_no: "2"},
    {company_id: company.id, name: "拡張補助3", abbreviation: "拡張補助3", used: "0", input_division: "2", division_no: "3"},
    {company_id: company.id, name: "拡張補助4", abbreviation: "拡張補助4", used: "0", input_division: "4", division_no: "4"},
    {company_id: company.id, name: "拡張補助5", abbreviation: "拡張補助5", used: "0", input_division: "5", division_no: "5"},
    {company_id: company.id, name: "拡張補助6", abbreviation: "拡張補助6", used: "0", input_division: "2", division_no: "6"},
    {company_id: company.id, name: "拡張補助7", abbreviation: "拡張補助7", used: "0", input_division: "1", division_no: "7"},
    {company_id: company.id, name: "拡張補助8", abbreviation: "拡張補助8", used: "0", input_division: "1", division_no: "8"},
    {company_id: company.id, name: "拡張補助9", abbreviation: "拡張補助9", used: "0", input_division: "2", division_no: "9"},
    {company_id: company.id, name: "拡張補助10", abbreviation: "拡張補助10", used: "0", input_division: "3", division_no: "10"}
])
end

if AnalysisItem.count == 0
  puts "拡張補助マスター作成"
  AnalysisItem.create([
    {analysis_division_id: "1", code: "001",  name: "みずほ銀行丸の内支店",  kana: "ﾐｽﾞﾎ", abbreviation: "みずほ丸の内"},
    {analysis_division_id: "1", code: "005",  name: "三菱東京UFJ銀行本店",  kana: "ﾐﾂﾋﾞｼ", abbreviation: "三菱東京本店"},
    {analysis_division_id: "1", code: "008",  name: "ABC銀行千葉支店",  kana: "ｴｰﾋﾞｰｼｰ", abbreviation: "ABC千葉"},
    {analysis_division_id: "2", code: "001",  name: "太平洋販売株式会社",  kana: "ﾀｲ", abbreviation: "太平洋販売(株)"},
    {analysis_division_id: "2", code: "002",  name: "株式会社岩手産業",  kana: "ｲﾜ", abbreviation: "(株)岩手産業"},
    {analysis_division_id: "2", code: "003",  name: "株式会社茨城電機",  kana: "ｲﾊﾞ", abbreviation: "(株)茨城電機"}
])
end

if OperatingDivision.count == 0
  puts "拡張伝票区分作成"
  company = Company.first
  OperatingDivision.create([
    {company_id: company.id, name: "事業部",  abbreviation: "事業部",  used: "1", input_division: "4", division_no: "1"},
    {company_id: company.id, name: "事業部2",  abbreviation: "事業部2",  used: "0", input_division: "2", division_no: "2"},
    {company_id: company.id, name: "事業部3",  abbreviation: "事業部3",  used: "0", input_division: "1", division_no: "3"},
    {company_id: company.id, name: "事業部4",  abbreviation: "事業部4",  used: "0", input_division: "4", division_no: "4"},
    {company_id: company.id, name: "事業部5",  abbreviation: "事業部5",  used: "1", input_division: "4", division_no: "5"}
])
end

if OperatingItem.count == 0
  puts "拡張伝票マスター作成"
  OperatingItem.create([
    {operating_division_id: "1", code: "001",  name: "関東事業部",  kana: "ｶﾝﾄｳ", abbreviation: "関東"},
    {operating_division_id: "1", code: "002",  name: "関西事業部",  kana: "ｶﾝｻｲ", abbreviation: "関西"},
    {operating_division_id: "1", code: "003",  name: "九州事業部",  kana: "ｷｭｳｼｭｳ", abbreviation: "九州"}
])
end

if SlipDivision.count == 0
  puts "伝票区分作成"
  company = Company.first
  SlipDivision.create([
    {company_id: company.id, code: "30",  name: "達人"}
])
end

if TaxDivision.count == 0
  puts "税区分作成"
  TaxDivision.create([
    {code: "0", name: "対象外", indication_name: "対象外", taxed: "0"},
    {code: "1", name: "非課税仕入", indication_name: "非課税", taxed: "0"},
    {code: "2", name: "不課税仕入", indication_name: "不課税", taxed: "0"},
    {code: "3", name: "不課税売上", indication_name: "不課売", taxed: "0"},
    {code: "10", name: "課税売上分課税仕入", indication_name: "課仕入", taxed: "1"},
    {code: "11", name: "非課税売上分課税仕入", indication_name: "非仕入", taxed: "1"},
    {code: "12", name: "共通売上分課税仕入", indication_name: "共仕入", taxed: "1"},
    {code: "60", name: "課税売上", indication_name: "課売上", taxed: "1"},
    {code: "80", name: "非課税売上", indication_name: "非売上", taxed: "0"}
  ])
end

if SummaryDetailsSetting.count == 0
  puts "摘要詳細設定作成"
  company = Company.first
  SummaryDetailsSetting.create([
    {company_id: company.id, rbill_summary_making: "4",  pbill_summary_making: "4", ebill_receivable_summary_making: "4", ebill_summary_making: "4", 
      date_payment_summary_making: "4", added_to_due_date: "0"}
])
end

if JournalizingOutputItem.count == 0
  puts "仕訳出力項目作成"
  JournalizingOutputItem.create([
    {code: "101", name: "出力項目タイトル", name_for_indication: "出力項目タイトル", item_division: "1"},
    {code: "102", name: "会社コード",  name_for_indication: "会社コード",  item_division: "1"},
    {code: "103", name: "起票者コード",  name_for_indication: "起票者コード",  item_division: "1"},
    {code: "104", name: "承認者コード",  name_for_indication: "承認者コード",  item_division: "1"},
    {code: "105", name: "伝票区切",  name_for_indication: "伝票区切",  item_division: "1"},
    {code: "106", name: "伝票区分",  name_for_indication: "伝票区分",  item_division: "1"},
    {code: "107", name: "拡張伝票区分1",  name_for_indication: "拡張伝票区分1",  item_division: "1"},
    {code: "108", name: "拡張伝票区分2",  name_for_indication: "拡張伝票区分2",  item_division: "1"},
    {code: "109", name: "拡張伝票区分3",  name_for_indication: "拡張伝票区分3",  item_division: "1"},
    {code: "110", name: "拡張伝票区分4",  name_for_indication: "拡張伝票区分4",  item_division: "1"},
    {code: "111", name: "拡張伝票区分5",  name_for_indication: "拡張伝票区分5",  item_division: "1"},
    {code: "112", name: "伝票日付",  name_for_indication: "伝票日付",  item_division: "1"},
    {code: "113", name: "伝票No",  name_for_indication: "伝票No",  item_division: "1"},
    {code: "114", name: "行No",  name_for_indication: "行No",  item_division: "1"},
    {code: "115", name: "伝票単位固定値1",  name_for_indication: "伝票単位固定値1",  item_division: "1"},
    {code: "116", name: "伝票単位固定値2",  name_for_indication: "伝票単位固定値2",  item_division: "1"},
    {code: "117", name: "伝票単位固定値3",  name_for_indication: "伝票単位固定値3",  item_division: "1"},
    {code: "201", name: "借方部門コード",  name_for_indication: "借方・貸方部門コード",  item_division: "2"},
    {code: "202", name: "借方勘定科目コード", name_for_indication: "借方・貸方勘定科目コード",  item_division: "2"},
    {code: "203", name: "借方補助科目コード", name_for_indication: "借方・貸方部門コード",  item_division: "2"},
    {code: "204", name: "借方取引先コード",  name_for_indication: "借方・貸方取引先コード",  item_division: "2"},
    {code: "205", name: "借方拡張補助１コード", name_for_indication: "借方・貸方拡張補助科目１コード",  item_division: "2"},
    {code: "206", name: "借方拡張補助２コード", name_for_indication: "借方・貸方拡張補助科目２コード", item_division: "2"},
    {code: "207", name: "借方拡張補助３コード", name_for_indication: "借方・貸方拡張補助科目３コード", item_division: "2"},
    {code: "208", name: "借方拡張補助４コード", name_for_indication: "借方・貸方拡張補助科目４コード", item_division: "2"},
    {code: "209", name: "借方拡張補助５コード", name_for_indication: "借方・貸方拡張補助科目５コード", item_division: "2"},
    {code: "210", name: "借方拡張補助６コード", name_for_indication: "借方・貸方拡張補助科目６コード", item_division: "2"},
    {code: "211", name: "借方拡張補助７コード", name_for_indication: "借方・貸方拡張補助科目７コード", item_division: "2"},
    {code: "212", name: "借方拡張補助８コード", name_for_indication: "借方・貸方拡張補助科目８コード", item_division: "2"},
    {code: "213", name: "借方拡張補助９コード", name_for_indication: "借方・貸方拡張補助科目９コード", item_division: "2"},
    {code: "214", name: "借方拡張補助１０コード", name_for_indication: "借方・貸方拡張補助科目１０コード", item_division: "2"},
    {code: "215", name: "借方金額（税込）", name_for_indication: "借方・貸方金額（税込）", item_division: "2"},
    {code: "216", name: "借方金額（税抜）", name_for_indication: "借方・貸方金額（税抜）", item_division: "2"},
    {code: "217", name: "借方消費税", name_for_indication: "借方・貸方消費税", item_division: "2"},
    {code: "218", name: "借方税区分コード", name_for_indication: "借方・貸方税区分コード", item_division: "2"},
    {code: "219", name: "借方税率", name_for_indication: "借方・貸方税率", item_division: "2"},
    {code: "220", name: "借方摘要", name_for_indication: "借方・貸方摘要", item_division: "2"},
    {code: "251", name: "貸方部門コード", name_for_indication: "借方・貸方部門コード", item_division: "2"},
    {code: "252", name: "貸方勘定科目コード", name_for_indication: "借方・貸方勘定科目コード", item_division: "2"},
    {code: "253", name: "貸方補助科目コード", name_for_indication: "借方・貸方補助科目コード", item_division: "2"},
    {code: "254", name: "貸方取引先コード", name_for_indication: "借方・貸方取引先コード", item_division: "2"},
    {code: "255", name: "貸方拡張補助１コード", name_for_indication: "借方・貸方拡張補助科目１コード", item_division: "2"},
    {code: "256", name: "貸方拡張補助２コード", name_for_indication: "借方・貸方拡張補助科目２コード", item_division: "2"},
    {code: "257", name: "貸方拡張補助３コード", name_for_indication: "借方・貸方拡張補助科目３コード", item_division: "2"},
    {code: "258", name: "貸方拡張補助４コード", name_for_indication: "借方・貸方拡張補助科目４コード", item_division: "2"},
    {code: "259", name: "貸方拡張補助５コード", name_for_indication: "借方・貸方拡張補助科目５コード", item_division: "2"},
    {code: "260", name: "貸方拡張補助６コード", name_for_indication: "借方・貸方拡張補助科目６コード", item_division: "2"},
    {code: "261", name: "貸方拡張補助７コード", name_for_indication: "借方・貸方拡張補助科目７コード", item_division: "2"},
    {code: "262", name: "貸方拡張補助８コード", name_for_indication: "借方・貸方拡張補助科目８コード", item_division: "2"},
    {code: "263", name: "貸方拡張補助９コード", name_for_indication: "借方・貸方拡張補助科目９コード", item_division: "2"},
    {code: "264", name: "貸方拡張補助１０コード", name_for_indication: "借方・貸方拡張補助科目１０コード", item_division: "2"},
    {code: "265", name: "貸方金額（税込）", name_for_indication: "借方・貸方金額（税込）", item_division: "2"},
    {code: "266", name: "貸方金額（税抜）", name_for_indication: "借方・貸方金額（税抜）", item_division: "2"},
    {code: "267", name: "貸方消費税", name_for_indication: "借方・貸方消費税", item_division: "2"},
    {code: "268", name: "貸方税区分コード", name_for_indication: "借方・貸方税区分コード", item_division: "2"},
    {code: "269", name: "貸方税率", name_for_indication: "借方・貸方税率", item_division: "2"},
    {code: "270", name: "貸方摘要", name_for_indication: "借方・貸方摘要", item_division: "2"},
    {code: "301", name: "行単位摘要", name_for_indication: "行単位摘要", item_division: "3"},
    {code: "302", name: "備考", name_for_indication: "備考", item_division: "3"},
    {code: "303", name: "管理番号", name_for_indication: "管理番号", item_division: "3"},
    {code: "304", name: "手形期日/支払日付", name_for_indication: "手形期日/支払日付", item_division: "3"},
    {code: "305", name: "取引先コード", name_for_indication: "取引先コード", item_division: "3"},
    {code: "306", name: "取引先名称", name_for_indication: "取引先名称", item_division: "3"},
    {code: "307", name: "メモ１", name_for_indication: "メモ１", item_division: "3"},
    {code: "308", name: "メモ２", name_for_indication: "メモ２", item_division: "3"}
])
end

if TemplateHeader.count == 0
  puts "仕訳パターンヘッダー作成"
  TemplateHeader.create([
    {company_id: 1 , setting_type: 0 , item: 0 , division: 3 , state_code_id:  1 , slip_division_id: 1},
    {company_id: 1 , setting_type: 0 , item: 0 , division: 3 , state_code_id:  3 , slip_division_id: 1},
    {company_id: 1 , setting_type: 0 , item: 1 , division: 3 , trader_id:  1 , state_code_id:  1 , slip_division_id: 1},
    {company_id: 1 , setting_type: 0 , item: 1 , division: 3 , trader_id:  1 , state_code_id:  3 , slip_division_id: 1},
    {company_id: 1 , setting_type: 0 , item: 2 , division: 3 , company_bank_id:  1 , state_code_id:  4 , slip_division_id: 1},
    {company_id: 1 , setting_type: 0 , item: 2 , division: 3 , company_bank_id:  1 , state_code_id:  10  , slip_division_id: 1}
])
end

if TemplateDetail.count == 0
  puts "仕訳パターン作成"
  TemplateDetail.create([
    {template_header_id: 1 , line_number:  1 , balanced: 0 , account_id: 4},
    {template_header_id: 1 , line_number:  1 , balanced: 1 , account_id: 8},
    {template_header_id: 2 , line_number:  1 , balanced: 0 , account_id: 12},
    {template_header_id: 2 , line_number:  1 , balanced: 1 , account_id: 4},
    {template_header_id: 3 , line_number:  1 , balanced: 0 , account_id: 3 , analysis_account2_id: 4},
    {template_header_id: 3 , line_number:  1 , balanced: 1 , account_id: 8},
    {template_header_id: 4 , line_number:  1 , balanced: 0 , account_id: 12},
    {template_header_id: 4 , line_number:  1 , balanced: 1 , account_id: 10  , analysis_account2_id: 4},
    {template_header_id: 5 , line_number:  1 , balanced: 0 , department_id:  5 , account_id: 1 , sub_account_id: 1},
    {template_header_id: 5 , line_number:  1 , balanced: 1 , account_id: 4},
    {template_header_id: 5 , line_number:  2 , balanced: 0 , department_id:  5 , account_id: 21},
    {template_header_id: 5 , line_number:  3 , balanced: 0 , department_id:  5 , account_id: 19},
    {template_header_id: 6 , line_number:  1 , balanced: 0 , department_id:  5 , account_id: 2 , analysis_account1_id: 1},
    {template_header_id: 6 , line_number:  1 , balanced: 1 , account_id: 4},
    {template_header_id: 6 , line_number:  2 , balanced: 0 , department_id:  5 , account_id: 19}
])
end

if Ebill.count == 0
  puts "電子記録債権明細作成"
  Ebill.create([
    {company_id:  1 , company_division: 2 , data_type:  1 , settlement_type:  0 , recording_institution_id: 1 , recording_number: "00TY12000-001201-0000-0" , 
      accrual_type: 1 , transferred:  0 , occurred_on:  20150625  , due_become_on: 20150920  , issue_money:  3200000}
])
end

if EbillReceivableState.count == 0
  puts "電子記録債権てん末作成"
  EbillReceivableState.create([
    {ebill_id: 1 , recording_institution_id: 1 , recording_number: "00TY1200000120100000"  , state_code_id:  1 , acquisition_division: 1 , 
      trader_id:  1 , trader_kana:  "ﾀｲﾍｲﾖｳﾊﾝﾊﾞｲ(ｶ" , trader_bank_code: 525 , trader_bank_kana: "ﾋｶﾞｼﾆｯﾎﾟｵﾝ"  , trader_branch_code: 101 , trader_branch_kana: "ﾎﾝﾃﾝｴｲｷﾞｮｳﾌﾞ"  , 
      trader_account_type:  1 , trader_account_number:  2000001 , trader_user_number: "0000DN001" , transferred_on: 20150625  , occurred_on:  20150625  , 
      issue_money:  3200000   , amount_money: 3200000   , residual_money: 3200000   , number_of_times:  0   , matured_on: 20150920  , settled_on: 20150924  , 
      company_bank_id:  1 , department_id:  1 , operating_item_id:  1 , Journal_made: 0 , remarks1: "売掛金回収" , approver_type:  0 , approved: 2 , output: 0 , registered_at: 0},
    {ebill_id: 1 , recording_institution_id: 1 , recording_number: "00TY1200000120100000"  , state_code_id:  4 , acquisition_division: 1 , 
      transferred_on: 20150701  , issue_money:  3200000   , amount_money: 2000000   , residual_money: 1200000   , number_of_times:  1   , 
      discount_requested_on:  20150628  , matured_on: 20150920  , settled_on: 20150924  , company_bank_id:  1 , department_id:  1 , operating_item_id:  1 , 
      division_recording_number:  "00TY1200000120100013"  , discount_charge:  1200  , bank_transfer_fee:  540 , Journal_made: 0 , discount_guidance_issued: 0 , 
      approver_type:  0 , approved: 2 , output: 0 , registered_at:  0},
    {ebill_id: 1 , recording_institution_id: 1 , recording_number: "00TY1200000120100000"  , state_code_id:  9 , acquisition_division: 1 , 
      transferred_on: 20150924  , issue_money:  3200000   , amount_money: 1200000   , residual_money: 0   , number_of_times:  1   , matured_on: 20150920  , 
      settled_on: 20150924  , company_bank_id:  1 , department_id:  1 , operating_item_id:  1 , division_recording_number:  "00TY1200000120100013"  , 
      bank_transfer_fee:  540 , Journal_made: 0 , discount_guidance_issued: 0 , approver_type:  0 , approved: 2 , output: 0 , registered_at:  0}
])
end

if SectionBreakdown.count == 0
  puts "部門内訳作成"
  SectionBreakdown.create([
    {input_type: 3 , bill_id:  1 , department_id:  1 , department_money: 1200000},
    {input_type: 3 , bill_id:  1 , department_id:  2 , department_money: 2000000}
])
end

if SlipHeader.count == 0
  puts "仕訳伝票ヘッダー作成"
  SlipHeader.create([
    {bill_id: 1, bill_state_history_id: 1, slip_number: 1, journalizing_slip_date: 20150625, slip_division_code: 1, operating_division1_code: 1, user_id: 1, approved: 2, exported: 0},
    {bill_id: 1, bill_state_history_id: 2, slip_number: 2, journalizing_slip_date: 20150701, slip_division_code: 1, operating_division1_code: 1, user_id: 1, approved: 2, exported: 0},
    {bill_id: 1, bill_state_history_id: 2, slip_number: 3, journalizing_slip_date: 20150924, slip_division_code: 1, operating_division1_code: 1, user_id: 1, approved: 2, exported: 0}
])
end

if SlipDetail.count == 0
  puts "仕訳伝票作成"
  SlipDetail.create([
    {slip_header_id: 1 , line_number:  1 , balanced: 0 , department_code:  100 , department_name:  "第一営業部" , account_code: 130 , account_name: "受取手形"  , 
      including_tax: 3200000 , excluding_taxes: 3200000 , consumption_tax:  0 , 
      tax_division_code:  0 , tax_division_name:  "対象外" , tax_rate: 0 , business_division_code: 0 , analysis_account1_code: 001 , abridgment: "太平洋販売(株)　00TY12000-001201-0000-０　2015/9/24"},
    {slip_header_id: 1 , line_number:  1 , balanced: 1 , department_code:  100 , department_name:  "第一営業部" , account_code: 135 , account_name: "売掛金" , 
      sub_account_code: 00000001  , sub_account_name: "太平洋販売株式会社" , including_tax: 1200000 , excluding_taxes: 1200000 , consumption_tax:  0 , 
      tax_division_code:  0 , tax_division_name:  "対象外" , tax_rate: 0 , business_division_code: 0},
    {slip_header_id: 1 , line_number:  2 , balanced: 1 , department_code:  200 , department_name:  "第二営業部" , account_code: 135 , account_name: "売掛金" , 
      sub_account_code: 00000001  , sub_account_name: "太平洋販売株式会社" , including_tax: 2000000 , excluding_taxes: 2000000 , consumption_tax:  0 , 
      tax_division_code:  0 , tax_division_name:  "対象外" , tax_rate: 0 , business_division_code: 0},
    {slip_header_id: 2 , line_number:  1 , balanced: 0 , department_code:  900 , department_name: "  共通  ", account_code:  110 , account_name: " 当座預金  ", 
      sub_account_code:  001 , sub_account_name: "みずほ銀行丸の内支店"  , including_tax:  1998260 , excluding_taxes: 1998260 , consumption_tax:  0 , 
      tax_division_code:  0 , tax_division_name:  "対象外" , tax_rate: 0 , business_division_code: 0 , abridgment: "太平洋販売(株)　00TY12000-001201-0000-０　2015/9/24"},
    {slip_header_id: 2 , line_number:  1 , balanced: 1 , department_code:  100 , department_name: "  第一営業部 ", account_code:  130 , account_name: " 受取手形  ", 
      sub_account_code:  2000000 , excluding_taxes: 2000000 , consumption_tax:  0 , 
      tax_division_code:  0 , tax_division_name:  "対象外" , tax_rate: 0 , business_division_code: 0 , analysis_account2_code: 001},
    {slip_header_id: 2 , line_number:  2 , balanced: 0 , department_code:  900 , department_name: "  共通  ", account_code:  841 , account_name: " 電子記録債権売却損 ", 
      sub_account_code:  1200  , excluding_taxes: 1200},
    {slip_header_id: 2 , line_number:  3 , balanced: 0 , department_code:  900 , department_name: "  共通  ", account_code:  753 , account_name: " 支払手数料 ", 
      sub_account_code:  540 , excluding_taxes: 500 , consumption_tax:  40  , 
      tax_division_code:  10  , tax_division_name:  "課税仕入"  , tax_rate: 8.000 , business_division_code: 0},
    {slip_header_id: 3 , line_number:  1 , balanced: 0 , department_code:  900 , department_name: "  共通  ", account_code:  110 , account_name: " 当座預金  ", 
      sub_account_code:  001 , sub_account_name: "みずほ銀行丸の内支店"  , including_tax:  1199460 , excluding_taxes: 1199460 , consumption_tax:  0 , 
      tax_division_code:  0 , tax_division_name:  "対象外" , tax_rate: 0 , business_division_code: 0 , abridgment: "太平洋販売(株)　00TY12000-001201-0000-0"},
    {slip_header_id: 3 , line_number:  1 , balanced: 1 , department_code:  100 , department_name: "  第一営業部 ", account_code:  130 , account_name: " 受取手形  ", 
      sub_account_code:  1200000 , excluding_taxes: 1200000 , consumption_tax:  0 , 
      tax_division_code:  0 , tax_division_name:  "対象外" , tax_rate: 0 , business_division_code: 0 , analysis_account2_code: 001},
    {slip_header_id: 3 , line_number:  3 , balanced: 0 , department_code:  900 , department_name: "  共通  ", account_code:  753 , account_name: " 支払手数料 ", 
      sub_account_code:  540 , excluding_taxes: 500 , consumption_tax:  40  , 
      tax_division_code:  10  , tax_division_name:  "課税仕入"  , tax_rate: 8.000 , business_division_code: 0}
])
end
