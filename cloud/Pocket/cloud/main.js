
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

Parse.Cloud.define("email", function(request, response) {
var Mandrill = require('mandrill');
Mandrill.initialize('6fSc8h_O1OH6getOnVKS2w');
Mandrill.sendEmail({
    message: {
        text: request.params.text,
        subject: "Pocket Menu Enquiry",
        from_email: request.params.email,
        to: [
            {
                email: "Kevmart143@gmail.com",
                name: "Kelvin Martinez"
            }
        ]
    },
    async: true
},{
    success: function(httpResponse) {
        response.success("message has been sent!");
    },
    error: function(httpResponse) {
        response.error("error occurs!");
    }
}
);
});
