#  创建第一个django站点-自动化测试-逻辑测试



* ``polls/tests.py``,如下三个参数文件，测试Question类的was_published_recently方法

```py 
import datetime

from django.test import TestCase

# Create your tests here.
from django.utils import timezone

from polls.models import Question


class QuestionModelTests(TestCase):

    def test_was_published_recently_with_future_question(self):
        """
        was_published_recently() returns False for questions whose pub_date
        is in the future.
        """
        time = timezone.now() + datetime.timedelta(days=30)
        future_question = Question(pub_date=time)
        self.assertIs(future_question.was_published_recently(), False)

    def test_was_published_recently_with_old_question(self):
        """
        was_published_recently() returns False for questions whose pub_date
        is older than 1 day.
        """
        time = timezone.now() - datetime.timedelta(days=1, seconds=1)
        old_question = Question(pub_date=time)
        self.assertIs(old_question.was_published_recently(), False)

    def test_was_published_recently_with_recent_question(self):
        """
        was_published_recently() returns True for questions whose pub_date
        is within the last day.
        """
        time = timezone.now() - datetime.timedelta(hours=23, minutes=59, seconds=59)
        recent_question = Question(pub_date=time)
        self.assertIs(recent_question.was_published_recently(), True)
```


* 执行测试,报如下错误,表示执行test_was_published_recently_with_future_question的时候出了问题

```bash
nick@nicks-MacBook-Pro  ~/Desktop/study/python/mysite  python3 manage.py test polls
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
F..
======================================================================
FAIL: test_was_published_recently_with_future_question (polls.tests.QuestionModelTests)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/Users/nick/Desktop/study/python/mysite/polls/tests.py", line 20, in test_was_published_recently_with_future_question
    self.assertIs(future_question.was_published_recently(), False)
AssertionError: True is not False

----------------------------------------------------------------------
Ran 3 tests in 0.003s

FAILED (failures=1)
Destroying test database for alias 'default'...
```


* 修复问题  

```py 
    def was_published_recently(self):
        # 修复前代码
        # return self.pub_date >= timezone.now() - datetime.timedelta(days=1)
        now = timezone.now()
        return now - datetime.timedelta(days=1) <= self.pub_date <= now
```

* 重新执行测试代码,测试通过   

```bash 
 ✘ nick@nicks-MacBook-Pro  ~/Desktop/study/python/mysite  python3 manage.py test polls
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
...
----------------------------------------------------------------------
Ran 3 tests in 0.004s

OK
Destroying test database for alias 'default'...
```


https://docs.djangoproject.com/en/3.0/intro/tutorial05/


