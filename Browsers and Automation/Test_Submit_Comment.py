import unittest
from page import Page_Login, Page_Home, Page_Stream
from selenium import webdriver


class SubmitComment(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.get('https://testip.jamaland.com/login.req')
                          
    def tearDown(self):
        self.driver.close()

    def test_Submit_New_Comment(self):
        # Login Page
        login_page = Page_Login.LoginPage(self.driver)
        login_page.login('Sxu', 'password1')

        # Home Page
        home_page = Page_Home.HomePage(self.driver)
        home_page.click_menu_item('STREAM')

        # Stream Page
        stream_page = Page_Stream.SteamPage(self.driver)
        status, msg = stream_page.submit_comment('Test Comment from Selenium.')
        self.assertTrue(status, msg)

if __name__ == '__main__':
    unittest.main()
