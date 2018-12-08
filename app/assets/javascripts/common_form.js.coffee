# TODO: まだいいけど80行増えたら要素ごとに分割

$ ->
  # フォーカス時の背景色設定
  $("input[type=text], input[type=number], input[type=search], select").on 'focus', () ->
    unless $(@).attr('readonly') is true
      $(@).css("background-color", "#ff0")
      $(@).removeClass('error-form')

  $("select").on 'focus', () ->
    $(@).css("fontSize","11px")

  $("input[type=text], input[type=number], input[type=search], select").on 'blur', () ->
    unless $(@).attr('readonly') is true
      $(@).css("background-color", "#fff")

  $(document).on 'nested:fieldAdded', (e) ->
    inputForms = $(e.field).find('input[type=text], input[type=number], input[type=search], select')
    for form in inputForms
      $(form).on {
        'focus': ->
          unless $(@).attr('readonly') is true
            $(@).css('background-color', '#ff0')
            $(@).removeClass('error-form')

        'blur': ->
          unless $(@).attr('readonly') is true
            $(@).css('background-color', '#fff')
      }

  errorFields = $(document).find('.field_with_errors > input[type=text], input[type=number], input[type=search], select')
  for field in errorFields
    $(field).on 'focus', -> $(@).css(cssText: 'background-color: #ff0 !important')

  # 日付テキストボックス入力時
  $('.inputCalendars').on 'blur', ->
    if !checkDate($(@).val())
      $(@).val('')

  # 数値項目
  $('.currency_amount').on 'input', ->
    $(@).val inputCurrencieze($(@).val())

  # 金額テキストボックスにカーソルを入れた場合
  $('.money_format').on 'focus', () ->
    delComma $(@)

  # 金額テキストボックスからカーソルを外した場合
  $('.money_format').on 'blur', () ->
    addComma $(@)

  # submit時に金額のカンマを削除
  $('input[type="submit"]').on 'click', ->
    $('.money_format').each ->
      delComma $(@)

  # キャンセルボタン押下時にフォームの内容を消去
  $(".form_reset").on 'click', ->
    delFormAll()

  # カレンダー入力活性化
  $('.inputCalendars').setCalendar()

# 日付チェック
checkDate = (inputDate) ->
  dateArray = []
  # yyyy/mm/dd、yyyy-mm-dd、yyyymmddか
  if /^\d{4}\/\d{1,2}\/\d{1,2}$/.test(inputDate)
    dateArray = inputDate.split("/")
  else if /^\d{4}\-\d{1,2}\-\d{1,2}$/.test(inputDate)
    dateArray = inputDate.split("-")
  else if /^\d{8}$/.test(inputDate)
    dateArray[0] = inputDate.substr(0, 4)
    dateArray[1] = inputDate.substr(4, 2)
    dateArray[2] = inputDate.substr(6, 2)
  else
    return false

  year = parseInt(dateArray[0])
  month = parseInt(dateArray[1] - 1)
  day = parseInt(dateArray[2])

  if (year >= 0) and (0 <= month <= 11) and (1 <= day <= 31)
    date = new Date(year, month, day)
    if (parseInt(date.getFullYear()) is year) and (parseInt(date.getMonth()) is month) and (parseInt(date.getDate()) is day)
      return true
    else
      return false

# 金額の3桁カンマ区切り追加
addComma = (money) ->
  $(money).val $(money).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')

# 金額の3桁カンマ区切り削除
delComma = (money) ->
  $(money).val $(money).val().replace(/,/g, '')

# フォーム内容を全消去
delFormAll =  ->
  $("input[type='search']").val('')
  $("input[type='text']").val('')

class PostalCode
  ###*
   * 郵便番号のフォーマットを行う
   * @param {string} code - フォーマット対象の文字列
   * @return {string} フォーマット後の文字列
  ###
  _formatPostalCode = (code) ->
    code = code.replace(/[^0-9]+/ig, '')
    len  = code.length

    if len <= 3
      return code
    else
      return "#{code[0..2]}-#{code[3..(if len > 6 then 6 else len)]}"

  ###*
   * @constructor
   * @classdesc 文字列の郵便番号形式へのフォーマット、検証を行うためのクラス
   * @param {string} code - 郵便番号
  ###
  constructor: (@code) ->
    @formattedCode = _formatPostalCode(@code)

  ###*
   * 郵便番号の形式の検証を行う
   * @return {boolean} 正当な形式であればtrue、不正な形式であればfalse
  ###
  isValid: ->
    /^\d{3}\-\d{4}$/.test(@code)

class HalfWidthKana
  ###*
   * @constructor
   * @classdec 半角カナを扱うためのクラス
   * @param {string} kana - 半角カナ文字
  ###
  constructor: (@kana) ->

  ###*
   * 半角カナの拗音を大文字に変換する
   * @param {string} str - 変換対象の文字列
   * @return {string} 変換後の文字列
  ###
  toUpperCase: ->
    cslist = {'ｧ': 'ｱ', 'ｨ': 'ｲ', 'ｩ': 'ｳ', 'ｪ': 'ｴ', 'ｫ': 'ｵ', 'ｯ': 'ｯ', 'ｬ': 'ﾔ', 'ｭ': 'ﾕ', 'ｮ': 'ﾖ'}
    str = Array.prototype.map.call(@kana, (c) -> cslist[c] or c)
    str.join('')

  ###*
   * 引数の文字列を全銀フォーマットで使用可能な文字列へ変換する
   * @param {string} str - フォーマット対象の文字列
   * @return {string} フォーマット済の文字列
  ###
  toZenginFormat: ->
    str = this.toUpperCase().replace(/[^A-Zｱ-ﾝ0-9-\/\\()｢｣ﾞﾟ. ]+/g, '')

###*
 * 口座番号のゼロパディング(7桁)を行うための関数
 * @param {string} number - 口座番号
 * @return {string} パディング済みの口座番号
###
zeroPaddingAccountNumber = (number) -> ("0000000"+number).slice(-7)

erecloud_export('PostalCode', PostalCode)
erecloud_export('HalfWidthKana', HalfWidthKana)
erecloud_export('zeroPaddingAccountNumber', zeroPaddingAccountNumber)
# 金額列フォーマット
inputCurrencieze = (str) ->
  # 数字のみ11文字制限
  num = String(str).replace(/\D/g, '').substr(0, 11)
  # カンマの埋め込み
  String(num).replace /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,'
