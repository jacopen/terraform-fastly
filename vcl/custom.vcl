
sub vcl_recv {
  if (req.restarts == 0) {
    if (!req.http.X-Timer) {
      set req.http.X-Timer = "S" time.start.sec "." time.start.usec_frac;
    }
    set req.http.X-Timer = req.http.X-Timer ",VS0";
  }

  declare local var.fastly_req_do_shield BOOL;
  set var.fastly_req_do_shield = (req.restarts == 0);

  if (req.url ~ "^/ui(/[^?]*)?(\?.*)?$"){
    set req.url = regsub(req.url, "/ui", "/");
    set req.backend = F_ui;
  } elseif (req.url ~ "^/(/[^?]*)?(\?.*)?$") {
    set req.backend = F_website;
  }
  if (req.url ~ "\/$") {
    set req.url = req.url "index.html";
  }
  if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
    return(pass);
  }
  return(lookup);
}
