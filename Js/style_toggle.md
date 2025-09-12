# Обращение к элементам

```js 
// Получить элемент по id
const element = document.getElementById('myElement');

// Получить элементы по классу (возвращает коллекцию)
const elements = document.getElementsByClassName('myClass');

// Получить элементы по селектору (современный способ)
const elements = document.querySelectorAll('.myClass');
```

# Добавление/удаление классов

```js
// Добавить класс
element.classList.add('hidden');

// Удалить класс
element.classList.remove('hidden');

// Переключить класс (добавить если нет, удалить если есть)
element.classList.toggle('hidden');

// Проверить наличие класса
if (element.classList.contains('hidden')) {
  // Действие если класс есть
}
```

# Использование data-атрибутов для пометки элементов

```html
<div class="product" data-category="electronics" data-price="150">
  Телевизор
</div>
<div class="product" data-category="books" data-price="20">
  Книга
</div>
```

```js
// Скрыть все электронные товары дороже 100
document.querySelectorAll('.product').forEach(product => {
  if (product.dataset.category === 'electronics' && 
      parseInt(product.dataset.price) > 100) {
    product.style.display = 'none';
  }
});
```