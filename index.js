var Alexa = require('alexa-sdk');

exports.handler = function(event, context, callback){
    var alexa = Alexa.handler(event, context, callback);
};

var handlers = {

    'LaunchRequest': function () {
        this.emit(':tell', 'If this is an emergency, Please call 911.');
    }

};
