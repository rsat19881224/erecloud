# -*- coding: utf-8 -*-
class TraderBankAccount < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  belongs_to :trader, inverse_of: :trader_bank_accounts

  # 口座番号
  validates :account_number, format: {
    with: /\A\d{7}\z/,
    message: '口座番号は7桁です。',
    allow_blank: true
  }

  # 預金種目
  validates :account_type, inclusion: {
    in: Settings.enumerize_options.trader_bank_account.account_types.map(&:id),
    allow_nil: true,
    message: '口座種目は普通、当座、その他から選択してください。'
                                      }
  # 銀行コード
  validates :bank_code, length: {
    is: 4,
    if: :exist_bank?,
    message: '銀行コードは4桁です'
  }

  # 支店コード
  validates :branch_code, length: {
    is: 3,
    if: :exist_branch?,
    allow_blank: true,
    message: '支店コードは3桁です。'
  }

  private
  def exist_bank?
    return if bank_code.blank?

    bank = Bank.search(code_eq: bank_code).result
    if bank.blank?
      errors.add :bank_code, "銀行コード： #{bank_code}"
    end

    if bank.length != 1
      errors.add :bank_code, "銀行コード： #{bank_code}は一意ではありません。"
    end
  end

  def exist_branch?
    return if bank_code.blank? && branch_code.blank?

    if bank_code.blank?
      errors.add :bank_code, "支店コードを入力した場合は銀行コードが必要です。"
      return
    end

    bank = Bank.search(code_eq: bank_code).result
    if bank.length != 1 # 銀行コードが一意でない場合は検証終了(エラーメッセージはbank_codeのvalidationで生成されているため作成しない)
      return
    else
      bank = bank.first
    end

    branch = Branch.search(bank_id_eq: bank.id, code_eq: branch_code).result

    if branch.blank?
      errors.add :branch_code, "本支店コード： #{branch_code}の支店は存在しません。"
    end

    if branch.length != 1
      errors.add :branch_code, "本支店コード: #{branch_code}が一意ではあません"
    end
  end
end
