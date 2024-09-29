def to_uppercase_decorator(func):
    def wrapper(word):
        # Преобразуем слово в верхний регистр
        uppercased_word = word.upper()
        # Вызываем исходную функцию с измененным словом
        return func(uppercased_word)
    return wrapper

def to_lowercase_decorator(func):
    def wrapper(word):
        # Преобразуем слово в верхний регистр
        uppercased_word = word.lower()
        # Вызываем исходную функцию с измененным словом
        return func(uppercased_word)
    return wrapper