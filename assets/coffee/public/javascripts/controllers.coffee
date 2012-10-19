"use strict"

###
  Controllers
###

MainCtrl = ($scope, socket) ->

  # iScroll
  # myScroll = new iScroll 'wrapper'

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
  socket.thumb (data) ->
    $scope.thumbnails = data
    localStorage.setItem 'thumbnails', data

  $scope.open = ->
    if localStorage.getItem 'setting_name'
      $scope.setting_name = localStorage.getItem 'setting_name'

    thumbnails = $('.thumbnail')
    setting_icon = localStorage.getItem 'setting_icon'
    
    thumbnails.each (i, thumb) ->
      thumb_url = $(thumb).find('img').attr('ng-src')
      if setting_icon is thumb_url
        $(thumb).addClass 'thumb_active'

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
    # 名前を取得し保存
    name = $scope.setting_name
    localStorage.setItem 'setting_name', name

    # アイコンを取得し保存
    icon = $('.thumb_active').find('img').attr('src')
    localStorage.setItem 'setting_icon', icon if icon

MainCtrl.$inject = ['$scope', 'socket']

