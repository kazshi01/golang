package usecase

import (
	"go_practice/model"
	"go_practice/repository"
	"go_practice/validator"
	"os"
	"time"

	"github.com/golang-jwt/jwt/v4"
	"golang.org/x/crypto/bcrypt"
)

// IUserUsecase represents the interface of the user usecase（controllerにメソッドを渡す）
type IUserUsecase interface {
	SignUp(user model.User) (model.UserResponse, error) // Returns the user response and an error when signing up
	Login(user model.User) (string, error)              // Returns the token and an error when logging in
}

// userUsecase represents the struct of the user usecase（構造体）
type userUsecase struct {
	ur repository.IUserRepository
	uv validator.IUserValidator
}

// NewUserUsecase returns a new user usecase（初期化）
func NewUserUsecase(ur repository.IUserRepository, uv validator.IUserValidator) IUserUsecase {
	return &userUsecase{ur, uv}
}

// Create SignUp method
func (uu *userUsecase) SignUp(user model.User) (model.UserResponse, error) {
	// Email,Passwordのバリデーション確認
	if err := uu.uv.UserValidate(user); err != nil {
		return model.UserResponse{}, err
	}
	// Hash the password (security cost: 10)
	hash, err := bcrypt.GenerateFromPassword([]byte(user.Password), 10)
	if err != nil {
		return model.UserResponse{}, err
	}
	// use CreateUser method from repository, generate new user
	newUser := model.User{Email: user.Email, Password: string(hash)}
	if err := uu.ur.CreateUser(&newUser); err != nil {
		return model.UserResponse{}, err
	}
	// return new user's ID and email
	resUser := model.UserResponse{
		ID:    newUser.ID,
		Email: newUser.Email,
	}
	return resUser, nil
}

// Create Login method
func (uu *userUsecase) Login(user model.User) (string, error) {
	// Email,Passwordのバリデーション確認
	if err := uu.uv.UserValidate(user); err != nil {
		return "", err
	}
	//　Get the user by email
	storedUser := model.User{}
	if err := uu.ur.GetUserByEmail(&storedUser, user.Email); err != nil {
		return "", err
	}
	// Compare the passwords
	if err := bcrypt.CompareHashAndPassword([]byte(storedUser.Password), []byte(user.Password)); err != nil {
		return "", err
	}
	// Create a new token（本人証明書の発行）
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"user_id": storedUser.ID,
		"exp":     time.Now().Add(time.Hour * 12).Unix(),
	})
	// Sign the token with the secret（"SECRET"で署名）
	tokenString, err := token.SignedString([]byte(os.Getenv("SECRET")))
	if err != nil {
		return "", err
	}
	return tokenString, nil
}
