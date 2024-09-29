from decorators import *
from dataType import *

# ----------------------------------Типы данных----------------------------------------------------


if __name__ == '__main__':
    print(a)





# ----------------------------------Работа с декораторами---------------------------------
word="СлоВо"

def print_original(word):
    print(word)

# Используем декоратор для изменения поведения функции
@to_uppercase_decorator
def print_uppercase(word):
    print(word)

@to_lowercase_decorator
def print_lowercase(word):
    print(word)






