exports.handler = (event, context) =>{
  try {
    if (event.session.new) {
      // new session
      console.log("New Session");
    }

    switch (event.request.type) {
      //Launch request
      case "LaunchRequest":
      console.log("Launch Request");
        context.succeed(
          generateResponse(
            buildSpeechletResponse("If this is an emergency, Please call 911.", false),
          {}
        )
      );
      break;

      case "IntentRequest":
      // Intent request
      console.log("Intent Request");
      break;

      case "SessionEndedRequest":
      // Session Ended request
      console.log("Session Ended Request");
      break;

      default:
        context.fail("Invalid Request Type: ${event.request.type}");
      }

    } catch(error) { context.fail(`Exception: ${error}`)}

};



//helpers
BuildSpeechletResponse = (outputText, shouldEndSession) => {
  return{
    outputSpeech: {
      "type": "PlainText",
      text: "outputText"
    },
    shouldEndSession: "Should End Session"
  };

};

generate.responses = (sessionAttributes, speechletResponse) => {

  return {
    version: "1.0",
    sessionAttributes: sessionattributes,
    response: speechletResponse
  };
};
