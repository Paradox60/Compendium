# 📂 Структура проекта (React Native)

Когда ты создаёшь проект через `npx react-native init MyApp`, примерно получаешь такую структуру:

MyApp/
│── android/                 | (код для Android (Java/Kotlin) - обычно не трогаем)
│── ios/                           | (код для iOS (Swift/Obj-C) - обычно не трогаем)
│── node_modules/   | установленные библиотеки
│── App.js                      | главный файл (точка входа React Native)
│── index.js                   | запускает App.js
│── package.json       | список зависимостей (npm/yarn)
│── babel.config.js    | конфигурация babel (трансформация JS)
│── metro.config.js    | конфигурация сборщика Metro


### 📂 Структура твоего кода

Ты можешь организовать файлы, как тебе удобно. Обычно так:

MyApp/
│── App.js              # главный компонент
│── src/                # папка с кодом
│   ├── screens/        # экраны приложения (HomeScreen, WordListScreen)
│   ├── components/     # маленькие переисп. куски (Card, Button)
│   ├── services/       # работа с API (axios запросы)
│   ├── store/          # состояние (Redux/Zustand/Context API)
│   ├── assets/         # картинки, шрифты
│   └── utils/          # утилиты (функции-помощники)




