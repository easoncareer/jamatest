from selenium.webdriver.common.by import By

from BasePage import BasePage


class HomePage(BasePage):
    # Page Elements
    Home_top_menu = (By.ID, "j-header-tab-ct")

    def click_menu_item(self, menu_item):
        home_top_menu = self.driver.find_element(*HomePage.Home_top_menu)
        for item in home_top_menu.find_elements_by_tag_name("li"):
            if menu_item in item.text:
                item.click()
                break
