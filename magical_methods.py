# Finding some of the magical methods. Which one I don't understand yet
class MyClass:
    def __init__(self):
        pass


obj = MyClass()
# Get a list of attributes and methods
methods = [method for method in dir(obj) if callable(getattr(obj, method))]
# print(methods)


# 1 '__init__', Common used magical method. Which initialized values inside the object of class.
# By default, do not wait for values
class MyInit:
    def __init__(self):
        pass


init_obj = MyInit


# print(init_obj)


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 2 '__repr__', -
# Primary purpose of __repr__ is to provide a clear and unambiguous string representation of an object for developers.
# It's meant for debugging and development.
class MyRepr:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __repr__(self):
        return f"MyClass(name={self.name}, age={self.age})"


repr_obj = MyRepr("John", 25)


# print(repr(repr_obj))  # Output: MyClass(name=John, age=25)


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 3 '__str__', Doing the same that __repr__. But have higher priority. So string from this method will be shown first.
class Banknote:
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return f'Banknote for regular people with nominal {self.value}'

    def __repr__(self):
        return f"Banknote({self.value})"


bill = Banknote(100)


# print(bill)
# print(f"{bill!r}")
# print(repr(bill))


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 4 '__getitem__', '__setitem__'
# Main purpose make object subscriptable.
# In this case we be able to use our object like sequences of objects,
# like list[] for example and gate item by their index
# __setitem__ allow us change object by they index number
class MyList:
    def __init__(self):
        self.data = []

    def __getitem__(self, index):
        # Implement behavior for indexing
        return self.data[index]

    def __setitem__(self, index, value):
        # Implement behavior for setting values
        self.data[index] = value

    def __len__(self):
        # Implement the __len__ method for len() function
        return len(self.data)

    def __repr__(self):
        # Implement the __repr__ method for string representation
        return repr(self.data)


# Create an instance of MyList
my_list = MyList()
# Add elements to the list
my_list.data.extend([1, 2, 3, 4, 5])
# Access elements using the __getitem__ method

# print("Element at index 2:", my_list[2])

# Modify an element using the __setitem__ method
my_list[1] = 10
# Display the updated list

# print("Updated List:", my_list)

# Use len() function with the __len__ method

# print("Length of the list:", len(my_list))


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 5 '__eq__', Method which explain how to check for equality of your objects.
# By default, your object will be checked by their number address
class DoesItEqual:
    def __init__(self, value):
        self.value = value

    def __eq__(self, other):
        if other is None or not isinstance(other, DoesItEqual):
            return False
        return self.value == other.value


eq_first = DoesItEqual(50)
eq_second = DoesItEqual(50)


# print(eq_first==eq_second)


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 6 '__gt__', Greater than. Explain how to use '>' when comparing objects
class DoesItGreater:
    def __init__(self, value):
        self.value = value

    def __gt__(self, other):
        if other is None or not isinstance(other, DoesItGreater):
            return False
        return self.value > other.value


gt_first = DoesItGreater(45)
gt_second = DoesItGreater(50)


# print(gt_first>gt_second)


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 7 '__ge__', Greater or equal. Explain how to use '>=' when comparing objects
class DoesItGreaterOrEqual:
    def __init__(self, value):
        self.value = value

    def __ge__(self, other):
        if other is None or not isinstance(other, DoesItGreaterOrEqual):
            return False
        return self.value >= other.value


ge_first = DoesItGreaterOrEqual(51)
ge_second = DoesItGreaterOrEqual(50)


# print(ge_first>=ge_second)


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 8 '__lt__', Less then. Explain how to use '<' when comparing objects
class DoesItLess:
    def __init__(self, value):
        self.value = value

    def __lt__(self, other):
        if other is None or not isinstance(other, DoesItLess):
            return False
        return self.value < other.value


lt_first = DoesItLess(49)
lt_second = DoesItLess(50)


# print(lt_first<lt_second)


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 9 '__le__', Less or equal. Explain how to use '<=' when comparing objects
class DoesItLessOrEqual:
    def __init__(self, value):
        self.value = value

    def __le__(self, other):
        if other is None or not isinstance(other, DoesItLessOrEqual):
            return False
        return self.value <= other.value


le_first = DoesItLessOrEqual(50)
le_second = DoesItLessOrEqual(50)
# print(le_first <= le_second)


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 10 '__contains__'. Method realize opportunity using "in". So we can easily find object inside object.
class MyContainer:
    def __init__(self):
        self.data = []

    def __contains__(self, value):
        # Define the behavior for the 'in' operator
        return value in self.data


# Example usage:
container = MyContainer()
container.data = [1, 2, 3, 4, 5]

# Using the 'in' operator with __contains__
# print(3 in container)  # Output: True
# print(6 in container)  # Output: False


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 11 '__bool__'. Boll method is used to define the truth value of an object.
# By default, even pass object will be always True.
class MyBool:
    def __init__(self, value):
        self.value = value

    def __bool__(self):
        # Define the truth value of the object
        return self.value > 0


# Example usage:
bool_obj1 = MyBool(5)
bool_obj2 = MyBool(0)

# Using bool() with __bool__
# print(bool(bool_obj1))  # Output: True
# print(bool(bool_obj2))  # Output: False


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 12 '__len__'. Method len return an error if it wasn't be used in class definition.
# It's need to define length of our object.
class MyLength:
    def __init__(self):
        self.data = []

    def __len__(self):
        # Define the length of the container
        return len(self.data)


# Example usage:
container = MyLength()
container.data = [1, 2, 3, 4, 5]

# Using len() with __len__
length_of_container = len(container)
# print("Length of container:", length_of_container)


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 13 '__call__'. Method call allow us to use our class like function(make it callable).
# In this case it return what we describe in out __call__ method.
class CallableClass:
    def __call__(self, *args, **kwargs):
        # Define the behavior when the object is called
        print("Object was called with arguments:", args)
        print("Keyword arguments:", kwargs)


# Example usage:
callable_instance = CallableClass()

# Calling the instance as if it were a function
# callable_instance(1, 2, 3, name="John")


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 14 '__iter__', '__next__'.
# Method is a special method in Python used to define how an object should behave when used in an iteration context.
# It should return an iterator object, which itself has a __next__ method, or in more modern Python.
# It can return an iterable object with its own __iter__ method.
class MyIterable:
    def __init__(self, start, end):
        self.start = start
        self.end = end

    def __iter__(self):
        # Return an iterator object (in this case, self)
        return self

    def __next__(self):
        # Define the behavior when iterating
        if self.start <= self.end:
            result = self.start
            self.start += 1
            return result
        else:
            # Raise StopIteration to signal the end of iteration
            raise StopIteration


# Example usage:
my_iterable = MyIterable(1, 5)

# Using the iterable in a for loop

# for item in my_iterable:
#     print(item)


# 15 '__add__'.
# The __add__ method is a special method in Python used to define the behavior
# of the addition operation (+) for instances of a class.
# When an object is combined with another using the + operator,
# Python internally calls the __add__ method of the left operand,
# passing the right operand as an argument.
class MyNumber:
    def __init__(self, value):
        self.value = value

    def __add__(self, other):
        # Define the behavior for the addition operation
        if isinstance(other, MyNumber):
            # If the other object is also an instance of MyNumber, add their values
            return MyNumber(self.value + other.value)
        else:
            # If the other object is not an instance of MyNumber, raise a TypeError
            raise TypeError("Unsupported operand type for +")


# Example usage:
num1 = MyNumber(5)
num2 = MyNumber(10)

add_result = num1 + num2
print("Result of addition:", add_result.value)




#  __delattr__',
# '__dir__',
# '__format__',
# '__getattribute__',
# '__hash__',
# '__init_subclass__',
# '__ne__',
# '__new__',
# '__reduce__',
# '__reduce_ex__',
# '__setattr__',
# '__sizeof__',
# '__subclasshook__'
