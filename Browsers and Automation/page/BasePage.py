import time


class BasePage(object):
    def __init__(self, driver):
        self.driver = driver
        self.driver.implicitly_wait(5)
        self.timeout = 30

    def highlight(self, element, last=0):
        driver = element.parent

        def apply_style(s):
            driver.execute_script("arguments[0].setAttribute('style', arguments[1]);", element, s)

        original_style = element.get_attribute('style')
        apply_style("background: yellow; border: 2px solid red;")
        time.sleep(.2)
        apply_style(original_style)
        time.sleep(.2)
        apply_style("background: yellow; border: 2px solid red;")
        time.sleep(.2)
        apply_style(original_style)
        time.sleep(.2)
        apply_style("background: yellow; border: 2px solid red;")
        time.sleep(last)
        apply_style(original_style)
