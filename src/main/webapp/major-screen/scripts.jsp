<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- Required Jquery -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/jquery-ui/jquery-ui.min.js "></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/popper.js/popper.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/bootstrap/js/bootstrap.min.js "></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/pages/widget/excanvas.js "></script>
<!-- waves js -->
<script
	src="<%=request.getContextPath()%>/assets/pages/waves/js/waves.min.js"></script>
<!-- jquery slimscroll js -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/jquery-slimscroll/jquery.slimscroll.js "></script>
<!-- modernizr js -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/modernizr/modernizr.js "></script>
<!-- slimscroll js -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/SmoothScroll.js"></script>
<script
	src="<%=request.getContextPath()%>/assets/js/jquery.mCustomScrollbar.concat.min.js "></script>
<!-- Chart js -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/chart.js/Chart.js"></script>
<!-- amchart js -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script
	src="<%=request.getContextPath()%>/assets/pages/widget/amchart/gauge.js"></script>
<script
	src="<%=request.getContextPath()%>/assets/pages/widget/amchart/serial.js"></script>
<script
	src="<%=request.getContextPath()%>/assets/pages/widget/amchart/light.js"></script>
<script
	src="<%=request.getContextPath()%>/assets/pages/widget/amchart/pie.min.js"></script>
<script
	src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<!-- menu js -->
<script src="<%=request.getContextPath()%>/assets/js/pcoded.min.js"></script>
<script
	src="<%=request.getContextPath()%>/assets/js/vertical-layout.min.js "></script>
<!-- custom js -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/pages/dashboard/custom-dashboard.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/script.js "></script>
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Path to Mask Money Jquery -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery-maskmoney@3.0.2/dist/jquery.maskMoney.min.js"></script>

<script type="text/javascript">
	
	// START Od Formating the Wage Field to BRL
	$("#wage").maskMoney({
		prefix:'R$ ', 
		thousands:'.', 
		decimal:',',
		precision: 2
	}).maskMoney('mask');
	// END Of Formating the wage field to BRL
	
	// START THE CALENDAR TO SEE THE USER AGE----------------------------------------
	$( function() {
		  
		  $("#userBirthday").datepicker({
			    dateFormat: 'yy-mm-dd',
			    dayNames: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
			    dayNamesMin: ['S','M','T','W','T','F','S'],
			    dayNamesShort: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
			    monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
			    monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
			    maxDate: "-18y",
			    nextText: 'Next',
			    prevText: 'Preview',
			    showButtonPanel: true
			});
		  
		// START OF CALENDAR SETTINGS
		var today = new Date().toISOString().split('T')[0];
		document.getElementById("userBirthday").setAttribute("max", today);
		// END OF CALENDAR SETTINGS----------------------------------------
	} );
	// END THE CALENDAR TO SEE THE USER AGE

	$("#cep").keypress(function (event) {
		return /\d/.test(String.fromCharCode(event.keyCode) );
	});

	$("#number").keypress(function (event) {
		return /\d/.test(String.fromCharCode(event.keyCode) );
	});

	$("#numberPhone").keypress(function (event) {
		return /\d/.test(String.fromCharCode(event.keyCode) );
	});

	function changeImage(userPhoto, formFileMultiple){

		var preview = document.getElementById(userPhoto);
		var userFile = document.getElementById(formFileMultiple).files[0];
		var reader = new FileReader();
		
		reader.onloadend = function(){
			preview.src = reader.result;
		};
		
		if(userFile){
			reader.readAsDataURL(userFile);
		
		} else{
			preview.src = '<%=request.getContextPath()%>/assets/images/userImage.png';
		}
	}
	
	async function phoneFieldValidator(){
		var buttonSave = document.querySelector("input#saveNumber-button");
		var buttonUpdate = document.querySelector("input#updateNumber-button");
		var numberPhoneField = document.getElementById("numberPhone").value;
		
		if( numberPhoneField == "" || numberPhoneField == " " ){
			buttonSave.classList.add("btn-grd-disabled");
			buttonSave.classList.add("btn-disabled");
			buttonSave.classList.remove("btn-grd-success");
			buttonSave.disabled = true;
			
			buttonUpdate.classList.add("btn-grd-disabled");
			buttonUpdate.classList.add("btn-disabled");
			buttonUpdate.classList.remove("btn-grd-warning");
			buttonUpdate.disabled = true;
		
		} else{
			buttonSave.classList.remove("btn-grd-disabled");
			buttonSave.classList.remove("btn-disabled");
			buttonSave.classList.add("btn-grd-success");
			buttonSave.disabled = false;
			
			buttonUpdate.classList.remove("btn-grd-disabled");
			buttonUpdate.classList.remove("btn-disabled");
			buttonUpdate.classList.add("btn-grd-warning");
			buttonUpdate.disabled = false;
		}
		
	}
	
	//e-Mail Validation
	function isEmail(email){
		var validation = new RegExp(/^[A-Za-z0-9_\-\.]+@[A-Za-z0-9_\-\.]{2,}\.[A-Za-z0-9]{2,}(\.[A-Za-z0-9])?/);
		if( !validation.test(email) ) {
			return false;
		
		} else {
			return true;
		}
	}

	//Create a alert to enter a value in all fields to user! and make the button disabled
	async function fieldsValidator() {
		var buttonSave = document.querySelector("input#save-button");
		var buttonExclude = document.querySelector("input#exclude-button");
		var buttonUpdate = document.querySelector("input#update-button");
		var name = document.getElementById("name").value;
		var userBirthday = document.getElementById("userBirthday").value;
		var cep = document.getElementById("cep").value;
		var street = document.getElementById("street").value;
		var number = document.getElementById("number").value;
		var city = document.getElementById("city").value;
		var neighborhood = document.getElementById("neighborhood").value;
		var state = document.getElementById("state").value;
		var email = document.getElementById("email").value;
		var login = document.getElementById("login").value;
		var password = document.getElementById("password").value;
		var gender = document.getElementsByName("genderRadio").value;
		var perfil = document.getElementById("perfil").value;

		if ((name == "" || name == " ") || (email == "" || email == " ")
				|| (login == "" || login == " ")
				|| (password == "" || password == " ")
				|| (cep == "" || cep == " ") || (street == "" || street == " ")
				|| (number == "" || number == " ") || (city == "" || city == " ")
				|| (neighborhood == "" || neighborhood == " ") || (state == "" || state == " ")
				|| (userBirthday == "" || userBirthday == " ") ) {
			buttonSave.classList.add("btn-grd-disabled");
			buttonSave.classList.add("btn-disabled");
			buttonSave.classList.remove("btn-grd-success");
			buttonSave.disabled = true;

			buttonExclude.classList.add("btn-grd-disabled");
			buttonExclude.classList.add("btn-disabled");
			buttonExclude.classList.remove("btn-grd-danger");
			buttonExclude.disabled = true;

			buttonUpdate.classList.add("btn-grd-disabled");
			buttonUpdate.classList.add("btn-disabled");
			buttonUpdate.classList.remove("btn-grd-warning");
			buttonUpdate.disabled = true;

		} else if( !isEmail(email) ){
			buttonSave.classList.add("btn-grd-disabled");
			buttonSave.classList.add("btn-disabled");
			buttonSave.classList.remove("btn-grd-success");
			buttonSave.disabled = true;

			buttonExclude.classList.add("btn-grd-disabled");
			buttonExclude.classList.add("btn-disabled");
			buttonExclude.classList.remove("btn-grd-danger");
			buttonExclude.disabled = true;

			buttonUpdate.classList.add("btn-grd-disabled");
			buttonUpdate.classList.add("btn-disabled");
			buttonUpdate.classList.remove("btn-grd-warning");
			buttonUpdate.disabled = true;
			
			Swal
			.fire({
				icon : "warning",
				title : "You must enter a valid e-mail!",
				text : "Please, enter a valid e-mail...",
				footer : "Example: email@email.com"
			});

		} else if( perfil == "SelectPerfil" ){
			buttonSave.classList.add("btn-grd-disabled");
			buttonSave.classList.add("btn-disabled");
			buttonSave.classList.remove("btn-grd-success");
			buttonSave.disabled = true;

			buttonExclude.classList.add("btn-grd-disabled");
			buttonExclude.classList.add("btn-disabled");
			buttonExclude.classList.remove("btn-grd-danger");
			buttonExclude.disabled = true;

			buttonUpdate.classList.add("btn-grd-disabled");
			buttonUpdate.classList.add("btn-disabled");
			buttonUpdate.classList.remove("btn-grd-warning");
			buttonUpdate.disabled = true;
			
			Swal
			.fire({
				icon : "warning",
				title : "You must enter a valid Perfil value!",
				text : "Please, enter a valid Perfil value...",
				footer : "Options: Admin, Secretary or Assistant"
			});
			
		} else {
			buttonSave.classList.remove("btn-grd-disabled");
			buttonSave.classList.remove("btn-disabled");
			buttonSave.classList.add("btn-grd-success");
			buttonSave.disabled = false;

			buttonExclude.classList.remove("btn-grd-disabled");
			buttonExclude.classList.remove("btn-disabled");
			buttonExclude.classList.add("btn-grd-danger");
			buttonExclude.disabled = false;

			buttonUpdate.classList.remove("btn-grd-disabled");
			buttonUpdate.classList.remove("btn-disabled");
			buttonUpdate.classList.add("btn-grd-warning");
			buttonUpdate.disabled = false;
		}

	}
	
	function clearFields() {
		event.preventDefault();

		document.getElementById("id").value = '';
		document.getElementById("name").value = '';
		document.getElementById("userBirthday").value = '';
		document.getElementById("email").value = '';
		document.getElementById("login").value = '';
		document.getElementById("password").value = '';
		document.getElementById("flexRadioMasculine").checked = false;
		document.getElementById("flexRadioFeminine").checked = false;
		document.getElementById("perfil").value = "SelectPerfil";
		document.getElementById("cep").value = '';
		document.getElementById("street").value = '';
		document.getElementById("number").value = '';
		document.getElementById("city").value = '';
		document.getElementById("neighborhood").value = '';
		document.getElementById("state").value = '';
		
		document.getElementById("formFileMultiple").value = '';
		document.getElementById("userPhoto").src = '<%=request.getContextPath()%>/assets/images/userImage.png';
		
		Swal.fire({
			position : "center",
			icon : "success",
			title : "The fields were cleared",
			showConfirmButton : false,
			timer : 2500
		});
	}
	
	function clearFieldsWhenDeleting(){
		event.preventDefault();

		document.getElementById("id").value = '';
		document.getElementById("name").value = '';
		document.getElementById("userBirthday").value = '';
		document.getElementById("email").value = '';
		document.getElementById("login").value = '';
		document.getElementById("password").value = '';
		document.getElementById("flexRadioMasculine").checked = false;
		document.getElementById("flexRadioFeminine").checked = false;
		document.getElementById("perfil").value = "SelectPerfil";
		document.getElementById("cep").value = '';
		document.getElementById("street").value = '';
		document.getElementById("number").value = '';
		document.getElementById("city").value = '';
		document.getElementById("neighborhood").value = '';
		document.getElementById("state").value = '';
		
		document.getElementById("formFileMultiple").value = '';
		document.getElementById("userPhoto").src = '<%=request.getContextPath()%>/assets/images/userImage.png';
	}
	
	async function confirmAlert() {

		var email = document.getElementById("email").value;
		var optionUser;
		
		await Swal.fire({
			  title: "Are you sure?",
			  text: "You won't be able to revert this!",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  cancelButtonColor: "#d33",
			  confirmButtonText: "Yes, delete it!"
			}).then((result) => {
			  
				if (result.isConfirmed) {
			    	optionUser = true;
			  
			  } else{
				  optionUser = false;
			  }
			});
		return optionUser;
	}

	async function sendExcludeRequest() {
		
		if ( await confirmAlert() ) {
			
			document.getElementById("my-form").method = "get";
			document.getElementById("action").value = "exclude";
			document.getElementById("my-form").submit();
		}
	}
	
	async function sendExcludeRequestWithAjax() {
		
		if ( await confirmAlert() ) {
			
			var urlAction = document.getElementById('my-form').action;
			var userLogin = document.getElementById('login').value;
			
			$.ajax({
				method: "get",
				url: urlAction,
				data: 'login=' + userLogin + '&action=exclude-ajax',
				
				success: function(response){
						
					Swal.fire({
						position : "center",
						icon : "info",
						title : response,
						showConfirmButton : false,
						timer : 2500
					});
					
					clearFieldsWhenDeleting();
				}
				
			}).fail(function(xhr, status, errorThrown){
				
				Swal.fire({
					  icon: "error",
					  title: "Oops... Something went wrong!",
					  text: "We had an error... " + xhr.responseText,
					  footer: "Oh no!!"
					});

			});
			
		}
	}
	
	function seeEdit(id){
		var urlAction = document.getElementById('my-form').action;
		
		//Here is executed a GET method
		window.location.href = urlAction + '?action=search-id-by-ajax&id=' + id;
		
	}
	
	function searchModalUserAjax(url){
		var urlAction = document.getElementById('search-form').action + url;
		var nameSearch = document.getElementById('recipient-name').value;
				
		$.ajax({
			method: "get",
			url: urlAction,
			
			success: function(response, textStatus, xhr){ //= XHR -> Datas of header
				
				//document.getElementById("search-form").reset();
				
				var jsonOfJavaResponse = JSON.parse(response);
				
				$('#search-results-table > tbody > tr').remove();
				$('#ulModalPagination > li').remove();
									
				for(var position = 0; position < jsonOfJavaResponse.length; position++){
					$('#search-results-table > tbody').append(
							'<tr> '
							+'<td> ' + jsonOfJavaResponse[position].id + ' </td>'
							+'<td> ' + jsonOfJavaResponse[position].name + ' </td>'
							+'<td> <button class="btn btn-info" onclick="seeEdit('+ jsonOfJavaResponse[position].id +')"> Edit </button> </td>'
							+' </tr>');
				}
				
				document.getElementById('number-of-results').textContent = 'Number of results: ' + jsonOfJavaResponse.length;
				
				var totalPages = xhr.getResponseHeader("totalPages");
				
				for(var currentPage = 0; currentPage < totalPages; currentPage++){
					var urlOfModalPagination = "?user-name=" + nameSearch + "&action=search-user-by-ajax-modal-pagination&page=" + (currentPage * 5);
					$("#ulModalPagination").append( '<li class="page-item"><a class="page-link" href="#" onclick="searchModalUserAjax(\''+urlOfModalPagination+'\')">'+ (currentPage + 1) +'</a></li>' );
				}
				
			}
		
		}).fail(function(xhr, status, errorThrown){
			
			alert("We hada a problem here... " + xhr.responseText);
			
		});
	}
	
	function searchUser(){
		var recipient_modal_name = document.getElementById("recipient-name").value;
		var urlAction = document.getElementById('search-form').action;
		
		if(recipient_modal_name != null && recipient_modal_name != "" && (recipient_modal_name.trim() != "") ){
			
			$.ajax({
				method: "get",
				url: urlAction,
				data: "user-name=" + recipient_modal_name + "&action=search-user-by-ajax",
				
				success: function(response, textStatus, xhr){ //= XHR -> Datas of header
					
					//document.getElementById("search-form").reset();
					
					var jsonOfJavaResponse = JSON.parse(response);
					
					$('#search-results-table > tbody > tr').remove();
					$('#ulModalPagination > li').remove();
										
					for(var position = 0; position < jsonOfJavaResponse.length; position++){
						$('#search-results-table > tbody').append(
								'<tr> '
								+'<td> ' + jsonOfJavaResponse[position].id + ' </td>'
								+'<td> ' + jsonOfJavaResponse[position].name + ' </td>'
								+'<td> <button class="btn btn-info" onclick="seeEdit('+ jsonOfJavaResponse[position].id +')"> Edit </button> </td>'
								+' </tr>');
					}
					
					document.getElementById('number-of-results').textContent = 'Number of results: ' + jsonOfJavaResponse.length;
					
					var totalPages = xhr.getResponseHeader("totalPages");
					
					for(var currentPage = 0; currentPage < totalPages; currentPage++){
						var urlOfModalPagination = "?user-name=" + recipient_modal_name + "&action=search-user-by-ajax-modal-pagination&page=" + (currentPage * 5);
						$("#ulModalPagination").append('<li class="page-item"><a class="page-link" href="#" onclick="searchModalUserAjax(\''+urlOfModalPagination+'\')">'+ (currentPage + 1) +'</a></li>');
					}
					
				}
			
			}).fail(function(xhr, status, errorThrown){
				
				alert("We hada a problem here... " + xhr.responseText);
				
			});
			
		}
	}
	
	function searchCep(){
		var cep = $("#cep").val();
		
		if(cep != '' && cep != null){
			const endPoint = "https://viacep.com.br/ws/" + cep + "/json/";
			
			fetch(endPoint)
				.then( response => response.json() )
				.then( responseJson => {
					
					document.getElementById("street").value = responseJson.logradouro;
					document.getElementById("city").value = responseJson.localidade;
					document.getElementById("neighborhood").value = responseJson.bairro;
					document.getElementById("state").value = responseJson.uf;
				} )
		}
	}
		
</script>
