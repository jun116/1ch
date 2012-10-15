"use strict"

###
  Controllers
###

MainCtrl = ($scope, socket) ->

  maps = new Maps $("#map_canvas")[0]
  maps.geolocation()

  socket.emit 'tweet:show', {}

  socket.on 'send:name', (data) ->
    $scope.tweets = data.tweets

  socket.on 'tweet:end', (data) ->
    $scope.tweets = data.tweets

  # iScroll
  myScroll = new iScroll 'wrapper'

  console.log "ctl"

MainCtrl.$inject = ['$scope', 'socket']

TweetCtrl = ($scope, socket, $location) ->

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

        $location.path '/'

    ,(err) ->
      console.log "err: " + err

  socket.on 'tweet:why', (data) ->
    console.log "tweet.end"
    $location.path '/'