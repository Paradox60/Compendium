- ## 1️⃣ display: block

Поведение: занимает всю доступную ширину родителя.
Размещение: каждая такая «блоковая» штука начинается с новой строки.
Можно задавать: ширину (width), высоту (height), отступы (margin, padding).
Примеры: \<div>, \<p>, \<h1>.

``` html
<div style="background: red; width: 200px; height: 50px;">Block</div>
<div style="background: blue; width: 100px; height: 50px;">Block</div>
```
Первый div растянется на 200px, второй на 100px.
Каждый блок будет на новой строке.
<br>

- ## 2️⃣display: inline

Поведение: занимает только столько ширины, сколько нужно контенту.
Размещение: идёт в одну линию с другими inline-элементами.
Нельзя задавать: ширину и высоту (они игнорируются). Можно задавать горизонтальные отступы через margin-left/right.

Примеры: \<span>, \<a>, \<strong>.

```html
<span style="background: red;">Inline</span>
<span style="background: blue;">Inline</span>
```
Два спана будут рядом, ширина зависит от текста.
Высоту задавать нельзя, она определяется строкой текста.

- ## 3️⃣ display: inline-block

Гибрид между block и inline:

Как inline — элементы рядом друг с другом, не начинают новую строку.
Как block — можно задавать ширину и высоту.
Примеры: удобен для меню, карточек, кнопок.

```html
<div style="display: inline-block; width: 100px; height: 50px; background: red;">Box 1</div>
<div style="display: inline-block; width: 100px; height: 50px; background: blue;">Box 2</div>
```
Два блока будут рядом, каждый с шириной 100px и высотой 50px.
Можно комбинировать с vertical-align, чтобы выровнять их по базовой линии, верху или низу.

🔹 Краткая памятка
--- 

|Свойство     |	Новая строка |	Можно задать width/height  |       Пример       |
|-------------|--------------|-----------------------------|--------------------|
|block	      |      Да      | 	          Да	           |       div, p       |
|inline       |	     Нет	 |            Нет	           |       span, a      |
|inline-block |	     Нет	 |            Да	           | кнопки, мини-блоки |