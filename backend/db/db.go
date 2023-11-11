package db

import (
	"fmt"
	"log"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// NewDb creates a new database connection
func NewDb() *gorm.DB {
	url := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=require",
		os.Getenv("DATABASE_HOST"), os.Getenv("DATABASE_USER"),
		os.Getenv("DATABASE_PASSWORD"), os.Getenv("DATABASE_NAME"),
		os.Getenv("DATABASE_PORT"))
	db, err := gorm.Open(postgres.Open(url), &gorm.Config{})
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("Connected to database")
	return db
}

// CloseDB closes the database connection
func CloseDB(db *gorm.DB) {
	sqlDB, err := db.DB()
	if err != nil {
		log.Fatalln("Error retrieving sql.DB:", err)
	}

	if err := sqlDB.Close(); err != nil {
		log.Fatalln(err)
	}
}
