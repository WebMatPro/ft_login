var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;

function UpdateCursorPos() {
    cursor.style.left = cursorX;
    cursor.style.top = cursorY;
}

function Click(x, y) {
    var element = $(document.elementFromPoint(x, y));
    element.focus().click();
}

$(function() {
    window.addEventListener('message', function(event) {
		
        if ( event.data.type == 'EnableGuiLogin' ) {
			
            cursor.style.display = event.data.StatusJs ? "block" : "none"; // If data 'StatusJs' is enable, change css to 'block'
            document.body.style.display = event.data.StatusJs ? "block" : "none"; // If data 'StatusJs' is enable, change css to 'block'
			
        } else if (event.data.type == 'click') {			
            // Avoid clicking the cursor itself, click 1px to the top/left;
            Click(cursorX - 1, cursorY - 1);
        }
		
    });

    $(document).mousemove(function(event) {
        cursorX = event.pageX;
        cursorY = event.pageY;
        UpdateCursorPos();
    });

    /*document.onkeyup = function (data) { // ONLY FOR DEBUGG
       if (data.which == 27) { // Escape key
            $.post('http://ft_login/escape', JSON.stringify({}));
	   }
    }; ONLY FOR DEBUG */
	
    $("#login-form").submit(function(e) {
        e.preventDefault(); // Prevent form from submitting
		
		var username = $("#username").val();
		var password = $("#password").val();
		
        if( username != '' && password != '' ) {	
			$.post('http://ft_login/ft_login:LoginServer', JSON.stringify({
				username: $("#username").val(),
				password: $("#password").val()
			}));
		} else {
			alert('Can you enter something dude ?');
		}
    });
	
	$("#leave").click(function(e) { 
	
		e.preventDefault();	
		
        $.post('http://ft_login/ft_login:LeaveServer', JSON.stringify({}));
    });
	
});
