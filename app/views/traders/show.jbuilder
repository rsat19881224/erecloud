# coding: utf-8
json.extract! @trader, :kana
json.name @trader.name1

# FIXME: 暫定。まともなシリアライザでnil判定などさせる
json.bank_code @trader.bank_account.bank_code
json.bank_name @trader.bank_account.bank_name
json.branch_code @trader.bank_account.branch_code
json.branch_name @trader.bank_account.branch_name

json.account_type @trader.bank_account.account_type
json.account_number @trader.bank_account.account_number
json.account_client_code @trader.bank_account.edi_code1
