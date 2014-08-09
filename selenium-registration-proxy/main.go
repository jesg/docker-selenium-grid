package main

import (
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"net/url"
	"time"
)

type Capabilities struct {
	BrowserName      string `json:"browserName"`
	MaxInstances     int    `json:"maxInstances"`
	SeleniumProtocol string `json:"seleniumProtocol"`
}

type Configuration struct {
	Hub           string `json:"hub"`
	HubHost       string `json:"hubHost"`
	HubPort       int    `json:"hubPort"`
	MaxSession    int    `json:"maxSession"`
	Port          int    `json:"port"`
	Proxy         string `json:"proxy"`
	Register      bool   `json:"register"`
	RegisterCycle int    `json:"registerCycle"`
	RemoteHost    string `json:"remoteHost"`
	Role          string `json:"role"`
	Url           string `json:"url"`
}

type RegistrationRequest struct {
	Capabilities  []Capabilities `json:"capabilities"`
	Configuration Configuration  `json:"configuration"`
}

type registrationRequest struct {
	request  *RegistrationRequest
	response chan *http.Response
}

func main() {
	// Parse args
	port := flag.Int("port", 4444, "Port on which the proxy will listen")
	hub := flag.String("hub", "", "Hub host (http://localhost:4444/)")
	node := flag.String("node", "", "Node host (http://localhost:5555/)")
	flag.Parse()

	hubRegistrationUrl := *hub + "/grid/register"

	c := make(chan registrationRequest)
	// Registration routine
	go func() {
		var registration *RegistrationRequest
		var ticker *time.Ticker
		var tickerC <-chan time.Time
		nodeUrl, _ := url.Parse(*node)
		for {
			select {
			case <-tickerC:
				if registration != nil {
					// Test if the node is still listening
					_, err := net.Dial("tcp", nodeUrl.Host)
					if err == nil {
						// Register
						data, _ := json.Marshal(registration)
						http.Post(hubRegistrationUrl, "application/json", bytes.NewBuffer(data))
					} else {
						log.Printf("Node is not listening on %s, unregistering it", nodeUrl.Host)
						// Unregister
						registration.Configuration.Register = false
						data, _ := json.Marshal(registration)
						http.Post(hubRegistrationUrl, "application/json", bytes.NewBuffer(data))
						// Stop ticker
						ticker.Stop()
						tickerC = nil
					}
				}
			case reg := <-c:
				// Save registration request
				registration = reg.request
				if registration != nil {
					// Register
					log.Printf("Registering node on hub: %s", nodeUrl.Host)
					data, _ := json.Marshal(registration)
					res, err := http.Post(hubRegistrationUrl, "application/json", bytes.NewBuffer(data))
					if err != nil {
						panic(err)
					}
					// Forward the registration reply to the node
					reg.response <- res
					// Start ticker
					ticker = time.NewTicker(time.Duration(registration.Configuration.RegisterCycle) * time.Millisecond)
					tickerC = ticker.C
				} else {
					// Stop ticker
					ticker.Stop()
					tickerC = nil
				}
			}
		}
	}()

	http.HandleFunc("/grid/register", func(w http.ResponseWriter, r *http.Request) {
		// Decode the request
		data, err := ioutil.ReadAll(r.Body)
		if err != nil {
			log.Fatal(err)
			return
		}
		var registration RegistrationRequest
		err = json.Unmarshal(data, &registration)
		if err != nil {
			log.Fatal(err)
			return
		}

		// Override "RemoteHost" and "Url"
		registration.Configuration.RemoteHost = *node
		registration.Configuration.Url = *node

		// Register
		var registrationRequest registrationRequest = registrationRequest{&registration, make(chan *http.Response)}
		c <- registrationRequest
		data, _ = ioutil.ReadAll((<-registrationRequest.response).Body)
		w.Write(data)
	})

	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", *port), nil))
}
