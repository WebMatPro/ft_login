/*
-- @Project: FiveM Tools ft_login
-- @License: GNU General Public License v3.0
*/

// Define the `nui` module
var nui = angular.module('nui', []);

// Define the `PhoneListController` controller on the `phonecatApp` module
nui.controller('nuiController', function nuiController( $scope, $document, $window ) {
	
	$scope.submitEnter = function(event) {
		var username = $("#username").val();
		var password = $("#password").val();
		
        if( username != '' && password != '' ) {	
			$.post('http://ft_login/ft_login:LoginServer', JSON.stringify({
				username: $("#username").val(),
				password: $("#password").val()
			}));
		} else {
			$.post('http://ft_login/ft_login:LoginErrorServer', JSON.stringify({}));
		}
	}	
	
	$scope.submitLeave = function(event) {		
        $.post('http://ft_login/ft_login:LeaveServer', JSON.stringify({}));
    }	
	
    window.addEventListener('message', function(event) {		
        if ( event.data.type == 'EnableGuiLogin' ) {					
            document.body.style.display = event.data.StatusJs ? "block" : "none"; // If data 'StatusJs' is enable, change css to 'block'			
        }		
    });
	
});