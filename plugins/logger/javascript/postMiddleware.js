/* --- postMiddleware.js --- */


// Create your middleware object, obj name must match filename
var postMiddleware = new TykJS.TykMiddleware.NewMiddleware({});

// Initialise it with your functionality by passing a closure that accepts two objects
// into the NewProcessRequest() function:
postMiddleware.NewProcessRequest(function(request, session, config) {

  log("JVM Middleware => Post Hook")

  // You MUST return both the request and session metadata
  return postMiddleware.ReturnData(request, session.meta_data);
});
