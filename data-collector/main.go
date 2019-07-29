package main

import (
	"database/sql"
	"fmt"
	"github.com/gorilla/mux"
	"io"
	"log"
	"net/http"
	"time"

	postgres "github.com/Kiraco/usd_to_mxn_exchange_rate/data-collector/data"
	provider "github.com/Kiraco/usd_to_mxn_exchange_rate/data-collector/provider"
)

func getDiarioOficialProvider(db *sql.DB) {
	provider := provider.GetDiarioOficialFederacionProvider()
	postgres.InsertInto("diario_oficial", provider, db)
}

func getFixerProvider(db *sql.DB) {
	provider := provider.GetFixerProvider()
	postgres.InsertInto("fixer", provider, db)
}

func getBanxicoProvider(db *sql.DB) {
	provider := provider.GetBanxicoProvider()
	postgres.InsertInto("banxico", provider, db)
}

func UpdateRates(w http.ResponseWriter, req *http.Request) {
	db := postgres.ConnectDB()
	defer db.Close()
	go getDiarioOficialProvider(db)
	go getFixerProvider(db)
	go getBanxicoProvider(db)
	time.Sleep(2 * time.Second)
	fmt.Fprintf(w, "Rates Updated!")
}

func GetRates(w http.ResponseWriter, req *http.Request) {
	tables := []string{"banxico", "fixer", "diario_oficial"}
	db := postgres.ConnectDB()
	defer db.Close()
	for _, table := range tables {
		tmpProvider := provider.Provider{}
		query := fmt.Sprintf("SELECT * FROM %s ORDER BY updatedAt DESC LIMIT 1", table)
		db.QueryRow(query).Scan(&tmpProvider)
		println(tmpProvider.ID.String())
		println(tmpProvider.Name)
		println(tmpProvider.Rate)
		println(tmpProvider.UpdatedAt)
	}
}

func Ping(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, "App running...!\n")
}

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/", Ping)
	router.HandleFunc("/update", UpdateRates).Methods("GET")
	router.HandleFunc("/rates", GetRates).Methods("GET")
	log.Fatal(http.ListenAndServe("8081", router))
}
