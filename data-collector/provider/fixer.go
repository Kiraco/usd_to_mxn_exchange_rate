package provider

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"time"
)

const (
	baseURL  = "http://data.fixer.io/api/"
	apiKey   = "?access_key=9b8dd1de33a10e6362f5b769359896c9"
	endPoint = "latest"
	symbols  = "&symbols=USD,MXN"
)

func getTodaysFixerRate() (rate string, date string) {
	apiURL := baseURL + endPoint + apiKey + symbols
	r, err := http.Get(apiURL)
	if err != nil {
		fmt.Println(err)
	}
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		log.Printf("Error reading body: %v", err)
	}

	var dat map[string]interface{}
	if err := json.Unmarshal(body, &dat); err != nil {
		panic(err)
	}
	timestamp := dat["timestamp"].(float64)
	formatedDate := time.Unix(int64(timestamp), 0).Format("02/01/2006")
	rates := dat["rates"].(map[string]interface{})
	mxn := rates["MXN"].(float64)
	usd := rates["USD"].(float64)

	return fmt.Sprintf("%f", mxn/usd), formatedDate
}

//GetFixerProvider - returns fixer provider
func GetFixerProvider() Provider {
	rate, date := getTodaysFixerRate()
	return Provider{
		Name:      "Fixer",
		Rate:      rate,
		UpdatedAt: date,
	}
}
