function Notification(message){
  this._message = message;
}

Notification.prototype.display = function() {
  // create element and inject
  this._display = document.createElement('div');
  this._display.className = 'notification-bar'
  msg = document.createTextNode(this._message);
  this._display.appendChild(msg)
  document.body.appendChild(this._display);
};