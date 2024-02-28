<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Starting in JSP</title>
		
		<style type="text/css">
			
			.welcome-message{
				position: absolute;
				top: 17%;
				left: 28%;
				right: 28%;
			}
			
			form{
				position: absolute;
				top: 35%;
				left: 28%;
				right: 28%;
			}
			
			.msg{
				padding: 1.7%;
				color: red;
				text-align: center;
			}
			
		</style>
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous" />
	</head>
	
	<body>
	
		<div  class="msg">
			<h5>${msg}</h5>
		</div>
		
		<div>
			<h1 class="welcome-message">Welcome to JSP Manager!</h1>
			
			<form action="<%= request.getContextPath() %>/ServletLogin" method="post" class="row g-3 col-md-6 needs-validation" novalidate>
				<input type="hidden" name="url" value="<%= request.getParameter("url") %>" />
				
				<div class="mb-3">
					<label for="login" class="form-label">Login</label>
					<input type="text" name="login" id="login" class="form-control" placeholder=" Enter your login" required />
					<div class="invalid-feedback">
				      Please, Enter the login!!
				    </div>
					<div class="valid-feedback">
				      Looks good!
				    </div>
				</div>
	
				<div class="mb-3">
					<label for="password" class="form-label">Password</label>
					<input type="password" name="password" id="password" class="form-control" placeholder=" Enter your password" required />
					<div class="invalid-feedback">
				      Please, Enter the password!
				    </div>
					<div class="valid-feedback">
				      Looks good!
				    </div>
				</div>
				
				<input type="submit" value="LogIn" class="btn btn-outline-primary btn-lg" />
			</form>
		</div>
	
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script type="text/javascript">
		//Here I used JavaScript to validate fields
			(() => {
				  'use strict'
	
				  // Fetch all the forms we want to apply custom Bootstrap validation styles to
				  const forms = document.querySelectorAll('.needs-validation')
	
				  // Loop over them and prevent submission
				  Array.from(forms).forEach(form => {
				    form.addEventListener('submit', event => {
				      if (!form.checkValidity()) {
				        event.preventDefault()
				        event.stopPropagation()
				      }
	
				      form.classList.add('was-validated')
				    }, false)
				  })
				})()
		</script>
		
		<script type="text/javascript">
			
		</script>
	</body>
</html>