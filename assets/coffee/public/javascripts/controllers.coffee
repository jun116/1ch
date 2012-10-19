"use strict"

###
  Controllers
###

MainCtrl = ($scope, socket, $location) ->

  # iScroll
  myScroll = new iScroll 'wrapper'

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

      socket.on 'tweet:result', (data) ->
        $scope.tweets = data.tweets

      socket.on 'tweet:end', (data) ->
        $scope.tweets.unshift data.tweets

  # thumbnails
  $.getJSON '/api/thumblist', (data) ->
    $scope.$apply ->
      $scope.thumbnails = data
      console.log "data = " + data
  #console.log $resource
  # $http.get('/api/thumblist').success (data) ->
  #   $scope.$apply ->
  #     $scope.thumbnails = data

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

