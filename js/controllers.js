'use strict';

/* Controllers */

var pokerControllers = angular.module('pokerControllers', ['ui.bootstrap']);

pokerControllers.controller('LoginCtrl', [
	'$scope',
	'$location',
	'AuthService',
	function ($scope, $location, AuthService) {
		$scope.message = false;
		
		(function initController() {
            // reset login status
            AuthService.ClearCredentials();
			
        })();
		
		
		$scope.login = function(){
			$scope.dataLoading = true;
            AuthService.login($scope.username, $scope.password, function (response) {
				$scope.message = response;
				$scope.username = '';
				$scope.password = '';
				$scope.form.$setPristine();
                if (response.auth) {
                    AuthService.SetCredentials($scope.username);
                    $location.path('/');
                } else {
					$scope.message = 'Votre nom d\'utilisateur et / ou votre mot de passe sont incorrectes';
                }
            });
		};
	}
]);

pokerControllers.controller('RegisterCtrl', [
	'$scope',
	'$location',
	'User',
	'md5',
	function ($scope, $location, User, md5) {

		$scope.message = false;
		
		$scope.register = function(){
		
			var user = new User();
			user.username=$scope.user.username;
			user.firstname=$scope.user.firstname;
			user.lastname=$scope.user.lastname;
			user.password=md5.createHash($scope.user.password);
			
			user.$save(function (response, headers) {
                    // Success
					$location.path('/login');
                }, function (response) {
                    // failure
					if(response.data=='23000'){
						$scope.message='Ce pseudo existe déjà. Veuillez en choisir un autre !';
					} else {
						$scope.message='Erreur inconnue';
					}
                });
		};
		// $('.btn').tooltip({title: "Hooray"}); 
	}
]);

pokerControllers.controller('HomeCtrl', [
	'$scope',
	'Project',
	function ($scope, Project) {
		$scope.projects = Project.query();
		$scope.isActiveProject = function(p) {
			return p.completed_on === "0000-00-00 00:00:00";
		};
	}
]);
pokerControllers.controller('ProjectListCtrl', [
	'$scope',
	'Project',
	function ($scope, Project) {
		$scope.projects = Project.query();
		$scope.isActiveProject = function(p) {
			return p.completed_on === "0000-00-00 00:00:00";
		};
		$scope.isNotActiveProject = function(p) {
			return p.completed_on !== "0000-00-00 00:00:00";
		};
	}
]);
pokerControllers.controller('ProjectCreateCtrl', [
	'$scope',
	'$location',
	'$routeParams',
	'Project',
	'Progress',
	function ($scope, $location, $routeParams, Project, Progress) {
		$scope.progress = Progress.show(0, 1);
		$scope.project = new Project();
		$scope.project.name = "Nouveau Projet";
		$scope.save = function(){
			$scope.project.$save(function (response, headers) {
				$location.path('/project/'+response.id); 
                }, function (response) {
					if(response.data=='23000'){
						$scope.message='Ce pseudo existe déjà. Veuillez en choisir un autre !';
					} else {
						$scope.message='Erreur inconnue';
					}
                });
		};
		$scope.annuler = function(){
			$location.path('/projects');
		};
	}
]);
pokerControllers.controller('ProjectShowCtrl', [
	'$scope',
	'$location',
	'$rootScope',
	'$routeParams',
	'Project',
	'Progress',
	'popupService',
	'$uibModal',
	function ($scope, $location, $rootScope, $routeParams, Project, Progress, popupService, $uibModal) {
		$scope.project = Project.get({projectId: $routeParams.projectId}, function(data){
            $rootScope.pageTitle = $scope.project.name;
		});
		$scope.progress = Progress.show(10, 2);
		$scope.deleteProject = function(){
			if (popupService.showPopup('Etes-vous sur de vouloir supprimer ce projet ?')) {
				$scope.project.$delete(function() {
					$location.path('/projects'); 
				});
			}
		}; 
		$scope.archive = function(){
			$scope.project.completed_on = new Date().toISOString().slice(0, 19).replace('T', ' ');
			$scope.project.$update();
		};
		$scope.activate = function(){
			$scope.project.completed_on = '0000-00-00 00:00:00';
			$scope.project.$update();
		};
		$scope.comingSoon = function () {

			var modalInstance = $uibModal.open({
				// animation: $scope.animationsEnabled,
				templateUrl: 'myModalContent.html',
				controller: 'MilestoneNewCtrl',
				size: 'lg'
				/* ,
				resolve: {
					items: function () {
						return $scope.items;
					}
				} */
			});

			/* modalInstance.result.then(function (selectedItem) {
			$scope.selected = selectedItem;
			}, function () {
			$log.info('Modal dismissed at: ' + new Date());
			}); */
		};

	}
]);
pokerControllers.controller('ProjectEditCtrl', [
	'$scope',
	'$location',
	'$routeParams',
	'Project',
	'Progress',
	function ($scope, $location, $routeParams, Project, Progress) {
		$scope.project = Project.get({projectId: $routeParams.projectId});
		$scope.projectId = $scope.project.id;
		
		$scope.progress = Progress.show(10, 2);
		$scope.save = function(){
			$scope.project.$update(function() {
				$location.path('/project/'+$routeParams.projectId); 
			});
		};
		$scope.annuler = function(){
			$location.path('/project/'+$routeParams.projectId);
		};
	}
]);
pokerControllers.controller('ProjectCtrl', [
	'$scope',
	'Project',
	function ($scope) {
	}
]);


pokerControllers.controller('MilestoneNewCtrl', [
	'$scope',
	'$uibModalInstance',
	'$location',
	'$routeParams',
	'Project',
	'Milestone',
	'Progress',
	function ($scope, $uibModalInstance, $location, $routeParams, Project, Milestone, Progress) {
		$scope.progress = Progress.show(0, 1);
		// $scope.project = new Project();
		$scope.routeParams = $routeParams;
		$scope.cancel = function () {
			$uibModalInstance.dismiss('cancel');
		};
		// $scope.project.name = "Nouveau Projet";
		/* $scope.save = function(){
			$scope.project.$save(function (response, headers) {
				$location.path('/project/'+response.id); 
                }, function (response) {
					if(response.data=='23000'){
						$scope.message='Ce pseudo existe déjà. Veuillez en choisir un autre !';
					} else {
						$scope.message='Erreur inconnue';
					}
                });
		};
		$scope.annuler = function(){
			$location.path('/projects');
		}; */
	}
]);

