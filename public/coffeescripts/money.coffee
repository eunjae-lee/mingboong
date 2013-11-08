isLoginPage = ->
  return location.href.indexOf("/login") + "/login".length == location.href.length
Parse.initialize("fSdERFQluFzvik1YswPuhPWowcxEehYjwp9zQfyK", "pSMZkzFIiu6MlQDBxt3XxFnDqrYeltwGf8J8tAa8")

if !Parse.User.current() && !isLoginPage()
  location.href = "/login?redirect=" + encodeURIComponent("/money")
else
  alert("logged in")