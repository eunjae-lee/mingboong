Parse.initialize("fSdERFQluFzvik1YswPuhPWowcxEehYjwp9zQfyK", "pSMZkzFIiu6MlQDBxt3XxFnDqrYeltwGf8J8tAa8")

qs = (key) ->
  key = key.replace(/[*+?^$.\[\]{}()|\\\/]/g, "\\$&")
  match = location.search.match(new RegExp("[?&]"+key+"=([^&]+)(&|$)"))
  return match && decodeURIComponent(match[1].replace(/\+/g, " "))

$(document).ready ->
  location.href = "/" if Parse.User.current()

  login = ->
    username = $(".text-username").val()
    password = $(".text-password").val()
    Parse.User.logIn username, password,
      success: (user) ->
        location.href = qs("redirect") or "/"
      error: (user, error) ->
        alert 'login failed'
        console.log error

  $(".btn-login").click ->
    login()
    return false
  $(".form-signin").submit (event) ->
    event.preventDefault()
    login()
    return false