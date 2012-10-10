'use strict';

###
  Services
###

angular.module('1chServices', []).
  factory 'socket', ($rootScope) ->
    socket = io.connect()

    on: (eventName, callback) ->
      socket.on eventName, ->
        args = arguments
        $rootScope.$apply ->
          callback.apply socket, args

    emit: (eventName, data, callback) ->
      socket.emit eventName, data, ->
        args = arguments
        $rootScope.$apply ->
          if callback
            callback.apply socket, args
