package provider

import (
	"fmt"
	"github.com/google/uuid"
	"io/ioutil"
	"log"
	"net/http"
	"regexp"
	"time"
)

const (
	baseURL = "https://www.banxico.org.mx/SieAPIRest/service/v1/series/SF43718/datos/"
	token   = "a3dff2a684d2cea59e6abb5a69ebfefd2b3c1ed7c6635fd905837abb97098d2c"
)

func getBanxicoFormattedDate() (api string, db time.Time) {
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
	return fmt.Sprintf("%d-%s-%s", date.Year(), month, day), date
}

func getTodaysBanxicoRate() string {
	date, _ := getBanxicoFormattedDate()
	apiURL := baseURL + date + "/" + date + "/?token=" + token
	r, err := http.Get(apiURL)
	if err != nil {
		fmt.Println(err)
	}
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		log.Printf("Error reading body: %v", err)
	}
	var validValue = regexp.MustCompile(`(\d{2}\.{1}\d{4}){1}`)
	match := validValue.FindString(string(body))
	return match
}

// GetBanxicoProvider - gets Banxico provider
func GetBanxicoProvider() Provider {
	_, date := getBanxicoFormattedDate()
	return Provider{
		ID:        uuid.New(),
		Name:      "Banxico",
		Rate:      getTodaysBanxicoRate(),
		UpdatedAt: date,
	}
}
