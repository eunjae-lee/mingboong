ratio = 6722 / 1300

heights = [1300, 950, 640, 400]
lastShowingHeight = null

getImageRect = ->
  currentHeight = $(window).height()
  imgHeight = heights[heights.length - 1]

  for h in heights
    if currentHeight >= h
      imgHeight = h
      break

  imgWidth = ratio * imgHeight
  rect =
    top: (currentHeight - imgHeight) / 2
    width: imgWidth
    height: imgHeight
  return rect

getImageUrl = (height) ->
  postfix = ""
  if window.devicePixelRatio in [1.5, 2, 3]
    postfix = "x#{window.devicePixelRatio}"
  url = "/images/invitation/invitation-h#{height}#{postfix}.png"

showImage = ->
  rect = getImageRect()
  return if lastShowingHeight == rect.height
  url = getImageUrl rect.height
  $("#content").css
    top: rect.top
    width: rect.width
    height: rect.height
  $("#content").attr "src", url

$(window).resize ->
  height = $(window).height()
  setTimeout ->
    if height == $(window).height()
      showImage()
  , 200

log = (msg) ->
  if $("#log").length == 0
    $(document.body).append $("<div id='log' style='position:absolute;top:0;left:0;'></div>")
  $("#log").html msg

$(document).ready ->
  showImage()
