package provider

import (
	"fmt"
	"github.com/google/uuid"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"regexp"
	"strings"
	"time"
)

const (
	diarioBaseURL = "http://www.banxico.org.mx/tipcamb/tipCamIHAction.do"
)

func getDiarioFormattedDate() string {
	date := time.Now()
	day := ""
	month := ""
	if date.Day() < 10 {
		day = fmt.Sprintf("%d%d", 0, date.Day())
	} else {
		day = fmt.Sprintf("%d", date.Day())
	}
	if date.Month() < 10 {
		month = fmt.Sprintf("%d%d", 0, date.Month())
	} else {
		month = fmt.Sprintf("%d", date.Month())
	}
	fmt.Println(day)
	return fmt.Sprintf("%s/%s/%d", "26", month, date.Year())
}

func getTodaysDiarioRate() string {
	data := url.Values{}
	dateString := getDiarioFormattedDate()
	data.Set("idioma", "sp")
	data.Set("fechaInicial", dateString)
	data.Set("fechaFinal", dateString)
	data.Set("salida", "HTML")

	client := &http.Client{}
	r, err := http.NewRequest("POST", diarioBaseURL, strings.NewReader(data.Encode()))
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
		ID:        uuid.New(),
		Name:      "Diario Oficial de la Federacion",
		Rate:      getTodaysDiarioRate(),
		UpdatedAt: getDiarioFormattedDate(),
	}
}
