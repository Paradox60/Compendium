#!/bin/bash

echo "Введите название проекта:"
read project_name

# Создание структуры
mkdir -p "$project_name"/{static,templates}

# requirements.txt
cat > requirements.txt <<EOF
Flask>=2.0
EOF

cd "$project_name" || exit

# app.py
cat > app.py <<EOF
from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

# index.html
cat > templates/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to $project_name</title>
    <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
</head>
<body>
    <h1>Hello from Flask!</h1>
    <button onclick="greet()">Click me</button>

    <script src="{{ url_for('static', filename='script.js') }}"></script>
</body>
</html>
EOF

# style.css
cat > static/style.css <<EOF
body {
    font-family: Arial, sans-serif;
    background-color: #111;
    color: #eee;
    text-align: center;
    padding: 50px;
}

button {
    padding: 10px 20px;
    font-size: 16px;
}
EOF

# script.js
cat > static/script.js <<EOF
function greet() {
    alert("Привет от Flask + JS!");
}
EOF

echo "✅ Проект '$project_name' создан."
