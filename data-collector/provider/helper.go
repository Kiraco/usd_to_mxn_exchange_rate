package provider

import (
	"fmt"
	"time"
)

// GetDate - Gets Date format
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
