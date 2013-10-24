// Generated by CoffeeScript 1.6.2
module.exports = function() {
  var getGraphMeta, getHomeIntro, getScripts, getSidebar, getStyles;

  getHomeIntro = require('./../homeintro');
  getStyles = require('./../styleblock');
  getScripts = require('./../scriptblock');
  getGraphMeta = require('./../graphmeta');
  getSidebar = require('./sidebar');
  return "<!doctype html>\n<html lang=\"en\" prefix=\"og: http://ogp.me/ns#\">\n<head>\n  <title>Koding</title>\n  " + (getStyles()) + "\n  " + (getGraphMeta()) + "\n</head>\n<body class='koding'>\n\n\n  <script>(function(){window.location.href='/unsupported.html'})();</script>\n\n\n  <div class=\"kdview home\" id=\"kdmaincontainer\">\n    <div id=\"invite-recovery-notification-bar\" class=\"invite-recovery-notification-bar hidden\"></div>\n    <header class=\"kdview\" id='main-header'>\n      <div class=\"kdview\">\n        <a id=\"koding-logo\" href=\"#\" class='large'><span></span></a>\n        <a id=\"header-sign-in\" class=\"custom-link-view login\" href=\"#!/Login\"><span class=\"title\" data-paths=\"title\">Already a user? Sign In.</span><span class=\"icon\"></span></a>\n      </div>\n    </header>\n    " + (getHomeIntro()) + "\n    <section class=\"kdview\" id=\"main-panel-wrapper\">\n      " + (getSidebar()) + "\n      <div class=\"kdview\" id=\"content-panel\">\n        <div class=\"kdview kdscrollview kdtabview\" id=\"main-tab-view\">\n          <div id='maintabpane-home' class=\"kdview content-area-pane activity content-area-new-tab-pane clearfix kdtabpaneview active\">\n            <div id=\"content-page-home\" class=\"kdview content-page home kdscrollview extra-wide\">\n              <div id='featured-activities-container' class=\"kdview activity-content feeder-tabs\">\n                <div class=\"kdview listview-wrapper\">\n                  <div class=\"kdview feeder-header clearfix\"><span>What's going on in the Koding Community</span></div>\n                  <div class=\"kdview kdscrollview\">\n                    <div class=\"kdview kdlistview kdlistview-default activity-related\"></div>\n                    <div class=\"lazy-loader\">Loading...</div>\n                  </div>\n                </div>\n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </section>\n  </div>\n\n" + (KONFIG.getConfigScriptTag({
    roles: ['guest'],
    permissions: []
  })) + "\n" + (getScripts()) + "\n</body>\n</html>";
};
