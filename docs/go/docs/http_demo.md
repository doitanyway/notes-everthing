# http server简单demo


```go 
package main

import (
	"io"
	"log"
	"net/http"
)

func HelloServer(w http.ResponseWriter,req * http.Request)  {
	io.WriteString(w,"hello word!\n")
}
func main() {
	http.HandleFunc("/hello",HelloServer)
	log.Fatal(http.ListenAndServe(":12345",nil))
}

```