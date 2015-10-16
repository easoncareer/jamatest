import time

from selenium.webdriver.common.by import By

from BasePage import BasePage


class SteamPage(BasePage):
    # Page Elements
    Stream_new_comment_div = (By.ID, "add-comment")
    Stream_new_comment_field = (By.ID, "js-add-comment-field")
    Stream_new_comment_field_actions = (By.ID, "js-add-comment-field-actions")
    Stream_new_comment_button = (By.XPATH, "//button/span[contains(text(),'Comment')]")
    Stream_comments = (By.ID, "comments")
    Stream_comment = (By.CLASS_NAME, "comment-wrap")

    def submit_comment(self, comment):
        try:
            comment = '%s - timestamp: %s' % (comment, int(time.time()))
            self.click_comment_div()
            self.set_stream_comment(comment)
            self.click_comment_button()
            return self.verify_new_comment(comment)
        except Exception as inst:
            return False, inst

    def click_comment_div(self):
        stream_new_comment_div = self.driver.find_element(*SteamPage.Stream_new_comment_div)
        self.highlight(stream_new_comment_div)
        stream_new_comment_field_actions = self.driver.find_element(*SteamPage.Stream_new_comment_field_actions)

        i = 0
        while stream_new_comment_field_actions.get_attribute('style') == 'display: none;':
            if i < 10:
                stream_new_comment_div.click()
                time.sleep(1)
                i += 1
            else:
                raise Exception("New comment field is invisible")

    def set_stream_comment(self, comment):
        stream_new_comment_field = self.driver.find_element(*SteamPage.Stream_new_comment_field)
        stream_new_comment_field.send_keys(comment)

    def click_comment_button(self):
        stream_new_comment_button = self.driver.find_element(*SteamPage.Stream_new_comment_button)
        stream_new_comment_button.click()
        time.sleep(1)

    def verify_new_comment(self, comment):
        stream_div_comment = self.driver.find_element(*SteamPage.Stream_comments)
        for comm in stream_div_comment.find_elements(*SteamPage.Stream_comment):
            if comment in comm.text:
                self.highlight(comm)
                return True, "New commnet submitted: %s" % comment
            else:
                return False, "New comment not found"
