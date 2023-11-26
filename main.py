import this

from middle import *

def print_main():
    print('Не основной файл')
# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    print_on()


class Cat:
    def where_am_i(self):
        print(self)

Tom = Cat()
Tom.where_am_i()
Catty = Cat()
Catty.where_am_i()
print(Tom>Catty)