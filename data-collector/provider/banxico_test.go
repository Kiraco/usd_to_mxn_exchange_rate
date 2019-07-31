package provider

import (
	"fmt"
	"github.com/stretchr/testify/assert"
	"reflect"
	"testing"
	"time"
)

func TestGetBanxicoFormattedDate(t *testing.T) {
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
	expectedFormattedDate := fmt.Sprintf("%d-%s-%s", date.Year(), month, day)
	actualFormattedDate, actualDateTime := getBanxicoFormattedDate()
	assert.Equal(t, expectedFormattedDate, actualFormattedDate)
	assert.Equal(t, reflect.TypeOf(date), reflect.TypeOf(actualDateTime))
}
