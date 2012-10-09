'use strict';

/* App Module */

angular.module('1ch', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/', {templateUrl: 'partials/main.html', controller: MainCtrl}).
      otherwise({redirectTo: '/'});
}]);
  