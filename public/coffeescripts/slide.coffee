class Slide
  constructor: (containerElem, data) ->
    @currentSlide = null
    @containerElem = containerElem
    @data = data
    this.init()
  init: ->
    $(window).keyup (key) => 
      result = this.handleKeyUp(key)
      return false
  handleKeyUp: (key) ->
    if key.keyCode is 37 # left
      if @data[@currentIndex].keyUp and @data[@currentIndex].keyUp.left and @data[@currentIndex].keyUp.left(@currentSlide)
        return true
      return this.gotoPrev()
    else if key.keyCode is 39 or key.keyCode is 32 # right or space
      if @data[@currentIndex].keyUp and @data[@currentIndex].keyUp.right and @data[@currentIndex].keyUp.right(@currentSlide)
        return true
      return this.gotoNext()
    return false
  run: ->
  show: (index) ->
    prevSlide = @currentSlide
    data = @data[index]
    data.innerHTML = "" unless data.innerHTML
    @currentSlide = $("""<div class="slide slide-#{index}">#{data.innerHTML}</div>""")
    @currentSlide.css
      "background": "url(#{data.background}) no-repeat"
    @containerElem.append @currentSlide
    @currentIndex = index
    this.showSlideTransitionAnimation prevSlide, @currentSlide
    @currentSlide.ready => data.ready(@currentSlide) if data.ready and typeof data.ready is "function"
  showSlideTransitionAnimation: (prev, current) ->
    if prev
      prev.fadeOut 100, ->
        prev.remove()
    current.fadeIn 100
  gotoPrev: ->
    if @currentIndex - 1 >= 0
      this.show @currentIndex - 1
      return true
    else
      return false
  gotoNext: ->
    if @currentIndex + 1 < @data.length
      this.show @currentIndex + 1
      return true
    else
      return false