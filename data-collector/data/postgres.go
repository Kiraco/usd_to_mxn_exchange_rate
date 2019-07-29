package data

import (
	_ "github.com/lib/pq"

	"database/sql"
	"fmt"
	provider "github.com/Kiraco/usd_to_mxn_exchange_rate/data-collector/provider"
)

const (
	host     = "raja.db.elephantsql.com"
	user     = "qfdzwxrh"
	password = "PEmibq-PXzzFiEpMV9iHWQbYO4JHqpIy"
	dbName   = "qfdzwxrh"
	port     = "5432"
)

//ConnectDB connects to db
func ConnectDB() *sql.DB {
	psqlInfo := fmt.Sprintf("host=%s port=%s user=%s "+
		"password=%s dbname=%s sslmode=disable", host, port, user, password, dbName)
	database, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}

	err = database.Ping()
	if err != nil {
		panic(err)
	}
	return database
}

//InsertInto inserts into table
func InsertInto(table string, prov provider.Provider, database *sql.DB) {
	sqlStatement := `
		INSERT INTO ` + table + ` ("id", "name", "rate", "updatedAt")
		VALUES ($1, $2, $3, $4)
	`
	_, err := database.Query(sqlStatement, prov.ID, prov.Name, prov.Rate, prov.UpdatedAt)
	if err != nil {
		panic(err)
	}
}
