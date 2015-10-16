## Browsers and Automation

A. Find the id of the Jama logo image on the Jama login page
```html
id="j-homescreen-logo"
```
B. Find the full version of Jama. Hint: it’s hidden in the DOM. What is the element’s classname it is hidden under?


```html
<!--
    <span class="j-login-version">Version: 4.5.3 r5699d17</span><br/>
-->

<!--
    <span class="j-login-version">Version:
        <span class="j-login-version-number">
            2015.1
        </span>
    </span>
-->
```
```html
class: j-login-version
```


C. Write a basic automated script that will perform the following steps. You may use any language or flavor of Selenium. Do not spend more than 4 hours on this portion; feel free to turn in any unfinished work. You may zip up and email your code, or give us a link to your repository 
1. Log into Jama 
2. Navigate to the Stream
3. Add a comment to the stream 
4. Verify the comment shows up in the stream

### How to

 1. Clone script to local
 2. Go to the directory in Terminal/Shell and run `python Test_Submit_Comment.py`

### Notes

 - [Firefox](http://www.mozilla.org/firefox/) and [Python](https://www.python.org/) need to be installed in order to run the test
