package main

import (
	"fmt"

	provider "github.com/Kiraco/usd_to_mxn_exchange_rate/data-collector/provider"
)

func main() {
	diarioOficial := provider.GetDiarioOficialDeLaFederacion()
	fmt.Println(diarioOficial.Name)
	fmt.Println(diarioOficial.Rate)
	fmt.Println(diarioOficial.UpdatedAt)
}
