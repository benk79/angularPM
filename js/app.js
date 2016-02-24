'use strict';

/* App Module */

var pokerApp = angular.module('pokerApp', [
	'ngRoute',
	'ngSanitize',
	'ui.bootstrap',
	'pokerControllers',
	'pokerServices'
]);

pokerApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/home', {
        templateUrl: 'partials/home.html',
        controller: 'HomeCtrl'
      }).
      when('/projects', {
        templateUrl: 'partials/projectList.html',
        controller: 'ProjectListCtrl'
      }).
      when('/project/new', {
        templateUrl: 'partials/projectEdit.html',
        controller: 'ProjectCreateCtrl'
      }).
      when('/milestone/new/:projectId', {
        templateUrl: 'partials/milestone.html',
        controller: 'MilestoneNewCtrl'
      }).
      when('/milestone/:milestoneId', {
        templateUrl: 'partials/milestone.html',
        controller: 'MilestoneCtrl'
      }).
      when('/project/:projectId', {
        templateUrl: 'partials/project.html',
        controller: 'ProjectShowCtrl'
      }).
      when('/projectEdit/:projectId', {
        templateUrl: 'partials/projectEdit.html',
        controller: 'ProjectEditCtrl'
      }).
      when('/login', {
        templateUrl: 'partials/login.html',
        controller: 'LoginCtrl'
      }).
      when('/register', {
        templateUrl: 'partials/register.html',
        controller: 'RegisterCtrl'
      }).
      otherwise({
        redirectTo: '/home'
      });
  }]);
  
pokerApp.run(['$rootScope', '$location', '$routeParams', '$cookieStore', '$http', function($rootScope, $location, $routeParams, $cookieStore, $http){

	$rootScope.globals = $cookieStore.get('globals') || {};
	
	// $rootScope.newVersion = false;
	
	$rootScope.showMenu = false;
	// $rootScope.message = 'test';
	// $rootScope.pageTitle = 'Gestion de projets';
	$rootScope.loadedProject = false;
	
	
	$rootScope.$on('$locationChangeStart', function (event, next, current) {
            // var restrictedPage = $.inArray($location.path(), ['/login', '/register']) === -1;
            var restrictedPage = ['/login', '/register'].indexOf($location.path()) === -1;
            var loggedIn = $rootScope.globals.currentUser;
            if (restrictedPage && !loggedIn) {
                $location.path('/login');
            }
			if(loggedIn){
				$rootScope.showMenu = true;
			}
			$rootScope.location = $location.path();
			$rootScope.routeParams = $routeParams;
			// if( !$routeParams.projectId)
				// $rootScope.pageTitle = 'Gestion de projets';
			
        });


}]);
/* pokerApp.controller('projectNav', ['$rootScope', '$location', function($rootScope, $location){
}]);
 */