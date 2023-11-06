package main

import (
	"fmt"
	"go_practice/db"
	"go_practice/model"
)

// main migrates the database
func main() {
	dbConn := db.NewDb()
	defer fmt.Println("Succcessfully migrated database")
	defer db.CloseDB(dbConn)
	dbConn.AutoMigrate(&model.User{}, &model.Task{})
}
