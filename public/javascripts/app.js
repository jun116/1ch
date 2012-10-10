'use strict';

/* App Module */

angular.module('1ch', ['1chServices']).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/', {templateUrl: 'tpl/main.html', controller: MainCtrl}).
      otherwise({redirectTo: '/'});
}]);
