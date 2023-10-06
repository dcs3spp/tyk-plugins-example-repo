/* --- preMiddleware.js --- */


// Create your middleware object, obj name must match filename
var preMiddleware = new TykJS.TykMiddleware.NewMiddleware({});

// Initialise it with your functionality by passing a closure that accepts two objects
// into the NewProcessRequest() function:
preMiddleware.NewProcessRequest(function(request, session, config) {

  log("JVM Middleware => Pre Hook")

  // You MUST return both the request and session metadata
  return preMiddleware.ReturnData(request, session.meta_data);
});
