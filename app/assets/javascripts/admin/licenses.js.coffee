$ ->
  $(document).ready(setUseEndDate)
  $('#license_use_starting_date').blur(setUseEndDate)
  $('#license_period_of_service').change(setUseEndDate)

setUseEndDate = ->
  useStartingDate = $('#license_use_starting_date').val()
  periodOfService = $('#license_period_of_service').val()
  
  if Date.parse(useStartingDate) and parseInt(periodOfService, 10)
    useStartingDate = new Date(useStartingDate)
    periodOfService = new Number(periodOfService)
    useEndDate      = new Date
    
    useEndDate.setTime(useStartingDate.getTime() + periodOfService * 24 * 60 * 60 * 1000)
    formattedUseEndDate = formatDate(useEndDate)

    $('#license_use_end_date').val(formattedUseEndDate)

formatDate = (day) ->
  formatTowDigits = (d) -> if d < 10 then "0#{d}" else d

  year  = day.getFullYear()
  month = formatTowDigits(day.getMonth()+1)
  date  = formatTowDigits(day.getDate())
  formattedDate =  "#{year}/#{month}/#{date}"
  
  return formattedDate
