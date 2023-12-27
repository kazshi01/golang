package controller

import (
	"go_practice/model"
	"go_practice/usecase"
	"net/http"
	"os"
	"time"

	"github.com/labstack/echo/v4"
)

type IUserController interface {
	SignUp(c echo.Context) error
	LogIn(c echo.Context) error
	LogOut(c echo.Context) error
	CsrfToken(c echo.Context) error
}

type userController struct {
	uu usecase.IUserUsecase
}

func NewUserController(uu usecase.IUserUsecase) IUserController {
	return &userController{uu}
}

func (uc *userController) SignUp(c echo.Context) error {
	c.Logger().Info("SignUp called")
	user := model.User{}
	if err := c.Bind(&user); err != nil {
		c.Logger().Errorf("Error binding user: %v", err)
		return c.JSON(http.StatusBadRequest, err.Error())
	}
	userRes, err := uc.uu.SignUp(user)
	if err != nil {
		c.Logger().Errorf("Error signing up user: %v", err)
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	return c.JSON(http.StatusCreated, userRes)
}

func (uc *userController) LogIn(c echo.Context) error {
	c.Logger().Info("LogIn called")
	user := model.User{}
	if err := c.Bind(&user); err != nil {
		c.Logger().Errorf("Error binding user: %v", err)
		return c.JSON(http.StatusBadRequest, err.Error())
	}
	tokenString, err := uc.uu.Login(user)
	if err != nil {
		c.Logger().Errorf("Error logging in user: %v", err)
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	cookie := new(http.Cookie)
	cookie.Name = "token"
	cookie.Value = tokenString
	cookie.Expires = time.Now().Add(24 * time.Hour)
	cookie.Path = "/"
	cookie.Domain = os.Getenv("API_DOMAIN")
	cookie.Secure = true
	cookie.HttpOnly = true
	cookie.SameSite = http.SameSiteNoneMode
	c.SetCookie(cookie)
	return c.NoContent(http.StatusOK)
}

func (uc *userController) LogOut(c echo.Context) error {
	c.Logger().Info("LogOut called")
	cookie := new(http.Cookie)
	cookie.Name = "token"
	cookie.Value = ""
	cookie.Expires = time.Now()
	cookie.Path = "/"
	cookie.Domain = os.Getenv("API_DOMAIN")
	cookie.Secure = true
	cookie.HttpOnly = true
	cookie.SameSite = http.SameSiteNoneMode
	c.SetCookie(cookie)
	return c.NoContent(http.StatusOK)
}

func (uc *userController) CsrfToken(c echo.Context) error {
	c.Logger().Info("CsrfToken called")
	token := c.Get("csrf").(string)
	return c.JSON(http.StatusOK, echo.Map{
		"csrf_token": token,
	})
}
