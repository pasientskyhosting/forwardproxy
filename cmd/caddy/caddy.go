package main

import (
	"github.com/caddyserver/caddy/caddy/caddymain"

	_ "github.com/captncraig/caddy-realip"
	_ "github.com/pasientskyhosting/forwardproxy"
)

func main() {
	caddymain.EnableTelemetry = false
	caddymain.Run()
}
