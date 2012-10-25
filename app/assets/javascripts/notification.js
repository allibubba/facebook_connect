function Notification(message){
  this._message = message;
}

Notification.prototype.display = function() {
  // create element and inject
  this.display = document.createElement('div');
  this.display.className = 'notification-bar'
  msg = document.createTextNode(this._message);
  this.display.appendChild(msg)
  document.body.appendChild(this.display);
};