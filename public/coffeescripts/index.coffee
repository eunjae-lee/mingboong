$(document).ready ->
  setBodySize = ->
    $(document.body).css
      "width": $(window).width()
      "height": $(window).height()
  $(window).resize setBodySize
  setBodySize()

  slides = [
    {
      background: "/images/pages/1-1.png"
    }
    {
      background: "/images/pages/1-2.png"
      innerHTML: """
        <img data-xrange="20" data-yrange="10" class="piece piece-1" src="/images/pages/1-2/1-2-1.png" style="display: none; position: absolute;" />
        <img data-xrange="40" data-yrange="40" class="piece piece-2" src="/images/pages/1-2/1-2-2.png" style="display: none; position: absolute;" />
        <img data-xrange="10" data-yrange="20" data-invert="true" class="piece piece-3" src="/images/pages/1-2/1-2-3.png" style="display: none; position: absolute;" />
        <img data-xrange="10" data-yrange="50" class="piece piece-4" src="/images/pages/1-2/1-2-4.png" style="display: none; position: absolute;" />
        <img data-xrange="20" data-yrange="0" class="piece piece-5" src="/images/pages/1-2/1-2-5.png" style="display: none; position: absolute;" />
        <img data-xrange="10" data-yrange="20" class="piece piece-6" src="/images/pages/1-2/1-2-6.png" style="display: none; position: absolute;" />
        <img data-xrange="5" data-yrange="40" class="piece piece-7" src="/images/pages/1-2/1-2-7.png" style="display: none; position: absolute;" />
        <img data-xrange="40" data-yrange="0" class="piece piece-8" src="/images/pages/1-2/1-2-8.png" style="display: none; position: absolute;" />
        <img data-xrange="10" data-yrange="40" class="piece piece-9" src="/images/pages/1-2/1-2-9.png" style="display: none; position: absolute;" />
        <img data-xrange="5" data-yrange="20" class="piece piece-10" src="/images/pages/1-2/1-2-10.png" style="display: none; position: absolute;" />
        <img data-xrange="10" data-yrange="10" class="piece piece-11" src="/images/pages/1-2/1-2-11.png" style="display: none; position: absolute;" />
      """
      keyUp:
        right: (currentSlide) ->
          pieces = $(".piece", currentSlide)
          for _p in pieces
            piece = $(_p)
            unless "block" is piece.css "display"
              piece.css "display", "block"
              piece.plaxify()
              return true
          return false
    }
  ]
  $.plax.enable()
  slide = new Slide($("#container"), slides)
  slide.show(0)