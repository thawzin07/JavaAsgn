/**
 * 
 * 
    
Author             : Thet Htar San
Date                 : 5/06/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03


 */
function validateInput(input, regex, errorElement, invalidElement) {
	if (regex.test(input.value)) {
		// Clear error message if the input is valid
		errorElement.textContent = "";
	} else {
		// Display error message if the input is invalid
		errorElement.textContent = invalidElement;
	}
}

// Function to validate the username
function validateUsername() {
	var username = document.getElementById("username");
	var usernameError = document.getElementById("username-error");
	var regex = /^[a-zA-Z0-9]+$/;
	var invalidElement = "Invalid username. Username must contain letters and numbers without space.";
	validateInput(username, regex, usernameError, invalidElement);
}

// Function to validate the email
function validateEmail() {
	var email = document.getElementById("email");
	var emailError = document.getElementById("email-error");
	var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	var invalidElement = "Invalid email. Email must be in this format :example@mail.com";


	validateInput(email, regex, emailError, invalidElement);
}

// Function to validate the phone number
function validatePhone() {
	var phone = document.getElementById("phone");
	var phoneError = document.getElementById("phone-error");
	// Add your phone number validation regex or logic here
	var regex = /^[6,8,9][0-9]{7}$/;
	var invalidElement = "Invalid phone number. Phone number must start with 6,8,9 and have 8 numbers."
	validateInput(phone, regex, phoneError, invalidElement);
}

// Function to validate the password
function validatePassword() {
	var password = document.getElementById("password1");
	var passwordError = document.getElementById("password-error");
	var regex   = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=]).{8,}$/;
	var invalidElement = "Invalid password. Password must contain at least 8 characters containing at least 1 uppercase,1 lowercase,1 number and 1 special character."
	validateInput(password, regex, passwordError, invalidElement);
}


//Funtion to validate postal code
function validatePostalCode(){
	var postalCode=document.getElementById("postalCode");
	var postalCodeError=document.getElementById("postalCode-error");
	var regex=/^\\d{6}$/;
	var invalidElement="Invalid postal. Please enter six digits. "
	validateInput(postalCode,regex,postalCodeError,invalidElement);
	
}

function validateCardNumber(){
	var cardnumber=document.getElementById("cardNumber");
	var cardnumberError=document.getElementById("cardnumber-error");
	var regex=/^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13})$/;
	var invalidElement="Invalid cardnumber. Example format: 4444333322221111"
	validateInput(cardnumber,regex,cardnumberError,invalidElement);
}
function validateCardHolder(){
	var cardholder=document.getElementById("cardholder");
	var cardholderError=document.getElementById("cardholder-error");
	var regex=/^[A-Za-z]+\\s[A-Za-z]+$/;
	var invalidElement="Invalid postal. Example format: John Doe "
	validateInput(cardholder,regex,cardholderError,invalidElement);
}
function validateExpiry(){
	var expirydate=document.getElementById("expirydate");
	var expiryError=document.getElementById("expirydate-error");
	var regex = /^(0[1-9]|1[0-2])\/((20[2-9][0-9])|(2[1-9]\/[0-9]{2}))$/;
	var invalidElement="Invalid postal. Example format: 12/2025 or 12/25 "
	validateInput(expirydate,regex,expiryError,invalidElement);
}
function validateCVV(){
	var cvv=document.getElementById("cvv");
	var cvvError=document.getElementById("cvv-error");
	var regex=/^[0-9]{3,4}$/;
	var invalidElement="Invalid postal. Example format: 123 "
	validateInput(cvv,regex,cvvError,invalidElement);
}

