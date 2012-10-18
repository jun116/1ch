"use strict"

###
  Controllers
###

MainCtrl = ($scope, socket, $location) ->

  # maps
  maps = new Maps 
  maps.show $("#map_canvas")[0]
  maps.address (address)->
    $scope.$apply ->
      $scope.address = address

  # socketio
  socket.emit 'tweet:show', {}
  socket.on 'send:name', (data) ->
    $scope.tweets = data.tweets

  socket.on 'tweet:end', (data) ->
    $scope.tweets = data.tweets

  socket.on 'tweet:me', (data) ->
    $scope.tweets = data.tweets

  # iScroll
  myScroll = new iScroll 'wrapper'

  # thumbnails
  # 実際の画像はmongoに登録しておくかな
  $scope.thumbnails = [
    {
      no: 0
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
      description: "warppy_"
    }
    {
      no: 1
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
      description: "warppy_"
    }
    {
      no: 2
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
      description: "warppy_"
    }
    {
      no: 3
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
      description: "warppy_"
    }
    {
      no: 4
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
      description: "warppy_"
    }
    {
      no: 5
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
      description: "warppy_"
    }
    {
      no: 6
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
      description: "warppy_"
    }
  ]

  $scope.tweet = ->
    navigator.geolocation.getCurrentPosition (position) =>
      $scope.$apply ->
        latitude = position.coords.latitude
        longitude = position.coords.longitude
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
    $('#thumbnail' + thumb_no).addClass 'thumb_active'

  $scope.set = ->
    # ローカルストレージに入れるZ〜
    console.log $('.thumb_active')
    console.log $scope.setting_name

MainCtrl.$inject = ['$scope', 'socket']

