if (req.url.path ~ "^/ui/.*") {
  set bereq.url = "/";
}