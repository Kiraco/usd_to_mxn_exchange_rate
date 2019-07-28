package provider

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"regexp"
	"strings"
	"time"
)

func getDate() string {
	date := time.Now()
	day := ""
	month := ""
	if date.Day() < 10 {
		day = fmt.Sprintf("%d%d%s", 0, date.Day(), "/")
	} else {
		day = fmt.Sprintf("%d%s", date.Day(), "/")
	}
	if date.Month() < 10 {
		month = fmt.Sprintf("%d%d%s", 0, date.Month(), "/")
	} else {
		month = fmt.Sprintf("%d%s", date.Month(), "/")
	}
	fmt.Println(day)
	return fmt.Sprintf("%s%s%d", "26/", month, date.Year())
}

func getTodaysRate() string {
	apiURL := "http://www.banxico.org.mx/tipcamb/tipCamIHAction.do"
	data := url.Values{}
	dateString := getDate()
	data.Set("idioma", "sp")
	data.Set("fechaInicial", dateString)
	data.Set("fechaFinal", dateString)
	data.Set("salida", "HTML")

	client := &http.Client{}
	r, err := http.NewRequest("POST", apiURL, strings.NewReader(data.Encode())) // URL-encoded payload
	if err != nil {
		println(err)
	}
	r.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	r.Header.Add("Access-Control-Allow-Origin", "*")

	resp, err := client.Do(r)
	if err != nil {
		println(err)
	}
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Printf("Error reading body: %v", err)
	}
	fmt.Println(string(body))
	var validValue = regexp.MustCompile(`(\d{2}\.{1}\d{4}){1}`)
	match := validValue.FindString(string(body))
	return match
}

func GetDiarioOficialFederacionProvider() Provider {
	return Provider{
		Name:      "Diario Oficial de la Federacion",
		Rate:      getTodaysRate(),
		UpdatedAt: getDate(),
	}
}
