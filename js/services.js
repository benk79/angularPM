'use strict';

/* Services */

var pokerServices = angular.module('pokerServices', ['ngResource', 'angular-md5', 'ngCookies']);

pokerServices.factory('AuthService', [
	'$rootScope',
	'$http',
	'$cookieStore',
	'md5',
	function($rootScope, $http, $cookieStore, md5){
		
		var service = {};
		
		service.login = function(username, password, callback){
			$http
				.post('./bin/auth.php', { username: username, password: md5.createHash(password) })
				.success(function (response) {
					callback(response);
				});
		};
		
		service.SetCredentials = function(username) {
 
            $rootScope.globals = {
                currentUser: {
                    username: username
                }
            };
 
            $cookieStore.put('globals', $rootScope.globals);
        }
		
        service.ClearCredentials = function() {
            $rootScope.globals = {};
			$rootScope.showMenu = false;
            $cookieStore.remove('globals');
            $cookieStore.remove('PHPSESSID');
        }

		return service;
		
	}
]);

pokerServices.factory('popupService', ['$window',
  function($window){
    this.showPopup=function(message){
        return $window.confirm(message);
    }
	return this;
}]); 
pokerServices.factory('User', ['$resource',
  function($resource){
    return $resource('bin/rest.php/pp_users/:userId');
  }]); 
pokerServices.factory('Project', ['$resource',
  function($resource){
    return $resource('bin/rest.php/pp_projects/:projectId',{projectId:'@id'}, {
		update: {
		  method: 'PUT'
		}});
  }]); 
pokerServices.factory('Milestone', ['$resource',
  function($resource){
    return $resource('bin/rest.php/pp_project_milestones/:milestoneId',{milestoneId:'@id'}, {
		update: {
		  method: 'PUT'
		}});
  }]); 
pokerServices.factory('Progress', [
  function(){
	// $log.log('Progress called');
	var service = {'time':0, 'done':0};
	service.show = function(time, done){
		var showString;
		var perc;
		service.time = time;
		service.done = done;
		if(done==0 ){
			perc=0;
		}else{
			if(time>0) perc = done/time*100;
			else perc = 0;
		}
		showString = '<div class="panel panel-default">'
					+'<div class="panel-heading">'
					+'Avancement'
					+'</div>'
					+'<div class="panel-body">'
					+'<div class="perc">'+ perc +'%</div>'
					+'</div>'
					+'</div>';
		// $log.log(showString);
		// $scope.progress = showString;
		return showString;
	} 
	return service;
	
	// $scope.progress = ;
	
    // return $resource('bin/rest.php/pp_projects/:projectId');
  }]); 
