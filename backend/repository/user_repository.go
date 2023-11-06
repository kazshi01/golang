package repository

import (
	"go_practice/model"

	"gorm.io/gorm"
)

// IUserRepository represents the interface of the user repository（usecaseにメソッドを渡す）
type IUserRepository interface {
	GetUserByEmail(user *model.User, email string) error // Get user by email
	CreateUser(user *model.User) error                   // Create user
}

type userRepository struct {
	db *gorm.DB
}

func NewUserRepositry(db *gorm.DB) IUserRepository {
	return &userRepository{db}
}

func (ur *userRepository) GetUserByEmail(user *model.User, email string) error {
	if err := ur.db.Where("email = ?", email).First(user).Error; err != nil {
		return err
	}
	return nil
}

func (ur *userRepository) CreateUser(user *model.User) error {
	if err := ur.db.Create(user).Error; err != nil {
		return err
	}
	return nil
}
