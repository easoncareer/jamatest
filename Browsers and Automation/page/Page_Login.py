from selenium.webdriver.common.by import By

from BasePage import BasePage


class LoginPage(BasePage):
    # Page Elements
    Login_username = (By.ID, 'j_username')
    Login_password = (By.ID, 'j_password')
    Login_button = (By.ID, 'loginButton')

    def set_username(self, username):
        login_username = self.driver.find_element(*LoginPage.Login_username)
        login_username.send_keys(username)

    def set_password(self, password):
        login_password = self.driver.find_element(*LoginPage.Login_password)
        login_password.send_keys(password)

    def click_submit(self):
        login_button = self.driver.find_element(*LoginPage.Login_button)
        login_button.click()

    def login(self, username, password):
        self.set_username(username)
        self.set_password(password)
        self.click_submit()
