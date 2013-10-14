setBodySize = ->
  $(document.body).css
    "width": $(window).width()
    "height": $(window).height()

getInitialSlideNum = ->
  if location.hash.indexOf("#slide-") is 0
    return location.hash.substr("#slide-".length) - 0
  else
    return 0

$(document).ready ->
  if $(window).width() >= 2048
    slideSize = 2048
  else
    slideSize = 1024

  $(window).resize setBodySize
  setBodySize()

  slides = [
    { #slide-0
      background: ""
      innerHTML: """
        <div class="real_canvas" style="background: url(/images/book-#{slideSize}/0102/image-04.png) no-repeat; position: relative; top: -389px;">
          <img src="/images/book-#{slideSize}/0102/text-04.png" />
        </div>
      """
      keyUp:
        right: (currentSlide) ->
          unless currentSlide.doneMovingDown
            currentSlide.doneMovingDown = true
            $(".real_canvas", currentSlide).animate {
              top: "-120px"
            }, 2000
            return true
          return false
    }
    { #slide-1
      background: "/images/book-#{slideSize}/0102/image-01.png"
      innerHTML: """
        <img class="piece piece-1" src="/images/book-#{slideSize}/0102/text-01/01.png" />
        <img class="piece piece-2" src="/images/book-#{slideSize}/0102/text-01/02.png" />
        <img class="piece piece-3" src="/images/book-#{slideSize}/0102/text-01/03.png" />
        <img class="piece piece-4" src="/images/book-#{slideSize}/0102/text-01/04.png" />
        <img class="piece piece-5" src="/images/book-#{slideSize}/0102/text-01/05.png" />
        <img class="piece piece-6" src="/images/book-#{slideSize}/0102/text-01/06.png" />
        <img class="piece piece-7" src="/images/book-#{slideSize}/0102/text-01/07.png" />
        <img class="piece piece-8" src="/images/book-#{slideSize}/0102/text-01/08.png" />
        <img class="piece piece-9" src="/images/book-#{slideSize}/0102/text-01/09.png" />
        <img class="piece piece-10" src="/images/book-#{slideSize}/0102/text-01/10.png" />
        <img class="piece piece-11" src="/images/book-#{slideSize}/0102/text-01/11.png" />
        <img class="piece piece-12" src="/images/book-#{slideSize}/0102/text-01/12.png" />
        <img class="piece piece-13" src="/images/book-#{slideSize}/0102/text-01/13.png" />
      """
      ready: (currentSlide) ->
        data = [
          [1, 10, 40, false, 129, 144]
          [2, 40, 20, false, 233, 44]
          [3, 20, 20, true, 258, 143]
          [4, 20, 20, false, 509, 176]
          [5, 20, 30, true, 582, 138]
          [6, 20, 0, false, 659, 0]
          [7, 20, 10, false, 662, 95]
          [8, 10, 20, true, 650, 215]
          [9, 20, 0, false, 789, 0]
          [10, 20, 20, false, 739, 93]
          [11, 10, 10, true, 797, 94]
          [12, 5, 20, false, 846, 116]
          [13, 0, 20, false, 1007, 216]
        ]
        ratio = slideSize / 1024
        for datum in data
          [index, xrange, yrange, invert, left, top] = datum
          elem = $(".piece-#{index}", currentSlide)
          elem.attr
            "data-xrange": xrange*ratio
            "data-yrange": yrange*ratio
            "data-invert": invert
          elem.css
            "display": "none"
            "position": "absolute"
            "left": left*ratio
            "top": top*ratio
      keyUp:
        right: (currentSlide) ->
          pieces = $(".piece", currentSlide)
          for _p in pieces
            piece = $(_p)
            unless "block" is piece.css "display"
              piece.css "display", "block"
              piece.plaxify()
              return true
          unless currentSlide.ignoredOnce
            currentSlide.ignoredOnce = true
            return true
          return false
    }
    { #slide-2
      background: "/images/book-#{slideSize}/0102/image-02.png"
      fadeInImage: "/images/book-#{slideSize}/0102/text-02.png"
    }
    { #slide-3
      background: "/images/book-#{slideSize}/0102/image-03.png"
      fadeInImage: "/images/book-#{slideSize}/0102/text-03.png"
    }
    { #slide-4
      background: "/images/book-#{slideSize}/03/image-01.png"
      fadeInImage: "/images/book-#{slideSize}/03/text-01.png"
    }
    { #slide-5
      background: "/images/book-#{slideSize}/03/image-03.png"
      fadeOutImage: "/images/book-#{slideSize}/03/text-02.png"
    }
    { #slide-6
      background: "/images/book-#{slideSize}/03/image-04.png"
      fadeInImage: "/images/book-#{slideSize}/03/text-04.png"
    }
    { #slide-7
      background: "/images/book-#{slideSize}/03/image-05.png"
      fadeInImage: "/images/book-#{slideSize}/03/text-05.png"
    }
    { #slide-8
      background: "/images/book-#{slideSize}/03/image-06.png"
      fadeInImage: "/images/book-#{slideSize}/03/text-06.png"
    }
    { #slide-9
      background: "/images/book-#{slideSize}/03/image-07.png"
      fadeInImage: "/images/book-#{slideSize}/03/text-07.png"
    }
    { #slide-10
      background: "/images/book-#{slideSize}/03/image-08.png"
      fadeInImage: "/images/book-#{slideSize}/03/text-08.png"
    }
    { #slide-11
      background: "/images/book-#{slideSize}/03/image-09.png"
      fadeInImage: "/images/book-#{slideSize}/03/text-09.png"
    }
    { #slide-12
      background: "/images/book-#{slideSize}/03/image-10.png"
      fadeInImage: "/images/book-#{slideSize}/03/text-10.png"
    }
    { #slide-13
      background: "/images/book-#{slideSize}/03/image-11.png"
      fadeInImage: "/images/book-#{slideSize}/03/text-11.png"
    }
    { #slide-14
      background: "/images/book-#{slideSize}/04/image-01.png"
      fadeInImage: "/images/book-#{slideSize}/04/text-01.png"
    }
    { #slide-15
      background: "/images/book-#{slideSize}/04/image-03.png"
      fadeOutImage: "/images/book-#{slideSize}/04/text-02.png"
    }
    { #slide-16
      background: "/images/book-#{slideSize}/04/image-05.png"
      fadeInImage: "/images/book-#{slideSize}/04/text-05.png"
    }
    { #slide-17
      background: "/images/book-#{slideSize}/04/image-06.png"
      fadeInImage: "/images/book-#{slideSize}/04/text-06.png"
    }
    { #slide-18
      background: "/images/book-#{slideSize}/05/image-01.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-01.png"
    }
    { #slide-19
      background: ""
      fadeInImage: "/images/book-#{slideSize}/05/text-14.png"
    }
    { #slide-20
    }
    { #slide-21
      background: ""
      fadeInImage: "/images/book-#{slideSize}/05/text-15.png"
    }
    { #slide-22
      background: "/images/book-#{slideSize}/05/image-02.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-02.png"
    }
    { #slide-23
      background: "/images/book-#{slideSize}/05/image-03.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-03.png"
    }
    { #slide-24
      background: "/images/book-#{slideSize}/05/image-04.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-04.png"
    }
    { #slide-25
      background: "/images/book-#{slideSize}/05/image-05.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-05.png"
    }
    { #slide-26
      background: "/images/book-#{slideSize}/05/image-06.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-06.png"
    }
    { #slide-27
      background: "/images/book-#{slideSize}/05/image-07.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-07.png"
    }
    { #slide-28
      background: ""
      fadeInImage: "/images/book-#{slideSize}/05/text-08.png"
    }
    { #slide-29
      background: "/images/book-#{slideSize}/05/image-12.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-12.png"
    }
    { #slide-30
      background: "/images/book-#{slideSize}/05/image-13.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-13.png"
    }
    { #slide-31
      background: "/images/book-#{slideSize}/05/image-10.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-10.png"
    }
    { #slide-32
      background: "/images/book-#{slideSize}/05/image-11.png"
      fadeInImage: "/images/book-#{slideSize}/05/text-11.png"
    }
    { #slide-33
      background: "/images/book-#{slideSize}/06/image-01.png"
      fadeInImage: "/images/book-#{slideSize}/06/text-01.png"
    }
    { #slide-34
      background: "/images/book-#{slideSize}/06/image-02.png"
      fadeInImage: "/images/book-#{slideSize}/06/text-02.png"
    }
    { #slide-35
    }
    { #slide-36
      background: "/images/book-#{slideSize}/06/image-04.png"
      fadeInImage: "/images/book-#{slideSize}/06/text-04.png"
    }
    { #slide-37
      background: "/images/book-#{slideSize}/06/image-06.png"
      fadeOutImage: "/images/book-#{slideSize}/06/text-05.png"
    }
    { #slide-38
      background: "/images/book-#{slideSize}/06/image-07.png"
      fadeInImage: "/images/book-#{slideSize}/06/text-07.png"
    }
    { #slide-39
      background: "/images/book-#{slideSize}/06/image-14.png"
    }
    { #slide-40
      background: "/images/book-#{slideSize}/06/image-15.png"
    }
    { #slide-41
      background: "/images/book-#{slideSize}/06/image-16.png"
    }
    { #slide-42
      background: "/images/book-#{slideSize}/06/image-17.png"
    }
    { #slide-43
      background: "/images/book-#{slideSize}/06/image-08.png"
      fadeInImage: "/images/book-#{slideSize}/06/text-08.png"
    }
    { #slide-44
      background: "/images/book-#{slideSize}/06/image-09.png"
      fadeInImage: "/images/book-#{slideSize}/06/text-09.png"
    }
    { #slide-45
      background: "/images/book-#{slideSize}/06/image-10.png"
    }
    { #slide-46
      background: "/images/book-#{slideSize}/06/image-11.png"
      fadeInImage: "/images/book-#{slideSize}/06/text-11.png"
    }
    { #slide-47
      background: ""
      fadeInImage: "/images/book-#{slideSize}/06/text-13.png"
    }
    { #slide-48
      background: "/images/book-#{slideSize}/07/image-01.png"
      fadeInImage: "/images/book-#{slideSize}/07/text-01.png"
    }
    { #slide-49
      background: "/images/book-#{slideSize}/07/image-02.png"
      fadeInImage: "/images/book-#{slideSize}/07/text-02.png"
    }
    { #slide-50
      background: "/images/book-#{slideSize}/07/image-03.png"
      fadeInImage: "/images/book-#{slideSize}/07/text-03.png"
    }
    { #slide-51
      background: "/images/book-#{slideSize}/07/image-04.png"
      fadeInImage: "/images/book-#{slideSize}/07/text-04.png"
    }
    { #slide-52
      background: "/images/book-#{slideSize}/07/image-05.png"
      fadeInImage: "/images/book-#{slideSize}/07/text-05.png"
    }
    { #slide-53
      background: ""
      innerHTML: """
        <div class="wide_container" style="position: absolute;">
          <img src="/images/book-#{slideSize}/07/image-06.png" style="float: left;" />
          <img class="text" src="/images/book-#{slideSize}/07/text-06.png" style="display: none; position: absolute; left: 0; top: 0;" />
          <img src="/images/book-#{slideSize}/07/image-07.png" style="float: left;" />
        </div>
      """
      ready: (currentSlide) ->
        ratio = slideSize / 1024
        debugger
        $(".wide_container", currentSlide).css "width", 2615*ratio
      keyUp:
        right: (currentSlide) ->
          unless currentSlide.doneShowingText
            currentSlide.doneShowingText = true
            $(".text", currentSlide).fadeIn 300
            return true

          unless currentSlide.doneMovingRight
            currentSlide.doneMovingRight = true
            ratio = slideSize / 1024
            $(".wide_container", currentSlide).animate
              left: -(2615*ratio - slideSize)
            , 10000, "linear"
            return true

          return false
    }
  ]
  $.plax.enable()
  slide = new Slide
    container: $("#container")
    slides: slides
    slideWidth: slideSize
  slide.show(getInitialSlideNum())

  $(".btn_left_arrow").click -> slide.doLeftAction() and false
  $(".btn_right_arrow").click -> slide.doRightAction() and false