ratio = 6722 / 1300

heights = [1300, 950, 640]
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
  if window.devicePixelRatio is 2
    postfix = "x2"
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

$(window).resize showImage

$(document).ready ->
  showImage()