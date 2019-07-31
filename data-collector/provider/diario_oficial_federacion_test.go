package provider

import (
	"fmt"
	"github.com/stretchr/testify/assert"
	"reflect"
	"testing"
	"time"
)

func TestGetDiarioFormattedDate(t *testing.T) {
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
	expectedFormattedDate := fmt.Sprintf("%s/%s/%d", day, month, date.Year())
	actualFormattedDate, actualDateTime := getDiarioFormattedDate()
	assert.Equal(t, expectedFormattedDate, actualFormattedDate)
	assert.Equal(t, reflect.TypeOf(date), reflect.TypeOf(actualDateTime))
}
