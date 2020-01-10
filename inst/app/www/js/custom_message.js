// the event handler listens to shiny for messages send by handler1
// if it receives a message, call the callback function doAwesomething and pass the message
Shiny.addCustomMessageHandler("handler1", awesomeMessage );

// this function is called by the handler, which passes the message
function awesomeMessage(message){
  
  // show the messsage as an alert
  Swal.fire(
  'Good job!',
  'You clicked the button!',
  'success'
);
}