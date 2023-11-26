'''
Numeric Types:
int: Integer type (e.g., 5, -10). IMMUTABLE
float: Floating-point type (e.g., 3.14, -0.5). IMMUTABLE
complex: Complex numbers (e.g., 1 + 2j). IMMUTABLE

Sequence Types:
str: String type (e.g., 'hello', "world"). IMMUTABLE
list: List type, an ordered and mutable collection (e.g., [1, 2, 3]). MUTABLE
tuple(kortej): Tuple type, an ordered and immutable collection (e.g., (1, 2, 3)). IMMUTABLE
range:Range type represents an immutable sequence of numbers IMMUTABLE

Set Types:
set(mnojestvo): Set type, an unordered collection of unique elements (e.g., {1, 2, 3}). MUTABLE
frozenset: Frozenset IMMUTABLE set ([1,2,3,4,5,6])

Mapping Type:
dict: Dictionary type, an unordered collection of key-value pairs (e.g., {'key': 'value'}).MUTABLE

Boolean Type:
bool: Boolean type, representing True or False. IMMUTABLE

None Type:
NoneType: The type of the None object, representing the absence of a value or a null value.

Binary Types:
bytes: Immutable sequence of bytes (e.g., b'hello'). IMMUTABLE
bytearray: Mutable sequence of bytes. MUTABLE
memoryview: A view object that exposes an array’s buffer interface.
'''
#Integer


def data_type(a):

    return print(type(a))

#Numeric Types: (#Immutable_ALL)
a = 5
b = 5.54
c = 1+2j

#Sequence Types:
a1 = "string"    #Immutable
b1 = [2,3,5,3]   #Mutable
c1 = (1,3,4,5)   #Immutable
d1 = range(5)   #Immutable

#Set
a2 = {1,3,4,3,2,'t','r'} #Mutable
b2 = ({2,3,4,5,3,2,4}) #Immutable

#Mapping Type:
a3 = {'first': "first", 'second': "second"} #Mutable




copy = a2
a2.append(8)

if id(copy) == id(a2):
    print("True")
else:
    print("False")

data_type(d1)




# Attempt to modify the object
