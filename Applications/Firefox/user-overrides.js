user_pref("_user.js.parrot", "overrides section syntax error");

/*** Tuning user.js defaults ***/
// https://github.com/arkenfox/user.js/wiki/1.3-Implementation
user_pref("browser.safebrowsing.downloads.remote.enabled", true); // 0401
user_pref("browser.safebrowsing.downloads.remote.url", "https://sb-ssl.google.com/safebrowsing/clientreport/download?key=%GOOGLE_API_KEY%"); // 0401
user_pref("privacy.clearOnShutdown.cookies", true); // 2811

/*** Moar security ***/
user_pref("fission.autostart", true);

/*** Firefox experience ***/
user_pref("keyword.enabled", true); // 0801
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.download.forbid_open_with", true); //5009
user_pref("signon.rememberSignons", false); //5003

/*** For Twitch ***/
user_pref("gfx.webrender.all", true);

user_pref("_user.js.parrot", "SUCCESS loaded user-overrides.js");