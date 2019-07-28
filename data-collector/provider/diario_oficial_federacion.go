package provider

import (
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"regexp"
	"strings"
)

func getTodaysDiarioRate() string {
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
	var validValue = regexp.MustCompile(`(\d{2}\.{1}\d{4}){1}`)
	match := validValue.FindString(string(body))
	return match
}

// GetDiarioOficialFederacionProvider - returns diario oficial provider
func GetDiarioOficialFederacionProvider() Provider {
	return Provider{
		Name:      "Diario Oficial de la Federacion",
		Rate:      getTodaysDiarioRate(),
		UpdatedAt: getDate(),
	}
}
