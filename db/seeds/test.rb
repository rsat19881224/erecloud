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

if Company.count == 0
  puts "契約企業作成"
  company = Company.new do |c|
    c.management_division_id = ""
    c.demanded = false
    c.number = 0
    c.group_number = 0
    c.name = "テスト株式会社"
    c.postal_code = "000-0000"
    c.prefecture = "tokyo"
    c.address = "test"
    c.tel = "000-0000"
    c.fax = "000-0000"
    c.affiliated_post = "test"
    c.charge_name = "test"
    c.email = "admin@sample.jp"
  end
  company.save!

  puts "ユーザー作成"
  user = User.new do |u|
    u.company_id = company.id
    u.code = 0
    u.name = "admin"
    u.password = "password1234"
    u.email = "admin@sample.jp"
    u.contact_mail = "admin@sample.jp"
    u.user_type = User.user_type.user_admin
    u.password_unlimited = false
    u.next_login_time_password_changed = false
    u.locked = false
  end
  user.save!
end

if StateCode.count == 0
  puts "顛末作成"
  StateCode.create([
    {code: 10, division: 1, bill: "手許",       ebill: "発生",       factoring: "手許", cash_payment: "通知"},
    {code: 11, division: 2, bill: "振出",       ebill: "発生",       factoring: "振出", cash_payment: "通知"},
    {code: 20, division: 1, bill: "裏書",       ebill: "譲渡",       factoring: "譲渡"                      },
    {code: 30, division: 1, bill: "割引",       ebill: "割引",       factoring: "割引"                      },
    {code: 40, division: 1, bill: "自社てん末", ebill: "自社てん末"                                         },
    {code: 50, division: 1, bill: "決済",       ebill: "決済",       factoring: "決済", cash_payment: "決済"},
    {code: 90, division: 1, bill: "返却",       ebill: "取消",       factoring: "組戻", cash_payment: "組戻"},
    {code: 91, division: 2, bill: "返却",       ebill: "取消",       factoring: "組戻", cash_payment: "組戻"},
    {code: 93, division: 1, bill: "不渡",       ebill: "不渡"                                               }
  ])
end

if Menu.count == 0
  puts "メニュー作成"
  Menu.create([
    {code: 0,  name: "製品登録",                manager_division: "system_admin",   product_category: "system",             approval_setting_used: false, extend_type: "no_extend"},
    {code: 1,  name: "メニュー管理",            manager_division: "system_admin",   product_category: "system",             approval_setting_used: false, extend_type: "no_extend"},
    {code: 2,  name: "取引先登録",              manager_division: "general",        product_category: "common",             approval_setting_used: false, extend_type: "no_extend"},
    {code: 3,  name: "部門登録",                manager_division: "general",        product_category: "common",             approval_setting_used: false, extend_type: "no_extend"},
    {code: 4,  name: "運用設定",                manager_division: "general",        product_category: "common",             approval_setting_used: true,  extend_type: "no_extend"},
    {code: 5,  name: "ユーザー登録",            manager_division: "admin",          product_category: "common",             approval_setting_used: true,  extend_type: "no_extend"},
    {code: 6,  name: "受取手形入力",            manager_division: "general",        product_category: "bill_credit",        approval_setting_used: true,  extend_type: "no_extend"},
    {code: 7,  name: "支払手形入力",            manager_division: "general",        product_category: "bill_debit",         approval_setting_used: true,  extend_type: "no_extend"},
    {code: 8,  name: "電子記録債権入力",        manager_division: "general",        product_category: "ebill_credit",       approval_setting_used: true,  extend_type: "no_extend"},
    {code: 9,  name: "電子記録債務入力",        manager_division: "general",        product_category: "ebill_debit",        approval_setting_used: true,  extend_type: "no_extend"},
    {code: 10, name: "ファクタリング債権入力",  manager_division: "general",        product_category: "factoring_credit",   approval_setting_used: true,  extend_type: "no_extend"},
    {code: 11, name: "ファクタリング債務入力",  manager_division: "general",        product_category: "factoring_debit",    approval_setting_used: true,  extend_type: "no_extend"},
    {code: 12, name: "売掛金入力",              manager_division: "general",        product_category: "account_receivable", approval_setting_used: true,  extend_type: "no_extend"},
    {code: 13, name: "買掛金入力",              manager_division: "general",        product_category: "account_payable",    approval_setting_used: true,  extend_type: "no_extend"}
  ])
end

if RecordingInstitution.count == 0
  puts "電子債権記録機関作成"
  RecordingInstitution.create([
    {code: 1, name: "全銀電子債権ネットワーク", abbreviation: "全銀電子債権ネットワーク", recording_number_digit: 20, user_number_digit: 9}
  ])
end

if CompanyBank.count == 0
  puts "会社銀行作成"
  CompanyBank.create([
    {company_id: company.id, code: 1, name: "みずほ銀行東京営業部", bank_code: "0001", bank_name: "みずほ銀行", bank_kana: "ﾐｽﾞﾎ", branch_code: "001",
      branch_name: "東京営業部", branch_kana: "ﾄｳｷﾖｳ", account_type: "saving", account_number: "1000001", account_name_kana: "ﾃｽﾄ", client_code: "2000000002"}
    {company_id: company.id, code: 0000000100, name: "ＡＢＣ銀行千葉支店（当座）2000100", bank_code: "0008", bank_name: "ＡＢＣ銀行", bank_kana: "ｴｰﾋﾞｰｼｰ",
      branch_code: "004", branch_name: "千葉支店", branch_kana: "ﾁﾊﾞ", account_type: "checking", account_number: "checking", account_name_kana: "ﾕﾆｵﾝｼﾖｳｼﾞ(ｶ", client_code: "1000000001"}
  ])
end

if Trader.count == 0
  puts "取引先作成"
  Trader.create([
    {company_id: company.id, code: 1,  name1: "太平洋販売株式会社",     kana: "ﾀｲﾍｲﾖｳﾊﾝﾊﾞｲｶﾌﾞｼｷｶﾞｲｼｬ",    short_name: "太平洋販売株式会社"   },
    {company_id: company.id, code: 2,  name1: "株式会社岩手産業",       kana: "ｶﾌﾞｼｷｶﾞｲｼｬｲﾜﾃｻﾝｷﾞｮｳ",      short_name: "株式会社岩手産業"     },
    {company_id: company.id, code: 3,  name1: "株式会社茨城電機",       kana: "ｶﾌﾞｼｷｶﾞｲｼｬｲﾊﾞﾗｷﾃﾞﾝｷ",      short_name: "株式会社茨城電機"     },
    {company_id: company.id, code: 4,  name1: "群馬事務機株式会社",     kana: "ｸﾞﾝﾏｼﾞﾑｷｶﾌﾞｼｷｶﾞｲｼｬ",       short_name: "群馬事務機株式会社"   },
    {company_id: company.id, code: 5,  name1: "埼玉商事株式会社",       kana: "ｻｲﾀﾏｼｮｳｼﾞｶﾌﾞｼｷｶﾞｲｼｬ",      short_name: "埼玉商事株式会社"     },
    {company_id: company.id, code: 6,  name1: "株式会社千葉デンキ",     kana: "ｶﾌﾞｼｷｶﾞｲｼｬﾁﾊﾞﾃﾞﾝｷ",        short_name: "株式会社千葉デンキ"   },
    {company_id: company.id, code: 7,  name1: "東京事務機販売株式会社", kana: "ﾄｳｷｮｳｼﾞﾑｷﾊﾝﾊﾞｲｶﾌﾞｼｷｶﾞｲｼｬ", short_name: "東京事務機販売株式会社"},
    {company_id: company.id, code: 8,  name1: "神奈川物産株式会社",     kana: "ｶﾅｶﾞﾜﾌﾞｯｻﾝｶﾌﾞｼｷｶﾞｲｼｬ",     short_name: "神奈川物産株式会社"   },
    {company_id: company.id, code: 9,  name1: "新潟工業株式会社",       kana: "ﾆｲｶﾞﾀｺｳｷﾞｮｳｶﾌﾞｼｷｶﾞｲｼｬ",    short_name: "新潟工業株式会社"     },
    {company_id: company.id, code: 10, name1: "石川販売株式会社",       kana: "ｲｼｶﾜﾊﾝﾊﾞｲｶﾌﾞｼｷｶﾞｲｼｬ",      short_name: "石川販売株式会社"     }
  ])
end

if TraderBankAccount.count == 0
  puts "取引先銀行作成"
  TraderBankAccount.create([
    {trader_id: 1,  bank_code: "0525", bank_name: "東日本銀行",      bank_kana: "ﾋｶﾞｼﾆﾂﾎﾟﾝ",     branch_code: "101", branch_name: "本店営業部", branch_kana: "ﾎﾝﾃﾝ",
      account_type: "checking", account_number: "2000001", account_name_kana: "ﾀｲﾍｲﾖｳﾊﾝﾊﾞｲ(ｶ"   },
    {trader_id: 2,  bank_code: "0005", bank_name: "三菱東京UFJ銀行", bank_kana: "ﾐﾂﾋﾞｼﾄｳｷﾖｳUFJ", branch_code: "002", branch_name: "丸の内支店", branch_kana: "ﾏﾙﾉｳﾁ",
      account_type: "checking", account_number: "2000002", account_name_kana: "ｶ)ｲﾜﾃｻﾝｷﾞﾖｳ"     },
    {trader_id: 3,  bank_code: "0009", bank_name: "三井住友銀行",    bank_kana: "ﾐﾂｲｽﾐﾄﾓ",       branch_code: "245", branch_name: "丸の内支店", branch_kana: "ﾏﾙﾉｳﾁ",
      account_type: "checking", account_number: "2000003", account_name_kana: "ｶ)ｲﾊﾞﾗｷﾃﾞﾝｷ"     },
    {trader_id: 4,  bank_code: "0005", bank_name: "三菱東京UFJ銀行", bank_kana: "ﾐﾂﾋﾞｼﾄｳｷﾖｳUFJ", branch_code: "002", branch_name: "丸の内支店", branch_kana: "ﾏﾙﾉｳﾁ",
      account_type: "checking", account_number: "2000004", account_name_kana: "ｸﾞﾝﾏｼﾞﾑｷ(ｶ"      },
    {trader_id: 5,  bank_code: "0009", bank_name: "三井住友銀行",    bank_kana: "ﾐﾂｲｽﾐﾄﾓ",       branch_code: "245", branch_name: "丸の内支店", branch_kana: "ﾏﾙﾉｳﾁ",
      account_type: "saving",   account_number: "1000005", account_name_kana: "ｻｲﾀﾏｼﾖｳｼﾞ(ｶ"     },
    {trader_id: 6,  bank_code: "0525", bank_name: "東日本銀行",      bank_kana: "ﾋｶﾞｼﾆﾂﾎﾟﾝ",     branch_code: "101", branch_name: "本店営業部", branch_kana: "ﾎﾝﾃﾝ" ,
      account_type: "saving",   account_number: "1000006", account_name_kana: "ｶ)ﾁﾊﾞﾃﾞﾝｷ"       },
    {trader_id: 7,  bank_code: "0005", bank_name: "三菱東京UFJ銀行", bank_kana: "ﾐﾂﾋﾞｼﾄｳｷﾖｳUFJ", branch_code: "002", branch_name: "丸の内支店", branch_kana: "ﾏﾙﾉｳﾁ",
      account_type: "checking", account_number: "2000007", account_name_kana: "ﾄｳｷﾖｳｼﾞﾑｷﾊﾝﾊﾞｲ(ｶ"},
    {trader_id: 8,  bank_code: "0009", bank_name: "三井住友銀行",    bank_kana: "ﾐﾂｲｽﾐﾄﾓ",       branch_code: "245", branch_name: "丸の内支店", branch_kana: "ﾏﾙﾉｳﾁ",
      account_type: "checking", account_number: "2000008", account_name_kana: "ｶﾅｶﾞﾜﾌﾞﾂｻﾝ(ｶ"    },
    {trader_id: 9,  bank_code: "0005", bank_name: "三菱東京UFJ銀行", bank_kana: "ﾐﾂﾋﾞｼﾄｳｷﾖｳUFJ", branch_code: "001", branch_name: "本店",       branch_kana: "ﾎﾝﾃﾝ" ,
      account_type: "checking", account_number: "2000009", account_name_kana: "ﾆｲｶﾞﾀｺｳｷﾞﾖｳ(ｶ"   },
    {trader_id: 10, bank_code: "0009", bank_name: "三井住友銀行",    bank_kana: "ﾐﾂｲｽﾐﾄﾓ",       branch_code: "245", branch_name: "丸の内支店", branch_kana: "ﾏﾙﾉｳﾁ",
      account_type: "checking", account_number: "2000010", account_name_kana: "ｲｼｶﾜﾊﾝﾊﾞｲ(ｶ"     }
  ])
end

if Department.count == 0
  puts "部門作成"
  Department.create([
    {company_id: company.id, code: 1, name: "第一営業部", name_kana: "ダイイチエイギョウ", abbreviation: "第一営業部"},
    {company_id: company.id, code: 2, name: "第二営業部", name_kana: "ダイニエイギョウ",   abbreviation: "第二営業部"},
    {company_id: company.id, code: 3, name: "札幌支店",   name_kana: "サッポロ",           abbreviation: "札幌支店"  }
  ])
end

if Remark.count == 0
  puts "備考作成"
  Remark.create([
    {company_id: company.id, code: 1, content: "売掛金入金"},
    {company_id: company.id, code: 2, content: "未収金入金"},
    {company_id: company.id, code: 3, content: "買掛金支払"},
    {company_id: company.id, code: 4, content: "未払金支払"}
  ])
end
