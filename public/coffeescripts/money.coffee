Parse.initialize("fSdERFQluFzvik1YswPuhPWowcxEehYjwp9zQfyK", "pSMZkzFIiu6MlQDBxt3XxFnDqrYeltwGf8J8tAa8")
Expense = Parse.Object.extend "Expense"

class AddHelper
  constructor: (elem) ->
    @elem = elem
    @user = null
    $(".btn-group .btn-ming", @elem).click =>
      this.userSelected "ming"
    $(".btn-group .btn-seul", @elem).click =>
      this.userSelected "seul"
    $(".btn-submit", @elem).click =>
      this.submit()
  userSelected: (user) ->
    @user = user
    console.log "userSelected", @user
  isValid: ->
    unless @user
      alert "누가 지출했는지 선택하세요"
      return false
    if $(".controls .money", @elem).val().length == 0
      alert "금액은 꼭 입력해야 해요"
      return false
    return true
  submit: ->
    return unless this.isValid()
    expense = new Expense()
    expense.set "who", @user
    expense.set "when", new Date()
    expense.set "howmuch", $(".controls .money", @elem).val() - 0
    expense.save
      success: ->
        alert "저장 완료!"
      error: ->
        alert "저장 다시 한번만.. (오류 남)"

isLoginPage = ->
  return location.href.indexOf("/login") + "/login".length == location.href.length

if !Parse.User.current() && !isLoginPage()
  location.href = "/login?redirect=" + encodeURIComponent("/money")

loadExpenses = ->
  query = new Parse.Query Expense
  query.find
    success: (expenses) ->

bindEvents = ->
  $(".menu_add").click ->
    $("#add-wrapper").show()
    $("#list-wrapper").hide()
    $(".navbar li.active").removeClass "active"
    $(this).parent().addClass "active"
    return false
  $(".menu_list").click ->
    $("#add-wrapper").hide()
    $("#list-wrapper").show()
    $(".navbar li.active").removeClass "active"
    $(this).parent().addClass "active"
    return false
  $('#add-wrapper .btn-group').button()
  window.addHelper = new AddHelper($("#add-wrapper"))

$(document).ready ->
  bindEvents()
  loadExpenses()