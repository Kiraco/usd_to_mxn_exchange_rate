package main

import (
	"fmt"
	"time"

	provider "github.com/Kiraco/usd_to_mxn_exchange_rate/data-collector/provider"
)

func getDiarioOficialProvider() {
	diarioOficial := provider.GetDiarioOficialFederacionProvider()
	fmt.Println(diarioOficial.Name)
	fmt.Println(diarioOficial.Rate)
	fmt.Println(diarioOficial.UpdatedAt)
}

func getFixerProvider() {
	fixer := provider.GetFixerProvider()
	fmt.Println(fixer.Name)
	fmt.Println(fixer.Rate)
	fmt.Println(fixer.UpdatedAt)
}

func main() {
	go getDiarioOficialProvider()
	go getFixerProvider()
	time.Sleep(2 * time.Second)
}
