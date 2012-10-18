"use strict"

###
  Controllers
###

MainCtrl = ($scope, socket, $location) ->

  # maps
  @maps = new Maps 
  @maps.show $("#map_canvas")[0]
  @maps.address (address) ->
    $scope.$apply ->
      $scope.address = address
  @maps.position (position) ->
    $scope.$apply ->
      $scope.position = position

      # socketio
      socket.emit 'session:start', position
      socket.emit 'tweet:show', {}

      socket.on 'send:name', (data) ->
        $scope.tweets = data.tweets

      socket.on 'tweet:end', (data) ->
        $scope.tweets.unshift data.tweets

      socket.on 'tweet:me', (data) ->
        $scope.tweets = data.tweets

  # iScroll
  myScroll = new iScroll 'wrapper'

  # thumbnails
  # 実際の画像はmongoに登録しておくかな
  $scope.thumbnails = [
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
  ]

  $scope.tweet = =>
    @maps.position (position) ->
      $scope.$apply ->
        latitude = position.latitude
        longitude = position.longitude
        message = 
                  text: $scope.text
                  latitude: latitude 
                  longitude: longitude
                  name: 'warppy_'

        socket.emit 'tweet', message
        console.log message

        if $scope.text
          $scope.text = ""

    ,(err) ->
      console.log "err: " + err

  $scope.thumb_click = (thumb_no) ->
    $('.thumbnail').removeClass 'thumb_active'
    $('.thumbnail').eq(thumb_no).addClass 'thumb_active'

  $scope.set = ->
    # ローカルストレージに入れるZ〜

MainCtrl.$inject = ['$scope', 'socket']

