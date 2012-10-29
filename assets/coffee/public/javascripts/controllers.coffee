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

      socket.emit 'tweet:show', position

      socket.on 'tweet:result', (data) ->
        data.icon = if data.icon then data.icon else 'https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg'
        data.name = if data.name then data.name else '全国の名無しZ'  
        $scope.tweets = data.tweets

      socket.on 'tweet:end', (data) ->
        $scope.tweets.unshift data.tweets

  @maps.watchPosition (position) ->
    $scope.$apply ->
      $scope.position = position

      alert 'watchPosition!'

      socket.emit 'tweet:show', position


  # thumbnails
  socket.thumb (data) ->
    $scope.thumbnails = data
    localStorage.setItem 'thumbnails', data

  # 設定ポップアップ表示時 
  $scope.open = ->
    # 初期化
    $scope.setting_name = ""
    $('.thumbnail').removeClass 'thumb_active'

    if localStorage.getItem 'setting_name'
      $scope.setting_name = localStorage.getItem 'setting_name'

    thumbnails = $('.thumbnail')
    setting_icon = localStorage.getItem 'setting_icon'

    unless setting_icon
      $(thumbnails[0]).addClass 'thumb_active'

    thumbnails.each (i, thumb) ->
      thumb_url = $(thumb).find('img').attr('ng-src')
      if setting_icon is thumb_url
        $(thumb).addClass 'thumb_active'

  # サムネイルクリック時 - 設定
  $scope.thumb_click = (thumb_no) ->
    $('.thumbnail').removeClass 'thumb_active'
    $('.thumbnail').eq(thumb_no).addClass 'thumb_active'

  # 設定ボタンクリック時 - 設定
  $scope.set = ->
    # 名前を取得し保存
    if $scope.setting_name
      name = $scope.setting_name
    else
      name = ""

    localStorage.setItem 'setting_name', name

    # アイコンを取得し保存
    icon = $('.thumb_active').find('img').attr('src')
    localStorage.setItem 'setting_icon', icon if icon

  # tweetボタンクリック時 - つぶやき
  $scope.tweet = =>
    @maps.position (position) ->
      $scope.$apply ->
        latitude = position.latitude
        longitude = position.longitude
        name = localStorage.getItem 'setting_name'
        icon = localStorage.getItem 'setting_icon'

        message = 
                  text: $scope.text
                  latitude: latitude 
                  longitude: longitude
                  name: name
                  icon: icon

        socket.emit 'tweet', message

        if $scope.text
          $scope.text = ""

    ,(err) ->
      console.log "err: " + err

MainCtrl.$inject = ['$scope', 'socket']

