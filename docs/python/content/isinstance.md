# 判断对象类型-isinstance

```PY 
# object -> Animal -> Dog -> Husky
# >>> a = Animal()
# >>> d = Dog()
# >>> h = Husky()

>>> isinstance(h, Husky)
True
>>> isinstance(h, Dog)
True
>>> isinstance(h, Animal)
True
>>> isinstance(d, Dog) and isinstance(d, Animal)
True

>>> isinstance(d, Husky)
False

```