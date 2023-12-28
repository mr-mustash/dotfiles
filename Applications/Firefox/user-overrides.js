user_pref("_user.js.parrot", "overrides section syntax error");

/*** Tuning user.js defaults ***/
// https://github.com/arkenfox/user.js/wiki/1.3-Implementation
user_pref("browser.safebrowsing.downloads.remote.enabled", true); // 0403
user_pref(
  "browser.safebrowsing.downloads.remote.url",
  "https://sb-ssl.google.com/safebrowsing/clientreport/download?key=%GOOGLE_API_KEY%"
); // 0403

/*** Moar security ***/
user_pref("media.peerconnection.enabled", false); // 2001
user_pref("media.peerconnection.ice.no_host", true); // 2020
user_pref("signon.rememberSignons", false); // 5003
user_pref("browser.download.forbid_open_with", true); // 5009
user_pref("dom.popup_allowed_events", "click dblclick mousedown pointerdown"); // 5017
user_pref("browser.pagethumbnails.capturing_disabled", true); // 5018
user_pref("javascript.options.ion", false); // 5505
user_pref("javascript.options.baselinejit", false); // 5505
user_pref("javascript.options.jit_trustedprincipals", true); // 5505
user_pref("javascript.options.wasm", false); // 5506

/*** DNS over HTTPS ***/
user_pref("network.trr.uri", "https://dns.nextdns.io/3ba7c2");
user_pref("network.trr.custom_uri", "https://dns.nextdns.io/3ba7c2");
user_pref("network.trr.mode", 3);
user_pref("network.dns.echconfig.enabled", true);
user_pref("network.dns.use_https_rr_as_altsvc", true);

/*** Firefox experience ***/
user_pref("keyword.enabled", true); // 0801
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.topsites", false);

/*** Use GPU ***/
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.software", false);
user_pref("gfx.webrender.software.d3d11", false);

/*** Speeding up Firefox ***/
user_pref("network.http.pipelining", true);
user_pref("network.http.proxy.pipelining", true);
user_pref("network.http.pipelining.maxrequests", 10);
user_pref("nglayout.initialpaint.delay", 0);

user_pref("_user.js.parrot", "SUCCESS loaded user-overrides.js");
