// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require notification
//= require_tree .

if (!(window.console && console.log)) {
    (function() {
        var noop = function() {};
        var methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log', 'markTimeline', 'profile', 'profileEnd', 'markTimeline', 'table', 'time', 'timeEnd', 'timeStamp', 'trace', 'warn'];
        var length = methods.length;
        var console = window.console = {};
        while (length--) {
            console[methods[length]] = noop;
        }
    }());
}

var createNotification = function(message){
  console.log('creating notification')
  n = new Notification(message);
  n.display();
}

var failedLogin = function(response){
  // do user messaging here
  console.log('failedLogin',response);
}
var initUser = function(response){
  // user has confirmed, hide login buttons and create user
  console.log('initUser',response);
  doLogin(true);

  var accessToken = response.authResponse.accessToken;
  var signedRequest = response.authResponse.signedRequest
  var userID = response.authResponse.userID

  console.log('create user: ',accessToken, signedRequest);

  // create user
  $.ajax({
    type: 'POST',
    beforeSend: function(xhr,settings){
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    },
    url: "/oauth/callback",
    data: {'accessToken':accessToken,'userID':userID,'signedRequest':signedRequest},
    success: function(resp){
      console.log('oauth controller response',resp)
      if(resp.fbid != null){
        console.log('success',resp)
        // do whatever you need with this
        createNotification('thanks for logging in');
      }
    },
    error: function(){
      console.log("what have you done?");
    },
    complete: function(){
      console.log('response is complete')
    },
    dataType: 'json'
  });








}


var initLogin = function(e){
    FB.login(function(response) {
      (response.status == 'connected') ? initUser(response) : failedLogin(response);
    });
 } 

$(function(){
  // init login button
  $('.auth-loginlink').each(function(index, el){
    el.addEventListener('click', initLogin);
  })
});


window.fbAsyncInit = function() {
  // console.log('fbAsyncInit');
  FB.init({
    appId      : CLIENT_ID,
    channelUrl : '10.1.10.249/channel.html',
    status     : true,
    cookie     : true,
    oauth      : true,
    xfbml      : true
  });
  
  FB.getLoginStatus(function(response) {
    if (response.status === 'connected') {
      console.log('good');
      doLogin(true);
    } else if (response.status === 'not_authorized') {
      // has not auth app
      console.log('not auth');
      doLogin(false);
    } else {
      // has not logged into FB
      console.log('not logged');
      doLogin(false);
    }
  });



};
(function(d){
  var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement('script'); js.id = id; js.async = true;
  js.src = "//connect.facebook.net/en_US/all.js";
  ref.parentNode.insertBefore(js, ref);
}(document));

function doLogin(flag){
  // show/hide login buton
  (flag == true) ? $('.auth-loginlink').fadeOut('fast') : $('.auth-loginlink').fadeIn('fast');
}
