// config/auth.js

// expose our config directly to our application using module.exports
module.exports = {

    'facebookAuth' : {
        'clientID'      : '303124383478479', // your App ID
        'clientSecret'  : '06da670ab8151c3ea025ee0e155db698', // your App Secret
        'callbackURL'   : 'https://thecloset.herokuapp.com/auth/facebook/callback'
    },

    'twitterAuth' : {
        'consumerKey'       : 'xYYbi5wbSPYaqMJZdXNpCEZds',
        'consumerSecret'    : 'j8SZVC7T34g7Qg1FwT9mg9eoF4qA9S9T4FHG1JuRP3YRWS8MjK',
        'callbackURL'       : 'https://thecloset.herokuapp.com/auth/twitter/callback'
    },

    'googleAuth' : {
        'clientID'      : '394445068141-d9aooue3m5jcc0t5h8citb8hgn5mtkjh.apps.googleusercontent.com',
        'clientSecret'  : 'yuF4sW8VJoWfSfr-cm1K-k1H',
        'callbackURL'   : 'https://thecloset.herokuapp.com/auth/google/callback'
    }

};
